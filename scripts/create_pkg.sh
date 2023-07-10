#!/bin/bash
echo "Executing create_pkg.sh..."
cd "$path_cwd" || exit
dir_name="lambda_dist_pkg/"
mkdir -p "$dir_name"
# Create and activate virtual environment...
virtualenv -p "$RUNTIME" "env_$FUNCTION_NAME"
source "env_$FUNCTION_NAME/bin/activate"
# Install Python dependencies...
FILE="$path_cwd/dependencies/requirements.txt"
if [ -f "$FILE" ]; then
  echo "Installing dependencies..."
  echo "From: requirements.txt file exists..."
  pip install -r "$FILE"
else
  echo "Error: requirements.txt does not exist!"
  exit 1
fi
# Deactivate virtual environment...
deactivate
# Create deployment package...
echo "Creating deployment package..."
cd "env_$FUNCTION_NAME/lib/$RUNTIME/site-packages/" || exit
cp -r . "$path_cwd/$dir_name"
cp -r "$path_cwd/dependencies/" "$path_cwd/$dir_name"
# Remove virtual environment folder...
echo "Removing virtual environment folder..."
rm -rf "$path_cwd/env_$FUNCTION_NAME"
echo "Finished script execution!"
