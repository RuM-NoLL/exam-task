#!/bin/bash

echo "Running cutline functionality tests..."

# Создаем тестовые файлы с длинными строками
echo "Creating test files..."

# Файл 1: строки разной длины
cat > test1.txt << EOF
This is a short line.
This line is exactly 30 characters!!
This line is definitely longer than thirty characters, let's count them.
Short.
Another line that should be truncated because it's too long for our program.
EOF

# Файл 2: больше тестовых данных
cat > test2.txt << EOF
123456789012345678901234567890
1234567890123456789012345678901234567890
A
BB
CCC
Line with tab\tcharacter
Special chars: !@#$%^&*()_+
EOF

echo "Test 1: cutline test1.txt" > output-cutline.txt
echo "=== test1.txt content (original) ===" >> output-cutline.txt
cat test1.txt >> output-cutline.txt
echo -e "\n=== cutline test1.txt output ===" >> output-cutline.txt
./cutline test1.txt >> output-cutline.txt 2>&1

echo -e "\n---\nTest 2: cutline test2.txt" >> output-cutline.txt
echo "=== test2.txt content (original) ===" >> output-cutline.txt
cat test2.txt >> output-cutline.txt
echo -e "\n=== cutline test2.txt output ===" >> output-cutline.txt
./cutline test2.txt >> output-cutline.txt 2>&1

echo -e "\n---\nTest 3: cutline test*.txt (multiple files)" >> output-cutline.txt
echo "=== Processing multiple files ===" >> output-cutline.txt
./cutline test*.txt >> output-cutline.txt 2>&1

echo -e "\n---\nTest 4: Reading from stdin" >> output-cutline.txt
echo "=== Testing stdin input ===" >> output-cutline.txt
echo "This is a test line from stdin that should be truncated" | ./cutline >> output-cutline.txt 2>&1

echo "Cutline tests completed. Output saved to output-cutline.txt"
echo "=== First 30 lines of output ==="
head -30 output-cutline.txt
