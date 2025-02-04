#!/bin/bash

# Check if overlayjs is installed
if ! command overlayjs &> /dev/null; then
  echo "Cannot find overlayjs. Need overlayjs to be installed."
  exit 1
fi

# Check if the OpenAPI file is provided
if [ -z "$1" ]; then
  echo "Usage: $0 '<open-api-file>'"
  exit 1
fi

open_api_file=$1
filename=$(basename "$open_api_file")

# Need to make some changes to the OAD before it can be used. See readme.md
overlayjs --openapi "${open_api_file}" --overlay prepare-oad.overlay.yaml > ./prepared-oads/"${filename}"

# Loop over all files in the test-overlays folder
for overlay_file in ./test-overlays/*; do
  echo "processing $overlay_file"
  overlay_filename=$(basename "$overlay_file")
  # Strip out both extensions
  base_name="${overlay_filename%%.*}"
  output_file="./test-oads/$base_name.yaml"
  # uncomment to see commands run.
  # echo "overlayjs --openapi \"./prepared-oads/$filename\" --overlay \"$overlay_file\" > \"$output_file\""
  overlayjs --openapi "./prepared-oads/$filename" --overlay "$overlay_file" > "$output_file"
done