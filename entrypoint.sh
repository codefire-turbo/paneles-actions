#!/bin/bash

set -e

echo "Setting up Maven cache..."

CACHE_KEY=${INPUT_MAVEN_CACHE_KEY}

echo "Restoring Maven dependencies from cache..."
mkdir -p "$MAVEN_CONFIG/repository"
if [ -d "/github/home/.cache/$CACHE_KEY" ]; then
  cp -r /github/home/.cache/$CACHE_KEY/* "$MAVEN_CONFIG/repository"
fi

echo "Running Maven build and tests..."
mvn clean install

echo "Saving Maven dependencies to cache..."
mkdir -p "/github/home/.cache/$CACHE_KEY"
cp -r "$MAVEN_CONFIG/repository/"* "/github/home/.cache/$CACHE_KEY"

echo "Build and test completed."
