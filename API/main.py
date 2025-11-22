from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field
from prediction import make_prediction_script # Import the prediction function

# -----------------------------------------------------------
# Pydantic Model with Data Types and Range Constraints (Mandatory)
# -----------------------------------------------------------

class PredictionInput(BaseModel):
    """
    Defines the structure, data types, and range constraints for the API input.
    """
    Country: str = Field(..., description="African country name (e.g., Nigeria, Malawi). Must be a string.")
    
    # All % of GDP values must be floats and fall within a realistic range
    final_consumption_expenditure: float = Field(
        ..., 
        alias='Final consumption expenditure (% of GDP)',
        gt=50.0, # Greater than 50%
        le=150.0, # Less than or equal to 150% (allowing for high public spending)
        description="Final consumption expenditure as % of GDP (50.0 to 150.0)"
    )
    gross_capital_formation: float = Field(
        ...,
        alias='Gross capital formation (% of GDP)',
        gt=0.0, 
        le=50.0, # Up to 50%
        description="Gross capital formation as % of GDP (0.0 to 50.0)"
    )
    exports: float = Field(
        ...,
        alias='Exports of goods and services (% of GDP)',
        ge=0.0, 
        le=150.0, # Allowing for high export dependence
        description="Exports as % of GDP (0.0 to 150.0)"
    )
    imports: float = Field(
        ...,
        alias='Imports of goods and services (% of GDP)',
        ge=0.0, 
        le=150.0,
        description="Imports as % of GDP (0.0 to 150.0)"
    )
    fiscal_balance: float = Field(
        ...,
        alias='Central government, Fiscal Balance (% of GDP)',
        ge=-20.0, # Allowing for large deficits
        le=10.0, # Allowing for surpluses
        description="Central government Fiscal Balance as % of GDP (-20.0 to 10.0)"
    )
    
    # Configuration for using dictionary keys directly (optional, but good practice)
    class Config:
        populate_by_name = True


# Initialize FastAPI App
app = FastAPI(
    title="African GDP Growth Prediction API",
    description="API for predicting Real per Capita GDP Growth Rate based on economic indicators."
)

# -----------------------------------------------------------
# Add CORS Middleware (Mandatory)
# -----------------------------------------------------------

origins = ["*"] # Allow all origins for the Flutter app development

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# -----------------------------------------------------------
# API Endpoint (Mandatory POST request)
# -----------------------------------------------------------

@app.post("/predict_gdp_growth", response_model=float, summary="Predict Real per Capita GDP Growth Rate")
def predict_gdp(input_data: PredictionInput):
    """
    Accepts economic indicators and returns the predicted GDP growth rate.
    """
    try:
        # Convert the Pydantic model back to a dictionary using field aliases (mandatory for prediction script)
        # Pydantic's model.dict() automatically validates input data types and ranges.
        data_dict = input_data.dict(by_alias=True)
        
        # Call the prediction script from Task 1
        prediction_result = make_prediction_script(data_dict)
        
        return prediction_result
    
    except Exception as e:
        # Raise a 500 Internal Server Error if the prediction function fails
        raise HTTPException(status_code=500, detail=f"Prediction failed due to an internal error: {str(e)}")