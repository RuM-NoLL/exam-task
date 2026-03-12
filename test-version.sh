#!/bin/bash

echo "Test 1: cutline -v" > output-version.txt
./cutline -v >> output-version.txt 2>&1
echo "Test 2: cutline --version" >> output-version.txt
./cutline --version >> output-version.txt 2>&1

cat output-version.txt
