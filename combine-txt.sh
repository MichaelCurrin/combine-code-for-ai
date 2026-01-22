#!/bin/bash

USAGE="Usage: $0 <target_dir> [--min]
  <target_dir>    Directory to process (git tracked files only)
  --min           Truncate each file to first 10 lines"

TARGET="$1"
MIN_VERSION=false

if ! command -v tree &> /dev/null; then
  echo 'Error: `tree` command not found. Please install it first.'
  exit 1
fi

if [[ -z "$TARGET" ]]; then
  echo "$USAGE"
  exit 1
fi

if [[ -n "$2" ]]; then
  case "$2" in
    --min)
      MIN_VERSION=true
      ;;
    *)
      echo "Unknown option: $2"
      echo "$USAGE"
      exit 1
      ;;
  esac
fi

# Structure

echo 'Directory structure:'
(cd "$TARGET" && tree . --gitignore --noreport)

# Content

INPUT_FILES=$(git -C "$TARGET" ls-files | while read FILE; do
  MIME_TYPE=$(file -b --mime "$TARGET/$FILE")
  if echo "$MIME_TYPE" | grep -Eq "^text/"; then
    echo "$TARGET/$FILE"
  fi
done)

TEXT_FILES_ARRAY=($(echo "$INPUT_FILES" | tr '\n' ' '))

echo
echo "Files analized: ${#TEXT_FILES_ARRAY[@]}"

OUTPUT=""
for FILE_PATH in "${TEXT_FILES_ARRAY[@]}"; do
  if [[ -n "$FILE_PATH" ]]; then
    if [[ "$MIN_VERSION" == true ]]; then
      CONTENT=$(head -n 10 "$FILE_PATH")
    else
      CONTENT=$(cat "$FILE_PATH")
    fi
    RELATIVE_PATH="${FILE_PATH#$TARGET/}"
    OUTPUT+="$(
      cat <<-END_OUTPUT

================================================
FILE: $RELATIVE_PATH
================================================

$CONTENT

END_OUTPUT
)
"
  fi
done

echo "$OUTPUT"
