# ⚡ YT-SOUNDCLOUD-DOWNLOADER-M4A

<p align="left">
  <img src="https://img.shields.io/github/v/release/abrielwiradikautama/YT-SOUNDCLOUD-DOWNLOADER-M4A?style=flat-square&color=0b" alt="Latest Release">
  <img src="https://img.shields.io/github/license/abrielwiradikautama/YT-SOUNDCLOUD-DOWNLOADER-M4A?style=flat-square&color=blue" alt="License">
  <img src="https://img.shields.io/badge/Platform-Windows%20CMD-black?style=flat-square&logo=windows" alt="Platform">
</p>

Portable Windows Batch Script Engine yang dirancang secara khusus untuk mengekstraksi file audio asli langsung dari server SoundCloud tanpa kompresi, serta mengunduh media resolusi tertinggi dari YouTube menggunakan ekosistem portabel terisolasi.

---

## 🌟 Nilai Jual Utama (SoundCloud Original Audio Extractor)

Mayoritas aplikasi pengunduh di internet bekerja dengan menangkap *streaming format* standar (kompresi 128kbps) yang menurunkan laju bit (*bitrate*) dan memotong frekuensi audio tinggi. 

Mesin ini menggunakan arsitektur bypass API pada `yt-dlp` untuk langsung mengidentifikasi dan menarik **berkas audio mentah asli (Original/Untouched File)** seperti format `.mp3` HQ atau `.wav` yang diunggah langsung oleh musisi ke server SoundCloud, memastikan kualitas audio 100% sama dengan file asli kreator.

---

## ⚙️ Arsitektur & Fitur Teknis

* **Zero-Configuration Dependency**: Pada eksekusi pertama, skrip akan mendeteksi komponen sistem. Jika kosong, skrip secara otomatis mengunduh dan mengekstrak `yt-dlp`, `FFmpeg`, `FFprobe`, dan `Deno JS Runtime` secara siluman (*silently continue*) ke folder lokal.
* **Isolasi Alur GOTO**: Menghapus seluruh blok pengkondisian `if ()` bersarang yang rentan memicu *syntax collision* dan *force close* pada interpreter Windows CMD saat membaca judul berkas yang mengandung karakter khusus atau simbol unicode.
* **Atribut Proteksi Media**: Penyuntikan parameter `--keep-video` memaksa sistem mempertahankan file biner utama yang telah diunduh, mencegah penghapusan otomatis oleh sistem jika proses injeksi metadata gambar (*thumbnail*) mengalami interupsi koneksi di tahap akhir.

---

## 📂 Struktur Direktori Lokal setelah Eksekusi

Saat Anda menjalankan berkas `.bat`, mesin akan secara otomatis membangun struktur portabel terisolasi berikut di komputer Anda tanpa mengotori *Environment Path* utama Windows:

```text
PROYEK-ANDA/
├── bin/                       <-- Dibuat otomatis (Terisolasi)
│   ├── deno.exe
│   ├── ffmpeg.exe
│   ├── ffprobe.exe
│   └── yt-dlp.exe
├── Downloads/                 <-- Folder Output Hasil Unduhan
│   └── [File-Audio/Video-Anda]
└── ytdownloader.bat           <-- Berkas Utama Proyek
