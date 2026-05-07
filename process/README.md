# win-sgbd-migration

Proceso docker para aplicar cambios de `schema` y `data` sin tocar `objects` (SP/functions).

## Que hace

- Monitorea cambios en:
  - `schema/schema_erflow.sql`
  - `data/seed_erflow.sql`
- Detecta cambios por hash (SHA-256).
- Aplica primero schema y luego data.
- Guarda estado en tabla `__win_migration_state`.
- No ejecuta nada de `objects/` (por lo tanto no reemplaza SP/functions).

## Uso

1. Copiar variables:

```bash
cd process
cp .env.example .env
```

2. Ajustar credenciales en `.env`.

3. Levantar migrador:

```bash
docker compose up -d --build
```

4. Ver logs:

```bash
docker compose logs -f win-sgbd-migration
```

## Notas importantes

- Este proceso asume que `schema/schema_erflow.sql` y `data/seed_erflow.sql` ya estan sincronizados con Erflow.
- Si quieres "traer cambios de Erflow" antes de migrar, primero sincroniza esos archivos desde tu flujo MCP y luego el contenedor los aplicara automaticamente.
