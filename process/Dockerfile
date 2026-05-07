FROM mysql:8.0

WORKDIR /app

COPY migrate.sh /app/migrate.sh

# Normalize Windows CRLF to LF to avoid bash option parsing errors.
RUN sed -i 's/\r$//' /app/migrate.sh && chmod +x /app/migrate.sh

CMD ["bash", "/app/migrate.sh"]
