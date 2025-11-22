# GDP Prediction Flutter App

A Flutter mobile application for predicting African GDP growth rates using economic indicators.

## Features

- Input form with validation for economic indicators
- Real-time API integration with the FastAPI backend
- Clean, user-friendly interface
- Error handling and loading states
- Responsive design

## Setup Instructions

1. **Install Flutter**: Make sure you have Flutter SDK installed on your system
2. **Get Dependencies**: Run `flutter pub get` in the project directory
3. **Update API URL**: In `lib/main.dart`, update the `apiUrl` variable with your deployed API endpoint
4. **Run the App**: Use `flutter run` to start the application

## API Integration

The app connects to the FastAPI backend created in Task 2. Make sure to:
- Update the API URL in the code
- Ensure your API is running and accessible
- The API should accept POST requests to `/predict_gdp_growth`

## Input Fields

- **Country**: African country name
- **Final Consumption Expenditure**: 50.0 - 150.0% of GDP
- **Gross Capital Formation**: 0.0 - 50.0% of GDP
- **Exports**: 0.0 - 150.0% of GDP
- **Imports**: 0.0 - 150.0% of GDP
- **Fiscal Balance**: -20.0 - 10.0% of GDP

## Running the App

```bash
flutter pub get
flutter run
```

For web deployment:
```bash
flutter build web
```

For Android APK:
```bash
flutter build apk
```