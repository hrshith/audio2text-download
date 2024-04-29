# Use an base image with Python and Git installed
FROM python:3.11

# Set working directory
WORKDIR /app

# Set environment variable for Flask app
ENV FLASK_APP=text.py

ENV PATH="/root/.local/bin:${PATH}"

# install apps
RUN apt update && apt-get install -y git ffmpeg

# Copy requirements.txt to the working directory
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# install whisper inside container
RUN pip install git+https://github.com/openai/whisper.git

# Copy application code
COPY . .

# Expose port 5000 for HTTP
EXPOSE 5000

# run the app
ENTRYPOINT ["python", "-m", "flask", "run", "--host=0.0.0.0", "--port=5000"]
