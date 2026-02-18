from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import Dict, Any
import pandas as pd
import joblib

app = FastAPI(title="COVID-19 Screening API", version="1.0")

# Load once at startup (fast + professional)
artifact = joblib.load("covid_screening_api_artifact.joblib")
model = artifact["model"]
threshold = float(artifact["threshold"])
feature_names = artifact["feature_names"]

class PredictRequest(BaseModel):
    # Send features as a JSON object: {"Glucose": 120, "Age": 45, ...}
    features: Dict[str, Any]

@app.get("/health")
def health():
    return {"status": "ok"}

@app.post("/predict")
def predict(req: PredictRequest):
    try:
        # Create a 1-row DataFrame with the exact columns the model was trained on
        row = {col: req.features.get(col, None) for col in feature_names}
        X = pd.DataFrame([row])

        proba = float(model.predict_proba(X)[:, 1][0])
        pred = int(proba >= threshold)

        return {
            "prediction": pred,                 # 1 = positive, 0 = negative
            "probability_positive": round(proba, 6),
            "threshold_used": threshold
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Prediction failed: {e}")
