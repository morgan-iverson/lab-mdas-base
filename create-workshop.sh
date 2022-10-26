#!/bin/bash

set -eo pipefail

SCRIPTS_DIR=$(
    cd "$(dirname $BASH_SOURCE)"
    pwd
)

TEMPLATE_DIR=$(dirname $0)/template
OVERLAYS_DIR=$(dirname $0)/overlays

WORKSHOP_NAME=""
OUTPUT_DIR=""
TEXT_FORMAT="markdown"

EXTRA_ARGS=()

while [[ $# -gt 0 ]]; do
  case $1 in
  -o | --output)
    OUTPUT_DIR="$2"
    shift # past argument
    shift # past value
    ;;
  --text-format)
    TEXT_FORMAT="$2"
    shift # past argument
    shift # past value
    ;;
  --overlay)
    if [ -d $OVERLAYS_DIR/$2 ]; then
      EXTRA_ARGS+=("--file")
      EXTRA_ARGS+=("$OVERLAYS_DIR/$2")
    fi
    shift # past argument
    shift # past value
    ;;
  -v | --data-value)
    EXTRA_ARGS+=("$1")
    EXTRA_ARGS+=("$2")
    shift # past argument
    shift # past value
    ;;
  --data-value-yaml)
    EXTRA_ARGS+=("$1")
    EXTRA_ARGS+=("$2")
    shift # past argument
    shift # past value
    ;;
  -* | --*)
    echo "Unknown option $1"
    exit 1
    ;;
  *)
    WORKSHOP_NAME="$1"
    shift # past argument
    ;;
  esac
done

if [[ "$WORKSHOP_NAME" == "" ]]; then
  echo "Error: Workshop name not specified." 1>&2
  exit 1
fi

if [[ "$OUTPUT_DIR" == "" ]]; then
  OUTPUT_DIR="."
fi

WORKSHOP_DIR=$OUTPUT_DIR/$WORKSHOP_NAME

if [[ "$TEXT_FORMAT" == "asciidoc" ]]; then
  EXTRA_ARGS+=("--file-mark")
  EXTRA_ARGS+=("workshop/content/**/*.md:exclude=true")
else
  EXTRA_ARGS+=("--file-mark")
  EXTRA_ARGS+=("workshop/content/**/*.adoc:exclude=true")
fi

# Use ytt as means of processing the template and optional overlays.

ytt --file $TEMPLATE_DIR \
  --file-mark '**/*:type=text-plain' \
  --file-mark '**/*.md:type=text-template' \
  --file-mark '**/*.yaml:type=yaml-template' \
  --file-mark 'Dockerfile:type=text-template' \
  --file-mark 'Makefile:type=text-template' \
  "${EXTRA_ARGS[@]}" \
  --data-value workshop.name="$WORKSHOP_NAME" \
  --output-files="$WORKSHOP_DIR"

# Restore the GitHub actions workflow for publishing a workshop. This had to
# exist in the repository .github/workflows directory as it isn't possible to
# add or modify a workflow, only delete, from a GitHub action when using this
# repisitory as a GitHub repository template. This is why it is part of the
# repository and not the template subdirectory.

mkdir -p $WORKSHOP_DIR/.github/workflows

cp $SCRIPTS_DIR/.github/workflows/publish-workshop.yaml $WORKSHOP_DIR/.github/workflows/

# Currently ytt doesn't preserve permissions from original files so we need to
# fix up permissions ourselves. Execute bit for files will only be done for
# files in certain locations where know they should be executable.

find "$WORKSHOP_DIR" -type d -exec chmod og+rx {} \;
find "$WORKSHOP_DIR" -type f -exec chmod u=rw,og=r {} \;

test -d "$WORKSHOP_DIR/bin" && chmod -f +x $WORKSHOP_DIR/bin/* || true
test -d "$WORKSHOP_DIR/workshop/setup.d" && chmod -f +x $WORKSHOP_DIR/workshop/setup.d/* || true
