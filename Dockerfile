FROM python:3.10-slim AS build

WORKDIR /app

COPY src/ /app/src

RUN pip install -r requirements.txt

# Stage 2: Run
FROM python:3.10-slim

WORKDIR /app

COPY --from=build /app /app

CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "80"]