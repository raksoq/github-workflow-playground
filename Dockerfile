# Stage 1: Build
FROM python:3.10-slim AS build

WORKDIR /app

# Copy requirements.txt from the src folder
COPY src/ /app/

# Install dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy the application source code
COPY src/ /app/src

# Stage 2: Run
FROM python:3.10-slim

WORKDIR /app

# Copy everything from the build stage
COPY --from=build /app /app

# Start the application
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "80"]
