# 🚀 PANDUAN LENGKAP SETUP SUPABASE - EMKL PILOG

## 📋 Daftar Isi
1. [Pendahuluan](#pendahuluan)
2. [Membuat Project Supabase](#membuat-project-supabase)
3. [Membuat Database Tables](#membuat-database-tables)
4. [Konfigurasi Aplikasi](#konfigurasi-aplikasi)
5. [Testing Koneksi](#testing-koneksi)
6. [Troubleshooting](#troubleshooting)

---

## 📖 Pendahuluan

Aplikasi EMKL PILOG sekarang terintegrasi dengan **Supabase** sebagai database cloud. Dengan integrasi ini:

✅ **Multi-User Access**: Semua pengguna dapat melihat data yang sama secara real-time  
✅ **Cloud Storage**: Data tersimpan di cloud, aman dan dapat diakses dari mana saja  
✅ **Real-Time Sync**: Perubahan data langsung terlihat di semua perangkat  
✅ **Single Login**: 1 akun untuk semua pegawai (akses aplikasi saja, bukan data)  
✅ **Backup Otomatis**: Data tersimpan di server Supabase  

**Kredensial Login Default:**
- **Username**: `admin`
- **Password**: `pilog2024`

---

## 🌐 Membuat Project Supabase

### Langkah 1: Daftar Akun Supabase

1. Buka browser dan kunjungi: **https://supabase.com**
2. Klik tombol **"Start your project"** atau **"Sign Up"**
3. Pilih metode pendaftaran:
   - **GitHub** (Recommended)
   - **Google**
   - **Email**
4. Ikuti proses verifikasi email jika menggunakan email

### Langkah 2: Buat Project Baru

1. Setelah login, klik **"New Project"**
2. Isi form berikut:
   - **Organization**: Buat organization baru atau pilih yang ada
   - **Project Name**: `emkl-pilog` (atau nama lain sesuai keinginan)
   - **Database Password**: Buat password yang kuat (SIMPAN password ini!)
   - **Region**: Pilih **Southeast Asia (Singapore)** untuk performa terbaik di Indonesia
   - **Pricing Plan**: Pilih **Free** (sudah cukup untuk aplikasi ini)

3. Klik **"Create new project"**
4. Tunggu 2-3 menit hingga project selesai dibuat

### Langkah 3: Dapatkan API Credentials

Setelah project selesai dibuat:

1. Di dashboard Supabase, klik **"Settings"** (ikon gear) di sidebar kiri
2. Klik **"API"** di menu Settings
3. Catat 2 informasi penting ini:

   **Project URL:**
   ```
   https://xxxxxxxxxxxxx.supabase.co
   ```

   **anon public key:**
   ```
   eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS...
   ```

4. **SIMPAN** kedua informasi ini, akan digunakan di langkah berikutnya!

---

## 🗄️ Membuat Database Tables

### Langkah 1: Buka SQL Editor

1. Di dashboard Supabase, klik **"SQL Editor"** di sidebar kiri
2. Klik **"New query"**

### Langkah 2: Jalankan SQL Script

Copy dan paste SQL script berikut ke SQL Editor, lalu klik **"Run"**:

```sql
-- =====================================================
-- EMKL PILOG DATABASE SCHEMA
-- =====================================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Table: jobs (Menyimpan semua job order)
CREATE TABLE IF NOT EXISTS public.jobs (
    id TEXT PRIMARY KEY,
    data JSONB NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table: banks (Menyimpan data rekening bank)
CREATE TABLE IF NOT EXISTS public.banks (
    id TEXT PRIMARY KEY,
    data JSONB NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table: customers (Menyimpan data pelanggan)
CREATE TABLE IF NOT EXISTS public.customers (
    id TEXT PRIMARY KEY,
    data JSONB NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table: drivers (Menyimpan data sopir)
CREATE TABLE IF NOT EXISTS public.drivers (
    id TEXT PRIMARY KEY,
    data JSONB NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table: invoice_items_master (Master data item invoice)
CREATE TABLE IF NOT EXISTS public.invoice_items_master (
    id TEXT PRIMARY KEY,
    data JSONB NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table: operational_cost_items_master (Master data item biaya operasional)
CREATE TABLE IF NOT EXISTS public.operational_cost_items_master (
    id TEXT PRIMARY KEY,
    data JSONB NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_jobs_created_at ON public.jobs(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_customers_data ON public.customers USING GIN (data);
CREATE INDEX IF NOT EXISTS idx_drivers_data ON public.drivers USING GIN (data);

-- Enable Row Level Security (RLS) - DISABLED for simplicity
-- Since we only have 1 login account, we don't need RLS
ALTER TABLE public.jobs DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.banks DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.customers DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.drivers DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.invoice_items_master DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.operational_cost_items_master DISABLE ROW LEVEL SECURITY;

-- Enable Realtime for all tables
ALTER PUBLICATION supabase_realtime ADD TABLE public.jobs;
ALTER PUBLICATION supabase_realtime ADD TABLE public.banks;
ALTER PUBLICATION supabase_realtime ADD TABLE public.customers;
ALTER PUBLICATION supabase_realtime ADD TABLE public.drivers;
ALTER PUBLICATION supabase_realtime ADD TABLE public.invoice_items_master;
ALTER PUBLICATION supabase_realtime ADD TABLE public.operational_cost_items_master;

-- Create function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create triggers for updated_at
CREATE TRIGGER update_jobs_updated_at BEFORE UPDATE ON public.jobs
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_banks_updated_at BEFORE UPDATE ON public.banks
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_customers_updated_at BEFORE UPDATE ON public.customers
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_drivers_updated_at BEFORE UPDATE ON public.drivers
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_invoice_items_master_updated_at BEFORE UPDATE ON public.invoice_items_master
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_operational_cost_items_master_updated_at BEFORE UPDATE ON public.operational_cost_items_master
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
```

3. Jika berhasil, Anda akan melihat pesan **"Success. No rows returned"**

### Langkah 3: Verifikasi Tables

1. Klik **"Table Editor"** di sidebar kiri
2. Anda akan melihat 6 tables baru:
   - ✅ `jobs`
   - ✅ `banks`
   - ✅ `customers`
   - ✅ `drivers`
   - ✅ `invoice_items_master`
   - ✅ `operational_cost_items_master`

---

## ⚙️ Konfigurasi Aplikasi

### Langkah 1: Edit File index.html

1. Buka file **`index.html`** dengan text editor (VS Code, Notepad++, dll)
2. Cari bagian kode berikut (sekitar baris 1267-1268):

```javascript
// GANTI dengan URL dan Key dari Supabase Project Anda!
const SUPABASE_URL = 'https://your-project-url.supabase.co';
const SUPABASE_ANON_KEY = 'your-anon-key-here';
```

3. Ganti dengan credentials dari Supabase Anda:

```javascript
const SUPABASE_URL = 'https://xxxxxxxxxxxxx.supabase.co'; // Ganti dengan Project URL Anda
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...'; // Ganti dengan anon key Anda
```

4. **Save** file index.html

### Langkah 2: (Opsional) Ubah Kredensial Login

Jika ingin mengubah username/password login aplikasi:

Cari bagian kode berikut (sekitar baris 1271-1272):

```javascript
// Login Credentials (hanya 1 akun untuk akses aplikasi)
const VALID_USERNAME = 'admin';
const VALID_PASSWORD = 'pilog2024';
```

Ganti dengan kredensial yang Anda inginkan:

```javascript
const VALID_USERNAME = 'pegawai';
const VALID_PASSWORD = 'password123';
```

**Save** file index.html

---

## 🧪 Testing Koneksi

### Test 1: Login ke Aplikasi

1. Buka file **`index.html`** di browser (double-click file)
2. Anda akan melihat **Login Screen**
3. Masukkan kredensial:
   - **Username**: `admin`
   - **Password**: `pilog2024`
4. Klik **"Login"**
5. Jika berhasil, Anda akan masuk ke Dashboard aplikasi

### Test 2: Input Data Pelanggan

1. Di sidebar, klik **"Data Pelanggan"**
2. Isi form pelanggan baru:
   - Nama: `PT Test Customer`
   - Alamat: `Jl. Test No. 123`
   - Telepon: `081234567890`
   - Email: `test@example.com`
3. Klik **"Simpan"**
4. Data akan tersimpan ke Supabase

### Test 3: Verifikasi di Supabase Dashboard

1. Buka dashboard Supabase
2. Klik **"Table Editor"**
3. Pilih table **`customers`**
4. Anda akan melihat data pelanggan yang baru saja ditambahkan

### Test 4: Multi-User Sync (Opsional)

1. Buka aplikasi di 2 tab browser berbeda
2. Login di kedua tab
3. Tambahkan data di tab pertama
4. Data akan otomatis muncul di tab kedua (real-time sync!)

---

## 🔧 Troubleshooting

### ❌ Error: "Failed to fetch" atau "Network Error"

**Penyebab:**
- Koneksi internet terputus
- URL Supabase salah
- Project Supabase belum aktif

**Solusi:**
1. Cek koneksi internet
2. Verifikasi `SUPABASE_URL` di index.html sudah benar
3. Pastikan project Supabase sudah selesai dibuat (tidak ada loading)
4. Coba refresh browser dengan Ctrl+F5

### ❌ Error: "Invalid API key"

**Penyebab:**
- Anon key salah atau tidak lengkap

**Solusi:**
1. Copy ulang **anon public key** dari Supabase Dashboard → Settings → API
2. Pastikan key lengkap (biasanya sangat panjang, ~400 karakter)
3. Tidak ada spasi atau karakter tambahan

### ❌ Data tidak muncul setelah input

**Penyebab:**
- Table belum dibuat
- RLS (Row Level Security) masih aktif

**Solusi:**
1. Verifikasi semua tables sudah dibuat di Table Editor
2. Jalankan ulang SQL script untuk disable RLS
3. Buka Console browser (F12) untuk melihat error detail

### ❌ Real-time sync tidak bekerja

**Penyebab:**
- Realtime belum di-enable untuk tables

**Solusi:**
1. Di Supabase Dashboard, klik **"Database"** → **"Replication"**
2. Pastikan semua 6 tables sudah di-enable untuk replication
3. Jika belum, jalankan ulang bagian `ALTER PUBLICATION` di SQL script

### ⚠️ Aplikasi tetap berjalan tanpa Supabase

**Catatan:**
Aplikasi ini memiliki **fallback ke localStorage**. Jika koneksi Supabase gagal:
- Data akan tetap tersimpan di browser lokal
- Anda akan melihat toast notification: "⚠️ Data disimpan ke lokal saja"
- Multi-user sync tidak akan bekerja, tapi aplikasi tetap bisa digunakan

---

## 📊 Struktur Database

### Table: jobs
Menyimpan semua job order (PPN dan Non-PPN)

| Column | Type | Description |
|--------|------|-------------|
| `id` | TEXT | Primary key (JO-PPN-YYYYMMDD-XXX) |
| `data` | JSONB | Semua data job (containers, invoice, costs, dll) |
| `created_at` | TIMESTAMP | Waktu dibuat |
| `updated_at` | TIMESTAMP | Waktu terakhir diupdate |

### Table: customers
Menyimpan data pelanggan

| Column | Type | Description |
|--------|------|-------------|
| `id` | TEXT | Primary key (CUST-timestamp) |
| `data` | JSONB | Data pelanggan (nama, alamat, telp, email) |
| `created_at` | TIMESTAMP | Waktu dibuat |
| `updated_at` | TIMESTAMP | Waktu terakhir diupdate |

### Table: drivers
Menyimpan data sopir

| Column | Type | Description |
|--------|------|-------------|
| `id` | TEXT | Primary key (DRIVER-timestamp) |
| `data` | JSONB | Data sopir (nama, telp, plat nomor) |
| `created_at` | TIMESTAMP | Waktu dibuat |
| `updated_at` | TIMESTAMP | Waktu terakhir diupdate |

### Table: banks
Menyimpan data rekening bank

| Column | Type | Description |
|--------|------|-------------|
| `id` | TEXT | Primary key (auto-generated) |
| `data` | JSONB | Data bank (nama bank, nomor, atas nama) |
| `created_at` | TIMESTAMP | Waktu dibuat |
| `updated_at` | TIMESTAMP | Waktu terakhir diupdate |

---

## 🔒 Keamanan

### Login Aplikasi
- **Single Account**: Hanya 1 akun untuk semua pegawai
- **Session-based**: Login tersimpan di `sessionStorage` (hilang jika browser ditutup)
- **No User Management**: Tidak ada fitur register/reset password
- **Simple Auth**: Username dan password di-hardcode di aplikasi

### Database Security
- **RLS Disabled**: Row Level Security dimatikan untuk kemudahan akses
- **Public Access**: Semua data bisa diakses dengan anon key
- **No User Roles**: Tidak ada role admin/staff/viewer

**⚠️ PENTING:**
Aplikasi ini cocok untuk **internal use** dalam 1 organisasi. Jika butuh security lebih ketat:
- Enable RLS dan buat policies
- Implementasi Supabase Auth
- Buat role-based access control

---

## 📱 Fitur Real-Time

Aplikasi ini menggunakan **Supabase Realtime** untuk sinkronisasi data:

### Cara Kerja:
1. User A menambahkan job order baru
2. Data tersimpan ke Supabase
3. Supabase mengirim notifikasi perubahan
4. User B, C, D otomatis menerima update
5. Data di semua device ter-refresh otomatis

### Tables yang Real-Time:
✅ Jobs (Job Orders)  
✅ Customers (Pelanggan)  
✅ Drivers (Sopir)  
✅ Banks (Rekening Bank)  
✅ Invoice Items Master  
✅ Operational Cost Items Master  

---

## 💾 Backup Data

### Backup Otomatis (Supabase)
Supabase secara otomatis mem-backup database Anda:
- **Free Plan**: Backup 7 hari terakhir
- **Restore**: Bisa dilakukan di Dashboard → Database → Backups

### Backup Manual (Fitur Aplikasi)
Gunakan fitur **"Backup & Restore"** di aplikasi:
1. Klik menu **"Pengaturan"** → **"Backup & Restore"**
2. Klik **"Download Backup"**
3. File JSON akan terdownload
4. Simpan file ini sebagai backup lokal

### Restore dari Backup
1. Buka menu **"Backup & Restore"**
2. Pilih file backup (.json)
3. Klik **"Restore Data"**
4. Data akan di-upload ke Supabase

---

## 📈 Monitoring & Analytics

### Melihat Statistik Database

1. Di Supabase Dashboard, klik **"Database"**
2. Klik **"Usage"** untuk melihat:
   - Jumlah rows per table
   - Storage usage
   - API requests
   - Database size

### Monitoring Real-Time

1. Klik **"API Logs"** di sidebar
2. Anda bisa melihat semua API calls ke database
3. Berguna untuk debugging masalah

---

## 🚀 Deploy ke Production

### Option 1: Hosting Sederhana (Netlify/Vercel)

**Netlify Drop:**
1. Buka https://app.netlify.com/drop
2. Drag & drop file **`index.html`**
3. Aplikasi langsung online!
4. URL: `https://random-name.netlify.app`

**Custom Domain:**
1. Di Netlify/Vercel dashboard, klik **"Domain Settings"**
2. Tambahkan domain Anda
3. Update DNS records

### Option 2: Server Sendiri

Upload file `index.html` ke:
- Apache (folder `/var/www/html/`)
- Nginx (folder `/usr/share/nginx/html/`)
- IIS (folder `C:\inetpub\wwwroot\`)

### Option 3: Local Network (Intranet)

1. Setup web server di komputer lokal
2. Share folder via network
3. Akses dari komputer lain: `http://192.168.x.x/index.html`

---

## 📞 Support & Contact

### Dokumentasi Resmi:
- Supabase: https://supabase.com/docs
- Supabase JavaScript Client: https://supabase.com/docs/reference/javascript

### Community:
- Supabase Discord: https://discord.supabase.com
- Supabase GitHub: https://github.com/supabase/supabase

### Developer:
PT. Pasir Indah Logistik IT Team

---

## ✅ Checklist Setup

Gunakan checklist ini untuk memastikan setup sudah lengkap:

- [ ] Akun Supabase sudah dibuat
- [ ] Project Supabase sudah dibuat
- [ ] SQL script sudah dijalankan (6 tables created)
- [ ] Project URL sudah di-copy
- [ ] Anon key sudah di-copy
- [ ] File index.html sudah diedit dengan credentials
- [ ] Aplikasi bisa dibuka di browser
- [ ] Login berhasil (admin / pilog2024)
- [ ] Test input data pelanggan berhasil
- [ ] Data muncul di Supabase Table Editor
- [ ] Real-time sync sudah ditest (2 tab browser)

---

## 🎉 Selesai!

Selamat! Aplikasi EMKL PILOG Anda sekarang sudah terhubung dengan Supabase dan siap digunakan oleh seluruh tim!

**Fitur yang sudah aktif:**
✅ Cloud database  
✅ Multi-user access  
✅ Real-time sync  
✅ Single login  
✅ Auto backup  
✅ Responsive design  

**Next Steps:**
- Deploy aplikasi ke hosting
- Share URL ke tim
- Training penggunaan aplikasi
- Monitor penggunaan di Supabase Dashboard

---

**Version:** 3.0 - Supabase Integration  
**Last Updated:** November 14, 2025  
**Maintained by:** PT. Pasir Indah Logistik IT Team
