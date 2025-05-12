FROM python:3.11-slim

WORKDIR /app

COPY app/ ./app
COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

RUN adduser --disabled-password --gecos '' appuser \
    && chown -R appuser /app

USER appuser

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]


#docker build -t rag-inference-api .
#docker run -p 8000:8000 rag-inference-api
#brew install aquasecurity/trivy/trivy
#trivy image rag-inference-api --format table --output security/trivy-report.txt
