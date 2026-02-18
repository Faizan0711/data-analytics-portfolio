🦠 COVID-19 Screening API

Logistic Regression Model Optimized for False Negative Reduction

📌 Project Overview

This project trains and deploys a Logistic Regression model for COVID-19 screening using FastAPI.

The model is optimized to reduce false negatives, making it suitable for screening contexts where missing a positive case is costly.

The trained pipeline (preprocessing + model) is exposed as a REST API endpoint for real-time inference.

🧠 Model Architecture

Algorithm: Logistic Regression

Preprocessing:

Numerical → SimpleImputer + StandardScaler

Categorical → OneHotEncoder

Evaluation Metric Focus:

False Negative Rate

Custom Classification Threshold: 0.20 (instead of default 0.50)

🚀 Running the API Locally
1️⃣ Clone Repository
git clone <your-repo-url>
cd <repo-folder>

2️⃣ Create Virtual Environment (Recommended)
python -m venv .venv
.venv\Scripts\activate

3️⃣ Install Dependencies
pip install -r requirements.txt

4️⃣ Run FastAPI Server
uvicorn app:app --reload


Server runs at:

http://127.0.0.1:8000

📚 Interactive API Documentation

Open:

http://127.0.0.1:8000/docs


This provides automatic Swagger UI for testing endpoints.

🔍 API Endpoints
✅ Health Check
GET /health


Response:

{
  "status": "ok"
}

📋 Get Expected Feature Names
GET /features


Returns the list of model input features.

🔮 Prediction Endpoint
POST /predict

Example Request
{
  "features": {
    "Age": 45,
    "Fever": 1,
    "Cough": 1
  }
}

Example Response
{
  "prediction": 1,
  "label": "positive",
  "probability_positive": 0.264343,
  "threshold_used": 0.2
}

⚙️ Inference Workflow

Receive JSON request

Convert input into Pandas DataFrame

Apply saved preprocessing pipeline

Generate probability

Apply custom threshold

Return JSON response

🏗 Deployment Architecture
Client Request
      ↓
FastAPI Server
      ↓
Preprocessing Pipeline
      ↓
Logistic Regression Model
      ↓
Threshold Decision
      ↓
JSON Response

🛡 Design & Engineering Considerations

Model loaded once at application startup

Complete pipeline saved using joblib

Version-pinned dependencies to prevent compatibility issues

Threshold tuning optimized for healthcare screening context

Separation between training and inference logic

⚠️ Important Note

This model is for educational demonstration purposes only and should not be used for real medical diagnosis.
