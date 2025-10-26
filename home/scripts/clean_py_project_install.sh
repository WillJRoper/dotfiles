#!/usr/bin/env sh

# Clean previously compiled files
rm -rf build
rm -rf dist
rm -rf *.egg-info
find . -name "*.so" -delete
find . -name "*.pyd" -delete
