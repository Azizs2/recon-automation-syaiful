#!/bin/bash

# Konfigurasi Path (Relatif terhadap folder scripts)
BASE_DIR="$(dirname "$0")/.."
INPUT="$BASE_DIR/input/domains.txt"
OUTPUT_ALL="$BASE_DIR/output/all-subdomains.txt"
OUTPUT_LIVE="$BASE_DIR/output/live.txt"
LOG_PROGRESS="$BASE_DIR/logs/progress.log"
LOG_ERROR="$BASE_DIR/logs/errors.log"

# Fungsi Logging dengan Timestamp
log_msg() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_PROGRESS"
}

# Inisialisasi
log_msg "--- MEMULAI PROSES RECON ---"

# Cek apakah input file ada
if [[ ! -f "$INPUT" ]]; then
    log_msg "ERROR: File input $INPUT tidak ditemukan!" | tee -a "$LOG_ERROR"
    exit 1
fi

# Pastikan tool 'anew' terinstall
if ! command -v anew &> /dev/null; then
    log_msg "ERROR: 'anew' tidak ditemukan. Silakan install dulu." | tee -a "$LOG_ERROR"
    exit 1
fi

# --- Langkah 1: Subdomain Enumeration ---
log_msg "Menjalankan Enumeration..."
# Contoh menggunakan subfinder (sesuaikan tool yang kamu punya)
subfinder -dL "$INPUT" -silent 2>> "$LOG_ERROR" | anew "$OUTPUT_ALL" | tee -a "$LOG_PROGRESS"

# --- Langkah 2: Filter Live Hosts ---
log_msg "Mengecek Live Hosts dengan httpx..."
# Mengambil data dari all-subdomains.txt dan memfilter yang aktif
cat "$OUTPUT_ALL" | httpx -silent 2>> "$LOG_ERROR" | anew "$OUTPUT_LIVE" | tee -a "$LOG_PROGRESS"

# --- Langkah 3: Statistik Akhir ---
TOTAL_UNIQUE=$(wc -l < "$OUTPUT_ALL")
TOTAL_LIVE=$(wc -l < "$OUTPUT_LIVE")

echo "--------------------------------------" | tee -a "$LOG_PROGRESS"
log_msg "HASIL AKHIR:"
log_msg "Jumlah Subdomain Unik: $TOTAL_UNIQUE"
log_msg "Jumlah Live Hosts: $TOTAL_LIVE"
echo "--------------------------------------" | tee -a "$LOG_PROGRESS"

log_msg "Selesai. Cek folder output/ untuk detail."
