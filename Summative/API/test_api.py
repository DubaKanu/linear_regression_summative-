#!/usr/bin/env python3
"""
Simple test script to verify the API works locally
"""
import requests
import json

# Test data
test_data = {
    "Country": "Nigeria",
    "Final consumption expenditure (% of GDP)": 80.5,
    "Gross capital formation (% of GDP)": 15.2,
    "Exports of goods and services (% of GDP)": 25.3,
    "Imports of goods and services (% of GDP)": 30.1,
    "Central government, Fiscal Balance (% of GDP)": -3.5
}

def test_prediction_endpoint():
    """Test the prediction endpoint"""
    url = "http://localhost:8000/predict_gdp_growth"
    
    try:
        response = requests.post(url, json=test_data)
        
        if response.status_code == 200:
            result = response.json()
            print(f"✅ Prediction successful: {result}")
            return True
        else:
            print(f"❌ Error {response.status_code}: {response.text}")
            return False
            
    except requests.exceptions.ConnectionError:
        print("❌ Could not connect to API. Make sure the server is running.")
        return False
    except Exception as e:
        print(f"❌ Unexpected error: {e}")
        return False

if __name__ == "__main__":
    print("Testing API endpoint...")
    test_prediction_endpoint()