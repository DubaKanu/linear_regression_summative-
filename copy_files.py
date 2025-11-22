import shutil
import os

# Copy model files from linear_regression to API folder
source_dir = "linear_regression"
dest_dir = "API"

files_to_copy = [
    "Linear_Regression_(SGD)_model.joblib",
    "scaler.joblib", 
    "feature_names.joblib"
]

for file in files_to_copy:
    source = os.path.join(source_dir, file)
    dest = os.path.join(dest_dir, file)
    if os.path.exists(source):
        shutil.copy2(source, dest)
        print(f"Copied {file}")
    else:
        print(f"File not found: {source}")

print("File copying complete!")