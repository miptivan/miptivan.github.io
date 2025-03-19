#!/bin/bash

SOURCE_DIR=~/agenda

DEST_DIR=~/blog_pub/docs

FILES=("calendar.html" "parser.py" "stats.html" "tasks.json")

for file in "${FILES[@]}"; do
    if [ -f "$SOURCE_DIR/$file" ]; then
        cp -f "$SOURCE_DIR/$file" "$DEST_DIR/$file"
        echo "Файл $file скопирован в $DEST_DIR"
    else
        echo "Файл $file не найден в $SOURCE_DIR"
    fi
done
