# Use official Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy requirements first for caching
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Create directories for models and logs
RUN mkdir -p models logs

# Copy the rest of the app
COPY . .

# Set environment variable for Deriv API token (can be overridden in Render)
ENV DERIV_API_TOKEN=""

# Run the bot
CMD ["python", "main.py"]