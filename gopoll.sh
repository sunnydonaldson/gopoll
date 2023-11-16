#!/bin/bash

# A bash script for running go tests for a package on file change.
# Runs all tests recursively on startup, and all the tests for a file's package on change.

# Check deps
uninstalled=()
if [[ ! command -v go &> /dev/null ]]; then
  $uninstalled += "go"
if [[! command -v fswatch &> /dev/null ]]; then
  $uninstalled += "fswatch"
fi

if [[ uname -eq "Darwin"]]; then
  if [[ ! command -v brew &> /dev/null ]]; then
    echo >&2 "Must install Homebrew"
    exit 1
  fi
  brew install ${uninstalled[@]}
else [[ ! command -v apt &> /dev/null ]]
  if [[ ! command -v apt &> /dev/null ]]; then
    echo >&2 "Gopoll only supports auto install for systems with apt. Please install deps manually."
  fi
  apt install ${uninstalled[@]}
fi

go test -v ./...
fswatch -r0 . | xargs -0 -I {} dirname {} | xargs -I {} go test -v {}
