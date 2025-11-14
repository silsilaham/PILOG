# 🚀 Quick Start Guide - Aplikasi EMKL PILOG

## Langkah 1: Buka Aplikasi
```
Double-click file: index.html
```
Atau drag & drop ke browser (Chrome/Firefox/Edge)

---

## Langkah 2: Setup Data Master (First Time)

### A. Tambah Customer
1. Klik menu **Data Customer**
2. Klik tombol **[+] Tambah Customer**
3. Isi form:
   - Kode Customer: `CUST001`
   - Nama Perusahaan: `PT. Contoh Jaya`
   - Telepon: `021-1234567`
   - Alamat: Alamat lengkap
4. Klik **Simpan**

### B. Tambah Sopir
1. Klik menu **Data Sopir**
2. Klik tombol **[+] Tambah Sopir**
3. Isi form:
   - Nama Sopir: `Budi Santoso`
   - No. HP: `08123456789`
   - No. SIM: `1234567890`
4. Klik **Simpan**

### C. (Opsional) Tambah Container
1. Klik menu **Data Container**
2. Klik **[+] Tambah Container**
3. Isi data container
4. Klik **Simpan**

---

## Langkah 3: Buat Job Order

1. Klik menu **Tambah Job Order**
2. Isi form job order:

   **Informasi Dasar:**
   - Status PPN: Pilih salah satu
     - ✅ **Pakai PPN (11%)** - Untuk customer yang kena PPN
     - ✅ **Tidak Pakai PPN** - Untuk customer non-PKP
     - ✅ **PPN Dibebaskan** - Sesuai aturan

   **Detail Job:**
   - Customer: Pilih dari dropdown
   - Tanggal Job Order: Isi tanggal
   - Origin: `Tanjung Priok`
   - Destination: `Surabaya`

   **Container (Multiple):**
   - No. Container: `ABCD1234567`
   - Ukuran: `40ft`
   - Jenis Muatan: `Elektronik`
   - Nopol: `B 1234 XYZ`
   - Sopir: Pilih dari dropdown
   - *Klik [+] untuk tambah container lain*

   **Rincian Biaya:**
   - Biaya Angkut: `5.000.000`
   - Biaya Handling: `500.000`
   - THC: `300.000`
   - Biaya Lainnya: `200.000`

   **Sistem akan otomatis hitung:**
   - Subtotal: Rp 6.000.000
   - PPN 11%: Rp 660.000 (jika pakai PPN)
   - **Total: Rp 6.660.000**

3. Klik **Simpan Job Order**
4. ✅ Invoice otomatis terbuat!

---

## Langkah 4: Catat Pembayaran

1. Klik menu **Pembayaran Invoice**
2. Pilih Job Order dari dropdown
3. Detail invoice akan muncul
4. Isi form pembayaran:
   - Tanggal Pembayaran: Hari ini
   - Jumlah: `6.660.000` (atau sesuai yang diterima)
   - Metode: `Transfer Bank`
   - Bank: Pilih bank
   - No. Referensi: `TRF123456`
5. Klik **Simpan Pembayaran**
6. ✅ Status piutang otomatis update!

---

## Langkah 5: Catat Biaya Operasional

1. Klik menu **Biaya Operasional**
2. Pilih Job Order (atau kosongkan untuk biaya umum)
3. Klik **[+] Tambah Biaya**
4. Isi form:
   - Deskripsi: `BBM Solar 100 liter`
   - Kategori: `BBM`
   - Jumlah: `1.500.000`
   - Metode: `Tunai`
5. Klik **Simpan**

---

## Langkah 6: Lihat Laporan

### Dashboard
- Klik menu **Dashboard**
- Lihat overview bisnis

### Laporan Laba Rugi
1. Klik menu **Laporan**
2. Pilih tab **Laba Rugi**
3. Filter:
   - Bulan: `November`
   - Tahun: `2025`
4. Klik **Tampilkan Laporan**
5. Lihat:
   - Total Pendapatan (PPN & Non-PPN terpisah)
   - Total Biaya Operasional
   - **Laba Bersih**
6. Klik **Print** untuk cetak

### Laporan Piutang
1. Pilih tab **Piutang**
2. Filter periode
3. Klik **Tampilkan**
4. Lihat outstanding invoices
5. Klik **Print** untuk cetak

### Laporan Sopir
1. Pilih tab **Laporan Sopir**
2. Filter periode
3. Lihat tracking per sopir:
   - Total pengiriman
   - Total pendapatan
   - List job orders
4. Klik **Print**

---

## Langkah 7: Print Invoice

### Cara 1: Dari List Job Order
1. Klik menu **List Job Order**
2. Klik tombol **Print** di job order yang diinginkan
3. Print preview akan muncul
4. Klik **Print** di browser

### Cara 2: Dari Detail
1. Klik tombol **Detail** di job order
2. Scroll ke bawah
3. Klik tombol **Print Invoice**
4. Print preview muncul
5. Klik **Print**

**Format Print:**
- 80 kolom (untuk printer dot matrix)
- Header: PT. Pasir Indah Logistik
- Detail customer & invoice
- Rincian biaya
- Total dalam angka dan terbilang
- TTD & Cap perusahaan

---

## Langkah 8: Backup Data

### Backup Rutin (PENTING!)
1. Klik menu **Pengaturan**
2. Scroll ke section **Backup & Restore**
3. Klik tombol **Backup Data**
4. File JSON akan terdownload otomatis
5. Simpan di:
   - Google Drive
   - Dropbox
   - External hard disk
   - Multiple locations (rekomendasi)

**Jadwal Backup:**
- Setiap akhir hari kerja ✅
- Minimal 1x seminggu ✅
- Sebelum update browser ✅

### Restore Data
1. Klik menu **Pengaturan**
2. Klik tombol **Restore Data**
3. Pilih file backup (.json)
4. Data akan ter-restore otomatis
5. Refresh halaman

---

## Tips & Tricks 💡

### Workflow Efisien
```
Customer → Job Order → (Auto Invoice) → Pembayaran → Laporan
                ↓
         Biaya Operasional
```

### Keyboard Shortcuts
- `Tab`: Pindah field
- `Enter`: Submit form
- `Esc`: Close modal (jika ada)

### Best Practices
1. ✅ Isi data customer lengkap (untuk invoice)
2. ✅ Buat nomor job order unik
3. ✅ Catat biaya operasional per job (untuk akurasi laba rugi)
4. ✅ Update status pembayaran segera setelah terima transfer
5. ✅ Backup data setiap hari
6. ✅ Print invoice setelah job order selesai

### Troubleshooting

**Q: Data hilang setelah restart browser?**
A: Data di LocalStorage. Pastikan tidak clear browser cache.

**Q: Tidak bisa tambah job order?**
A: Pastikan sudah ada minimal 1 customer.

**Q: Total tidak sesuai?**
A: Cek status PPN. PPN 11% dihitung dari subtotal.

**Q: Print tidak keluar?**
A: Pastikan browser allow popup & printer terkoneksi.

**Q: Aplikasi lambat?**
A: Backup data → Clear cache → Restore data.

---

## Status PPN - Panduan

### 1️⃣ Pakai PPN (11%)
**Untuk:**
- Customer yang ber-NPWP
- Customer PKP (Pengusaha Kena Pajak)
- Transaksi B2B (Business to Business)

**Perhitungan:**
```
Subtotal:     Rp 10.000.000
PPN 11%:      Rp  1.100.000
─────────────────────────────
Total:        Rp 11.100.000
```

### 2️⃣ Tidak Pakai PPN
**Untuk:**
- Customer non-PKP
- Customer individu
- Transaksi kecil

**Perhitungan:**
```
Subtotal:     Rp 10.000.000
PPN:          Rp          0
─────────────────────────────
Total:        Rp 10.000.000
```

### 3️⃣ PPN Dibebaskan
**Untuk:**
- Transaksi tertentu sesuai regulasi
- Export barang
- Layanan khusus yang dibebaskan PPN

**Perhitungan:**
```
Subtotal:     Rp 10.000.000
PPN:          Rp          0 (Dibebaskan)
─────────────────────────────
Total:        Rp 10.000.000
```

---

## Kontak Support

**Email**: support@pasirindah.com  
**WhatsApp**: +62 812-3456-7890  
**Jam Kerja**: Senin-Jumat, 08:00-17:00 WIB

---

**Happy Managing! 🚚📦✨**

_Version 2.0 - Single File Architecture_
