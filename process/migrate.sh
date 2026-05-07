#!/usr/bin/env bash
set -euo pipefail
# shellcheck shell=bash

DB_HOST="${DB_HOST:-host.docker.internal}"
DB_PORT="${DB_PORT:-3306}"
DB_NAME="${DB_NAME:-bdsgn}"
DB_USER="${DB_USER:-root}"
DB_PASSWORD="${DB_PASSWORD:-root}"
POLL_INTERVAL_SECONDS="${POLL_INTERVAL_SECONDS:-20}"
APPLY_ON_START="${APPLY_ON_START:-1}"

SCHEMA_FILE="/workspace/schema/schema_erflow.sql"
DATA_FILE="/workspace/data/seed_erflow.sql"

mysql_exec() {
  mysql \
    -h "${DB_HOST}" \
    -P "${DB_PORT}" \
    -u"${DB_USER}" \
    -p"${DB_PASSWORD}" \
    "${DB_NAME}" \
    "$@"
}

wait_for_db() {
  echo "[migration] Waiting for MySQL ${DB_HOST}:${DB_PORT}/${DB_NAME} ..."
  until mysql_exec -e "SELECT 1;" >/dev/null 2>&1; do
    sleep 2
  done
  echo "[migration] MySQL is ready."
}

ensure_state_table() {
  mysql_exec -e "
    CREATE TABLE IF NOT EXISTS __win_migration_state (
      file_key VARCHAR(100) NOT NULL PRIMARY KEY,
      file_hash CHAR(64) NOT NULL,
      updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
    ) ENGINE=InnoDB;
  "
}

file_hash() {
  local file_path="$1"
  sha256sum "${file_path}" | awk '{print $1}'
}

stored_hash() {
  local key="$1"
  mysql_exec -Nse "SELECT file_hash FROM __win_migration_state WHERE file_key='${key}' LIMIT 1;" || true
}

save_hash() {
  local key="$1"
  local hash="$2"
  mysql_exec -e "
    INSERT INTO __win_migration_state (file_key, file_hash)
    VALUES ('${key}', '${hash}')
    ON DUPLICATE KEY UPDATE file_hash='${hash}';
  "
}

apply_if_changed() {
  local key="$1"
  local file_path="$2"

  if [[ ! -f "${file_path}" ]]; then
    echo "[migration] Skip ${key}: file not found (${file_path})."
    return 0
  fi

  local new_hash
  local old_hash
  new_hash="$(file_hash "${file_path}")"
  old_hash="$(stored_hash "${key}")"

  if [[ "${new_hash}" == "${old_hash}" ]]; then
    echo "[migration] No changes in ${key}."
    return 0
  fi

  echo "[migration] Applying ${key} from ${file_path} ..."
  mysql_exec < "${file_path}"
  save_hash "${key}" "${new_hash}"
  echo "[migration] ${key} applied."
}

main_loop() {
  local first_run=1
  while true; do
    if [[ "${first_run}" -eq 1 && "${APPLY_ON_START}" != "1" ]]; then
      echo "[migration] APPLY_ON_START=0, first scan without apply."
    else
      # Keep order: schema first, then seed data.
      apply_if_changed "schema_erflow" "${SCHEMA_FILE}"
      apply_if_changed "seed_erflow" "${DATA_FILE}"
    fi

    first_run=0
    sleep "${POLL_INTERVAL_SECONDS}"
  done
}

wait_for_db
ensure_state_table
main_loop
