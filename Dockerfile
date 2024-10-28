# Stage 1: Build
FROM python:3.10-slim AS build

WORKDIR /app

# Copy the application source code (only the contents of src)
COPY src/ /app/

# Install dependencies
RUN pip install --upgrade pip && pip install -r /app/requirements.txt

# Stage 2: Run
FROM python:3.10-slim

WORKDIR /app

# Copy only the installed packages and application code from the build stage
COPY --from=build /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages
COPY --from=build /usr/local/bin /usr/local/bin
COPY --from=build /app /app

# Create a non-root user and switch to it
RUN adduser --disabled-password appuser
USER appuser

# Expose the application port
EXPOSE 80

# Start the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
