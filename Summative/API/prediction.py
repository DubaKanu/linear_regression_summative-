import pandas as pd
import joblib
import os
from typing import List

# Get the directory where this script is located (important for deployment)
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# Define the filenames based on the saved model from Task 1
MODEL_FILENAME = 'Linear_Regression_(SGD)_model.joblib' 

# Construct absolute paths to load assets reliably
MODEL_PATH = os.path.join(BASE_DIR, MODEL_FILENAME)
SCALER_PATH = os.path.join(BASE_DIR, 'scaler.joblib')
FEATURES_PATH = os.path.join(BASE_DIR, 'feature_names.joblib')

# Load the saved model assets globally once when the API starts
try:
    LOADED_MODEL = joblib.load(MODEL_PATH)
    LOADED_SCALER = joblib.load(SCALER_PATH)
    FEATURE_NAMES: List[str] = joblib.load(FEATURES_PATH)
    print("Model assets loaded successfully.")
except FileNotFoundError as e:
    print(f"Error loading model assets. Ensure {MODEL_FILENAME}, scaler.joblib, and feature_names.joblib are in the API directory.")
    raise e


def make_prediction_script(data: dict) -> float:
    """
    Processes the incoming request data and uses the loaded model to make a prediction.
    """
    # 1. Convert input to DataFrame
    input_df = pd.DataFrame([data])
    
    # 2. Handle 'Country' (One-Hot Encoding)
    # The 'Country' column is the only non-numeric input.
    input_encoded = pd.get_dummies(input_df, columns=['Country'])
    
    # 3. Align columns with the training data (CRITICAL FOR API)
    final_input = pd.DataFrame(0, index=[0], columns=FEATURE_NAMES)
    for col in input_encoded.columns:
        if col in final_input.columns:
            final_input[col] = input_encoded[col]
            
    # 4. Standardize the input data
    input_scaled = LOADED_SCALER.transform(final_input)
    
    # 5. Make prediction
    prediction = LOADED_MODEL.predict(input_scaled)
    
    return float(prediction[0])