from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from transformers import pipeline
from loguru import logger
from prometheus_fastapi_instrumentator import Instrumentator

app = FastAPI()

logger.add("logs/sample.log", format="{time} {level} {message}", level="INFO", serialize=True)


class PredictionInput(BaseModel):
    text: str


try:
    logger.info("Loading model: distilbert-base-uncased")
    nlp_pipeline = pipeline("feature-extraction", model="distilbert-base-uncased")
    logger.info("Model loaded successfully")
except Exception as e:
    logger.error(f"Model loading failed: {e}")
    raise

@app.post("/predict")
def predict(input_data: PredictionInput):
    try:
        logger.info(f"Received prediction request: {input_data.text}")
        output = nlp_pipeline(input_data.text)
        return {"embedding": output[0][0][:5]}  # Truncated for simplicity
    except Exception as e:
        logger.error(f"Prediction error: {e}")
        raise HTTPException(status_code=500, detail="Prediction failed")


Instrumentator().instrument(app).expose(app)
