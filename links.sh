#!/bin/bash

SITE_DIR="./docs"
IMG_SRC_DIR="./img"
IMG_DEST_DIR="$SITE_DIR/analysis/img"

# Шаг 2: Копирование изображений
echo "Копирование изображений..."
mkdir -p "$IMG_DEST_DIR"
rsync -avP --exclude='.*' "$IMG_SRC_DIR/" "$IMG_DEST_DIR/"

# Шаг 3: Замена ссылок в HTML-файлах
echo "Замена ссылок в HTML-файлах..."
find "$SITE_DIR" -name "*.html" -exec sed -i 's|<img src="\.\./\.\./img/|<img src="img/|g' {} +

echo "Публикация завершена!"
