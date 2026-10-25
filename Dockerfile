FROM python:3.11-slim

LABEL org.opencontainers.image.title="bloodpengu-python"
LABEL org.opencontainers.image.description="Data collector in Python for BloodPengu APM"
LABEL org.opencontainers.image.authors="Vineeth Kumar"
LABEL org.opencontainers.image.source="https://github.com/foxcornlab/gxc-BloodPengu.py"
LABEL org.opencontainers.image.licenses="Apache-2.0"

WORKDIR /app

COPY setup.py pyproject.toml README.md ./
COPY src/ ./src/

RUN pip install --no-cache-dir .

ENTRYPOINT ["bloodpengu-python"]
