#!/bin/bash

# Mengecek apakah user memasukkan argumen target
if [ -z "$1" ]; then
    echo "Penggunaan: $0 <domain/IP>"
    echo "Contoh: $0 google.com"
    exit 1
fi

TARGET=$1
OUTPUT_DIR="recon_$TARGET"

# Membuat direktori hasil jika belum ada
mkdir -p $OUTPUT_DIR

echo "--- Memulai Recon Dasar pada: $TARGET ---"

# 1. WHOIS Lookup
echo "[+] Menjalankan WHOIS..."
whois $TARGET > $OUTPUT_DIR/whois.txt

# 2. DNS Lookup (dig)
echo "[+] Menjalankan DNS Lookup..."
dig $TARGET ANY +noall +answer > $OUTPUT_DIR/dns.txt

# 3. Port Scanning Dasar (nmap)
# Menampilkan port yang terbuka secara cepat
echo "[+] Scanning port populer dengan Nmap..."
nmap -F $TARGET > $OUTPUT_DIR/nmap_fast.txt

echo "--- Selesai! Hasil disimpan di folder: $OUTPUT_DIR ---"
