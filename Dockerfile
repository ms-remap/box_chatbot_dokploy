FROM python:3.13-slim

WORKDIR /app

# System packages
RUN apt-get update && apt-get install -y \
    curl \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Install uv (Astral's uv CLI) for running FastAPI
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.local/bin:${PATH}"

# Copy project files
COPY pyproject.toml uv.lock ./
COPY src ./src
COPY box_chatbot.py ./box_chatbot.py

# Install dependencies into a virtual environment managed by uv
RUN uv sync --frozen

# Copy remaining files if any
COPY . .

# Default command: run FastAPI API server
CMD ["uv", "run", "box_chatbot:app", "--transport", "http", "--host", "0.0.0.0", "--port", "8006"]
