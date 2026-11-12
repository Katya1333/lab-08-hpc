#!/bin/bash
set -euo pipefail

bucket="$1"
book_dir="$2"

mkdir -p "$book_dir"
aws s3 cp "s3://$bucket" "$book_dir" --recursive --exclude "*" --include "*.txt"

book_dir="$(realpath "$book_dir")"

echo "File path" > book_list.txt
find "$book_dir" -name "*.txt" | LC_ALL=C sort >> book_list.txt

count="$(tail -n +2 book_list.txt | wc -l)"
echo "Listed $count books in book_list.txt"
