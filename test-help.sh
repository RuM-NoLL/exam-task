#!/bin/bash

echo "Running help tests for cutline..."
echo "Test 1: cutline -h" > output-help.txt
./cutline -h >> output-help.txt 2>&1
echo -e "\n---\nTest 2: cutline --help" >> output-help.txt
./cutline --help >> output-help.txt 2>&1

echo "Help tests completed. Output saved to output-help.txt"
echo "=== Output content ==="
cat output-help.txt
