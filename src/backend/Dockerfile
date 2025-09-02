# Help from: https://github.com/cohere-ai/cohere-toolkit/blob/main/src/backend/Dockerfile

FROM python:3.11

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PYTHONIOENCODING=utf-8
ENV PYTHONPATH=/workspace/src/
ENV POETRY_VIRTUALENVS_IN_PROJECT=true

# Set pip cache directory for faster builds
ENV PIP_CACHE_DIR=/root/.cache/pip
ENV POETRY_CACHE_DIR=/root/.cache/poetry

ENV VIRTUAL_ENV=/workspace/.venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

WORKDIR /workspace

# Copy dependency files to avoid cache invalidations
COPY pyproject.toml poetry.lock ./

# Copy README.md for Poetry packaging
COPY README.md ./

COPY src/backend/ src/backend/

# Install poetry and dependencies with cache
RUN pip install poetry && poetry install

EXPOSE 8000

CMD ["uvicorn", "backend.main:app", "--host", "0.0.0.0", "--port", "8000"]
