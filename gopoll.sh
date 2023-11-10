#!/bin/bash

# A bash script for running go tests for a package on file change.
# Runs all tests recursively on startup, and all the tests for a file's package on change.

go test -v ./...
fswatch -r0 ~/Documents/projects/heimdall | xargs -0 -I {} dirname {} | xargs -I {} go test -v {}
