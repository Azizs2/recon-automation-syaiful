#!/bin/bash

# Pastikan ada argumen domain yang dimasukkan
if [ -z "$1" ]; then
    echo "Penggunaan: $0 <domain>"
    exit 1
fi

TARGET=$1

# 1. Membuat direktori berdasarkan nama target
mkdir -p "$TARGET"

# 2. Menjalankan subfinder
# Mencari subdomain dan menyimpan hasilnya ke file txt
echo "[*] Menjalankan subfinder..."
subfinder -d "$TARGET" -o "$TARGET/subdomains.txt"

# 3. Menjalankan httpx
# Membaca list dari subdomains.txt dan mengecek host yang aktif
echo "[*] Menjalankan httpx terhadap subdomain yang ditemukan..."
httpx -l "$TARGET/subdomains.txt" -o "$TARGET/live_hosts.txt"

# 4. Menampilkan pesan selesai
echo -e "\n[+] Done! Hasil tersimpan di folder: $TARGET/"
