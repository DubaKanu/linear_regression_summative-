# African GDP Growth Prediction System

## Mission and Problem Statement
This project aims to predict GDP growth rates for African countries using economic indicators to support policy makers and investors in making informed decisions. The system addresses the challenge of forecasting economic performance in developing African economies where traditional prediction models often fail due to unique economic structures. By analyzing key economic factors like consumption expenditure, capital formation, exports, imports, and fiscal balance, the model provides accurate GDP growth predictions. This tool enables better economic planning and investment strategies for sustainable development across Africa.

## Dataset Description
**Source**: World Bank Open Data - African Economic Indicators (2000-2023)  
**Volume**: 1,200+ records covering 54 African countries over 23 years  
**Features**: 6 economic indicators including consumption expenditure, capital formation, trade balance, and fiscal metrics

## API Endpoint
**Live API**: https://api-tyky.onrender.com/predict_gdp_growth  
**Swagger Documentation**: https://api-tyky.onrender.com/docs

## Video Demo
**YouTube Link**: [5-minute Demo Video](https://youtu.be/BQ0HbM9BUS0)

## Setup Instructions

### Prerequisites
- Python 3.8+
- Flutter SDK (3.0+)
- Android Studio or VS Code
- Git

### 1. Clone Repository
```bash
git clone https://github.com/DubaKanu/linear_regression_summative-.git
cd linear_regression_summative-
```

### 2. Machine Learning Model Setup
```bash
cd Summative/linear_regression

# Create virtual environment
python -m venv venv

# Activate virtual environment
# Windows:
venv\Scripts\activate
# macOS/Linux:
source venv/bin/activate

# Install dependencies
pip install jupyter pandas numpy scikit-learn matplotlib seaborn joblib

# Run Jupyter notebook
jupyter notebook multivariate.ipynb
```

### 3. API Setup
```bash
cd ../API

# Install API dependencies
pip install -r requirements.txt

# Run API locally
uvicorn main:app --reload

# API will be available at: http://127.0.0.1:8000
# Swagger docs at: http://127.0.0.1:8000/docs
```

### 4. Flutter Mobile App Setup
```bash
cd ../FlutterApp

# Install Flutter dependencies
flutter pub get

# Run on connected device/emulator
flutter run

# Or run on specific platform
flutter run -d android
flutter run -d ios
```

### Using the Mobile App
1. Enter country name (e.g., Nigeria, Malawi)
2. Input economic indicators within specified ranges:
   - Final Consumption Expenditure: 50.0 - 150.0%
   - Gross Capital Formation: 0.0 - 50.0%
   - Exports: 0.0 - 150.0%
   - Imports: 0.0 - 150.0%
   - Fiscal Balance: -20.0 - 10.0%
3. Tap "Predict GDP Growth" to get results

### API Requirements (requirements.txt)
```
fastapi==0.104.1
uvicorn==0.24.0
pydantic==2.5.0
scikit-learn==1.3.2
joblib==1.3.2
pandas==2.1.4
numpy==1.24.3
```

## Project Structure
```
linear_regression_summative-/
├── README.md
└── Summative/
    ├── linear_regression/
    │   ├── multivariate.ipynb          # ML model training
    │   ├── Linear_Regression_(SGD)_model.joblib
    │   ├── scaler.joblib
    │   ├── feature_names.joblib
    │   └── ObservationData_lavlqce.csv
    ├── API/
    │   ├── main.py                     # FastAPI application
    │   ├── prediction.py               # Prediction logic
    │   ├── requirements.txt            # Python dependencies
    │   ├── Procfile                    # Deployment config
    │   └── render.yaml                 # Render deployment
    └── FlutterApp/
        ├── lib/
        │   └── main.dart               # Flutter app code
        ├── pubspec.yaml                # Flutter dependencies
        └── android/                    # Android configuration
```

## Troubleshooting

### Common Issues
1. **Flutter build fails**: Run `flutter clean && flutter pub get`
2. **API connection error**: Ensure API is running or use deployed URL
3. **Model loading error**: Check if model files exist in API directory
4. **Android embedding error**: Recreate android folder with `flutter create --platforms android .`