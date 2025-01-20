#!/bin/bash

echo "[INFO] Downloading the main script from GitHub..."

curl -sSL -o /tmp/main_script.sh "https://github.com/lys0611/data_analysis_curriculum/raw/refs/heads/main/main_script.sh"

if [ -f /tmp/main_script.sh ]; then
  chmod +x /tmp/main_script.sh
  echo "[INFO] main_script.sh downloaded and made executable. Running now..."
  /tmp/main_script.sh
  echo "[INFO] main_script.sh run completed."
else
  echo "[ERROR] Failed to download main_script.sh from GitHub."
  exit 1
fi
