# 🚀 QUICK START - Supabase Integration

## ⚡ Setup Cepat (5 Menit)

### 1️⃣ Buat Project Supabase
1. Buka https://supabase.com → Sign Up (gunakan GitHub)
2. **New Project** → Isi:
   - Name: `emkl-pilog`
   - Password: (buat & simpan!)
   - Region: **Southeast Asia (Singapore)**
3. Tunggu 2-3 menit

### 2️⃣ Jalankan SQL Script
1. Di dashboard → **SQL Editor** → **New query**
2. Copy isi file `database-schema.sql`
3. Paste → **Run**
4. Lihat success message ✅

### 3️⃣ Ambil Credentials
1. **Settings** → **API**
2. Copy 2 hal ini:
   ```
   Project URL: https://xxxxx.supabase.co
   anon key: eyJhbGc...
   ```

### 4️⃣ Update index.html
Edit file `index.html`, cari baris ~1267:

```javascript
const SUPABASE_URL = 'https://your-project-url.supabase.co';
const SUPABASE_ANON_KEY = 'your-anon-key-here';
```

Ganti dengan credentials Anda → **Save**

### 5️⃣ Login & Test
1. Buka `index.html` di browser
2. Login:
   - Username: `admin`
   - Password: `pilog2024`
3. ✅ Berhasil!

---

## 📋 Struktur Database

| Table | Deskripsi | Kolom Utama |
|-------|-----------|-------------|
| `jobs` | Job orders (PPN/Non-PPN) | id, data (JSONB) |
| `customers` | Data pelanggan | id, data (JSONB) |
| `drivers` | Data sopir | id, data (JSONB) |
| `banks` | Rekening bank | id, data (JSONB) |
| `invoice_items_master` | Template invoice items | id, data (JSONB) |
| `operational_cost_items_master` | Template biaya | id, data (JSONB) |

Semua table memiliki:
- `created_at`: Timestamp dibuat
- `updated_at`: Timestamp update (auto-trigger)

---

## 🔐 Login Info

**Default Credentials:**
- Username: `admin`
- Password: `pilog2024`

**Ubah Credentials:**
Edit `index.html` baris ~1271:
```javascript
const VALID_USERNAME = 'admin';      // ← Ganti
const VALID_PASSWORD = 'pilog2024';  // ← Ganti
```

---

## ✨ Fitur Utama

### ✅ Cloud Database
Data tersimpan di Supabase (bukan localStorage)

### ✅ Multi-User Access
Semua pengguna lihat data yang sama

### ✅ Real-Time Sync
Perubahan langsung terlihat di semua device

### ✅ Auto Backup
Supabase backup otomatis 7 hari terakhir

### ✅ Fallback Mode
Jika Supabase offline → tetap bisa pakai (localStorage)

---

## 🧪 Testing

### Test 1: Input Data
1. Login → **Data Pelanggan**
2. Tambah pelanggan baru
3. Cek di Supabase → **Table Editor** → `customers`
4. ✅ Data muncul

### Test 2: Real-Time Sync
1. Buka 2 tab browser
2. Login di keduanya
3. Tab 1: Tambah data
4. Tab 2: Data muncul otomatis (2-3 detik)
5. ✅ Real-time works!

---

## ❌ Troubleshooting

| Error | Solusi |
|-------|--------|
| "Failed to fetch" | Cek internet & URL Supabase |
| "Invalid API key" | Copy ulang anon key (harus lengkap!) |
| Data tidak muncul | Cek SQL script sudah dijalankan |
| Real-time tidak jalan | Database → Replication → Enable semua |

**Cek Console:**
Tekan F12 di browser → Tab "Console" → Lihat error detail

---

## 📦 File Penting

| File | Deskripsi |
|------|-----------|
| `index.html` | Aplikasi utama (edit credentials di sini) |
| `database-schema.sql` | SQL script untuk Supabase |
| `SUPABASE-SETUP.md` | Panduan lengkap (baca ini untuk detail) |
| `SUPABASE-QUICKSTART.md` | Panduan cepat (file ini) |

---

## 🌐 Deploy Online

### Netlify (Paling Mudah)
1. https://app.netlify.com/drop
2. Drag & drop `index.html`
3. ✅ Online!

### Custom Domain
1. Netlify → Domain Settings
2. Add custom domain
3. Update DNS

---

## 📊 Monitor Usage

**Supabase Dashboard:**
- **Database** → **Usage**: Lihat storage & requests
- **API Logs**: Lihat semua API calls
- **Database** → **Backups**: Download backup

**Free Tier Limits:**
- 500 MB database
- 2 GB bandwidth/month
- 50,000 monthly active users
- (Lebih dari cukup untuk EMKL!)

---

## 🔄 Update Aplikasi

### Update Code (index.html)
1. Edit `index.html`
2. Save
3. Upload ke hosting
4. Refresh browser
5. ✅ Done

### Update Database Schema
1. Supabase → SQL Editor
2. Jalankan query ALTER/CREATE baru
3. ✅ Schema updated

**⚠️ Tidak perlu hapus data!**

---

## 💡 Tips

### Backup Berkala
1. Menu **Backup & Restore**
2. Klik **Download Backup**
3. Simpan file `.json`
4. Lakukan setiap minggu!

### Password Manager
Simpan credentials di:
- File `.env` (jangan upload ke public!)
- Password manager (1Password, Bitwarden)
- Notes terenkripsi

### Testing Before Deploy
1. Test di localhost dulu
2. Pastikan semua fitur jalan
3. Baru deploy ke production

---

## 📞 Help

**Dokumentasi Lengkap:**
Baca `SUPABASE-SETUP.md` untuk detail

**Supabase Docs:**
https://supabase.com/docs

**Supabase Discord:**
https://discord.supabase.com

---

## ✅ Checklist

Setup selesai jika:

- [ ] Project Supabase created
- [ ] SQL script executed
- [ ] 6 tables visible di Table Editor
- [ ] Credentials updated di index.html
- [ ] Login berhasil
- [ ] Test input data berhasil
- [ ] Data muncil di Supabase
- [ ] Real-time sync tested

---

**Version:** 3.0 - Supabase Integration  
**Updated:** November 14, 2025  
**By:** PT Pasir Indah Logistik IT Team

🎉 **Selamat! Aplikasi siap digunakan!**
