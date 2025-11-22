# GDP Growth Prediction API

This FastAPI application provides an endpoint to predict Real per Capita GDP Growth Rate based on economic indicators for African countries.

## Files Structure
- `main.py` - FastAPI application with CORS middleware and Pydantic validation
- `prediction.py` - Prediction logic using the trained model
- `requirements.txt` - Required Python packages
- `run_api.py` - Script to start the server
- `test_api.py` - Test script to verify API functionality
- Model files: `Linear_Regression_(SGD)_model.joblib`, `scaler.joblib`, `feature_names.joblib`

## Running Locally

1. Install dependencies:
```bash
pip install -r requirements.txt
```

2. Start the server:
```bash
python run_api.py
```

3. Access the API:
- API: http://localhost:8000
- Swagger UI: http://localhost:8000/docs

## API Endpoint

**POST** `/predict_gdp_growth`

### Input Parameters (with validation):
- `Country`: String - African country name
- `Final consumption expenditure (% of GDP)`: Float (50.0 to 150.0)
- `Gross capital formation (% of GDP)`: Float (0.0 to 50.0)
- `Exports of goods and services (% of GDP)`: Float (0.0 to 150.0)
- `Imports of goods and services (% of GDP)`: Float (0.0 to 150.0)
- `Central government, Fiscal Balance (% of GDP)`: Float (-20.0 to 10.0)

### Response:
Returns a float representing the predicted Real per Capita GDP Growth Rate.

## Example Request:
```json
{
  "Country": "Nigeria",
  "Final consumption expenditure (% of GDP)": 80.5,
  "Gross capital formation (% of GDP)": 15.2,
  "Exports of goods and services (% of GDP)": 25.3,
  "Imports of goods and services (% of GDP)": 30.1,
  "Central government, Fiscal Balance (% of GDP)": -3.5
}
```