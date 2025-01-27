#!/bin/bash

# Имя файла
OUTPUT_FILE=".gitignore"

# Содержимое файла
CONTENT="/.packages/
/themes/
/content/
/straight/
/content/straight/
/img/
/build_scripts/"

# Создание файла и запись содержимого
echo "$CONTENT" > "$OUTPUT_FILE"

# Вывод результата
echo "Файл '$OUTPUT_FILE' создан со следующим содержимым:"
cat "$OUTPUT_FILE"
