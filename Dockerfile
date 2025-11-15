# Use official Python image
FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        libgomp1 \
        wget \
        git \
        curl \
        ca-certificates \
        libssl-dev \
        libffi-dev \
        python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements first for caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Create directories for models and logs
RUN mkdir -p models logs

# Copy the rest of the bot code
COPY . .

# Environment variable for Deriv API token (replace in Render dashboard)
ENV DERIV_API_TOKEN=""

# Expose port (optional if your bot runs a web server)
EXPOSE 8080

# Run the bot
CMD ["python", "main.py"]
