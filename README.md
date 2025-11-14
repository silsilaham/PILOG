# Aplikasi EMKL PT. Pasir Indah Logistik

Aplikasi manajemen EMKL (Ekspedisi Muatan Kapal Laut) berbasis web untuk PT. Pasir Indah Logistik.

## Fitur Utama

### 1. **Dashboard**
- Ringkasan statistik bisnis
- Total customer, container, job order aktif
- Total pendapatan, pembayaran, piutang, dan biaya operasional
- Laba bersih
- Job order terbaru

### 2. **Data Customer**
- Tambah, edit, hapus data customer
- Informasi: kode customer, nama perusahaan, kontak, telepon, email, alamat, NPWP
- Tabel listing customer

### 3. **Data Container**
- Manajemen container
- Informasi: nomor container, ukuran (20ft, 40ft, dll), jenis, status, lokasi
- Status: tersedia, terpakai, maintenance, transit
- Tanggal masuk dan seal number

### 4. **Job Order**
- Pembuatan job order dengan perhitungan otomatis
- **3 Status PPN:**
  - ✅ **Pakai PPN (11%)**
  - ✅ **Tidak Pakai PPN**
  - ✅ **PPN Dibebaskan**
- Rincian biaya: angkut, handling, THC, lainnya
- Link ke customer dan container
- Status: pending, in-progress, completed, cancelled
- Generate invoice langsung dari job order

### 5. **Invoice**
- Generate invoice otomatis dari job order
- Buat invoice manual dengan multiple items
- Perhitungan PPN otomatis sesuai status
- Status pembayaran: unpaid, partial, paid
- **Print format DOT MATRIX** (80 kolom)
- Konversi angka ke terbilang
- View dan edit invoice

### 6. **Pembayaran**
- Catat pembayaran untuk invoice
- Multiple payment methods: Transfer Bank, Tunai, Cek, Giro
- Update status pembayaran invoice otomatis
- History pembayaran per invoice
- Tracking sisa tagihan

### 7. **Biaya Operasional**
- Pencatatan biaya operasional
- Kategori: BBM, Tol, Parkir, Maintenance, Gaji, Sewa, dll
- Link ke job order tertentu atau biaya umum
- Vendor/penerima dan referensi nota
- Metode pembayaran

### 8. **Laporan**
- **Laporan Pendapatan**
  - Total pendapatan per periode
  - Breakdown berdasarkan status PPN
  - Detail per invoice
  
- **Laporan Piutang**
  - Outstanding invoices
  - Overdue tracking
  - Detail pembayaran dan sisa
  
- **Laporan Biaya Operasional**
  - Total biaya per kategori
  - Persentase per kategori
  - Detail transaksi
  
- **Laporan Laba Rugi**
  - Pendapatan vs Biaya
  - Laba/Rugi bersih
  - Margin laba
  - Breakdown lengkap
  
- **Laporan Job Order**
  - Total job order per periode
  - Detail per job order

- **Filter Periode:**
  - Bulanan
  - Tahunan
  - Custom date range

- Print dan Export laporan

## Teknologi

- **Frontend**: HTML5, CSS3, JavaScript (Vanilla JS)
- **Framework CSS**: Tailwind CSS (via CDN)
- **Database**: LocalStorage (browser-based, persistent)
- **UI**: Responsive design dengan gradient modern dan animasi
- **Icons**: Font Awesome 6 (via CDN)
- **PDF**: jsPDF + AutoTable untuk print invoice
- **Print**: Format khusus dot matrix printer 80 kolom
- **Architecture**: Single Page Application (SPA) dalam 1 file

## Cara Menggunakan

1. Buka file `index.html` di browser
2. Data tersimpan otomatis di LocalStorage browser
3. Tidak perlu instalasi server atau database

## Struktur File

```
emkl-app/
├── index.html              # ⭐ SINGLE FILE - All-in-One (HTML + CSS + JavaScript)
└── README.md               # Dokumentasi
```

### ✅ Keunggulan Single File Architecture

- **Portabel** - Copy paste langsung bisa digunakan
- **No Dependencies** - Tidak perlu folder css/ atau js/ terpisah
- **No Build Process** - Tidak perlu webpack, npm, atau bundler
- **Easy Deploy** - Upload 1 file saja ke hosting
- **Offline Ready** - Bisa dijalankan tanpa internet (kecuali CDN)
- **Zero Configuration** - Langsung double-click dan jalan
- **Self-Contained** - Semua kode dalam satu file yang rapi dan terstruktur

## Fitur PPN

Aplikasi mendukung 3 status PPN sesuai regulasi:

1. **Pakai PPN (11%)**
   - PPN dihitung otomatis 11% dari subtotal
   - Ditampilkan di invoice dan laporan

2. **Tidak Pakai PPN**
   - Tanpa perhitungan PPN
   - Total = Subtotal

3. **PPN Dibebaskan**
   - Untuk transaksi yang dibebaskan PPN
   - Tercatat di laporan terpisah

## Print Invoice Dot Matrix

Format invoice dirancang khusus untuk printer dot matrix:
- Lebar: 80 karakter
- Font: Courier New (monospace)
- Layout: ASCII art
- Auto line break
- Terbilang otomatis

## Laporan

Semua laporan dapat:
- Filter per bulan atau tahun
- Custom date range
- Print langsung
- View detail per transaksi
- Export (segera tersedia)

## Keamanan Data

- Data tersimpan di LocalStorage browser
- Backup manual: Export browser data
- Untuk produksi: gunakan backend database

## Browser Support

- Chrome (Recommended)
- Firefox
- Edge
- Safari

## Tips Penggunaan

1. **Workflow Normal:**
   - Tambah Customer → Tambah Container → Buat Job Order → Generate Invoice → Catat Pembayaran

2. **Biaya Operasional:**
   - Dapat dikaitkan dengan job order tertentu atau sebagai biaya umum

3. **Status Container:**
   - Otomatis berubah saat digunakan di job order

4. **Invoice Payment Status:**
   - Otomatis update saat pembayaran dicatat

5. **Laporan:**
   - Generate sesuai periode untuk analisis bisnis

## Backup & Restore Data

### 💾 Backup Data
1. Buka menu **Pengaturan**
2. Klik tombol **Backup Data**
3. File JSON akan otomatis terdownload
4. Simpan file backup di tempat aman (Google Drive, Dropbox, dll)

### 📥 Restore Data
1. Buka menu **Pengaturan**
2. Klik tombol **Restore Data**
3. Pilih file backup JSON
4. Data akan ter-restore dan langsung tersedia

> **⚠️ PENTING**: Backup data secara rutin (minimal 1x seminggu) untuk menghindari kehilangan data jika browser cache terhapus.

## Pengembangan Selanjutnya

- Export laporan ke Excel/PDF
- User authentication & role management
- Multi-user support dengan sinkronisasi
- Backend integration dengan REST API
- Email invoice otomatis ke customer
- Reminder jatuh tempo pembayaran
- Dashboard analytics dengan chart
- Integration dengan sistem akuntansi

## Support

Untuk pertanyaan dan dukungan, hubungi tim pengembang.

---

© 2024 PT. Pasir Indah Logistik. All rights reserved.
