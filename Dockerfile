FROM python:3.13-slim

WORKDIR /app

# Install system packages
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir fastapi uvicorn requests pydantic

# Copy the chatbot script
COPY box_chatbot.py ./box_chatbot.py

# Expose port for API
EXPOSE 8006

# Default command: run API server
CMD ["uvicorn", "box_chatbot:app", "--host", "0.0.0.0", "--port", "8006"]
