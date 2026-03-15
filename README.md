# Recon Automation Syaiful 🚀

Script otomasi sederhana namun powerful untuk melakukan *subdomain enumeration* dan validasi *live hosts*. Script ini dirancang untuk membantu bug hunter atau security researcher melakukan pengumpulan aset secara efisien dengan deduplikasi otomatis.

---

## 🛠️ Setup Environment

### 1. Install Go
Pastikan sistem kamu sudah terinstall Go. Jika belum:
```bash
sudo apt update && sudo apt install golang -y.
```

### 2. Install Tools (via PDTM atau Go)

Gunakan `pdtm` (ProjectDiscovery Tool Manager) atau `go install` untuk menginstall tools wajib:

*  **anew**: `go install github.com/tomnomnom/anew@latest`
*  **subfinder**: `go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest`
*  **httpx**: `go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest`
  
Catatan: Pastikan path binary Go kamu sudah terdaftar di environment:
```bash
sudo cp ~/go/bin/* /usr/local/bin/
```

## 🚀 Cara Menjalankan

*  **Persiapkan Target**: Masukkan daftar domain di `input/domains.txt` (minimal 5 domain).
*  **Beri Izin Eksekusi**:
```bash
chmod +x scripts/recon-auto.sh
```
*  **Jalankan Script**:
```bash
./scripts/recon-auto.sh
```

## 📂 Contoh Input & Output

*  **Input** (`input/domains.txt`):
```bash
google.com
yahoo.com
tesla.com
```
*  **Output Subdomain** (`output/all-subdomains.txt`):
Daftar semua subdomain unik yang ditemukan.
*  **Output Live** ('output/live.txt'):
Daftar host yang aktif dan merespon protokol HTTP/HTTPS.

## 💻 Penjelasan Kode
|  Bagian Kode |  Fungsi  |
|  :---  |  :---  |
|  **Path Configuration**  |	Mengatur lokasi folder input, output, dan logs secara dinamis.  |
|  **Logging Function**  |  Mencatat setiap proses ke terminal dan file log dengan timestamp.  |
|  **Error Handling**  | Mengecek keberadaan file input dan tools sebelum proses dimulai.  |
|  **Subfinder Pipe anew**  |	Mencari subdomain dan menghapus duplikasi secara real-time.  |
|  **httpx -t 50**  |	Memvalidasi keaktifan host menggunakan 50 threads agar proses lebih cepat.  |
|  **Final Statistics**  |	Menghitung total akhir baris file untuk laporan ringkas.  |

## 📸 Screenshot Eksekusi
Eksekusi Terminal
Hasil live.txt

(Ganti link gambar di atas dengan screenshot asli dari terminalmu saat sudah selesai!)
```bash
---

### Tips untuk Git:
1.  **Gunakan `.gitignore`**: Supaya folder `output/` dan `logs/` yang berisi data rahasia tidak ikut ter-upload ke publik, buat file bernama `.gitignore` dan isi dengan:
    ```text
    output/
    logs/
    ```
2.  **Upload ke GitHub**:
    ```bash
    git init
    git add .
    git commit -m "Initial commit: Struktur Recon Automation"
    git remote add origin [URL_REPO_KAMU]
    git push -u origin main
    ```
```
