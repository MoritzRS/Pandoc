#!/bin/sh

# "podman" or "docker"
CONTAINER="podman";

# Image name
IMAGE="pandoc";

# Build the image if it does not exist
if [ -z "$($CONTAINER images -q $IMAGE 2> /dev/null)" ]; then
    $CONTAINER build --platform linux/amd64 -t $IMAGE:latest -f ./Containerfile .;
fi

# Create the output directory
mkdir -p dist

# Build the document in the container
$CONTAINER run --rm \
    --platform linux/amd64 \
    --volume $(pwd):/data:ro \
    --volume $(pwd)/dist:/data/dist \
    $IMAGE pandoc content/document.md \
        --resource-path content \
        --lua-filter content/filters/abstract-section.lua \
        --lua-filter content/filters/page-break.lua \
        --filter pandoc-crossref \
        --citeproc \
        --csl content/citations/ieee.csl \
        --template content/template/template.tex \
        --output dist/document.pdf
