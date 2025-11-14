# Testing Guide - EMKL Management System v3.0

## 🧪 Panduan Testing Komprehensif

---

## 1. 📱 Testing Responsivitas

### A. Desktop Testing (> 1024px)
**Checklist:**
- [ ] Sidebar terlihat penuh tanpa hamburger menu
- [ ] Dashboard menampilkan 4 stats cards dalam grid 2x2
- [ ] Analytics cards menampilkan 3 cards dalam 1 row
- [ ] Tabel menampilkan semua kolom tanpa horizontal scroll
- [ ] Form menggunakan layout 2 kolom
- [ ] Modal muncul di tengah layar dengan width optimal
- [ ] Bottom navigation TIDAK terlihat

**Cara Test:**
1. Buka browser (Chrome/Firefox/Edge)
2. Set window size ke 1920x1080 atau fullscreen
3. Login dengan: admin / pilog2025
4. Navigasi ke setiap halaman dan cek layout
5. Test create/edit pada setiap modul

---

### B. Tablet Testing (769px - 1024px)
**Checklist:**
- [ ] Sidebar masih terlihat tapi lebih narrow
- [ ] Stats cards menggunakan 2 kolom layout
- [ ] Analytics cards stack menjadi 2-1 layout
- [ ] Tabel memiliki horizontal scroll jika perlu
- [ ] Form bisa 2 kolom atau 1 kolom tergantung ukuran
- [ ] Bottom navigation mulai muncul di layar lebih kecil

**Cara Test:**
1. Resize browser window ke sekitar 800px width
2. Atau gunakan DevTools responsive mode: iPad (768x1024)
3. Test semua fungsi seperti desktop test
4. Perhatikan apakah ada elemen yang overflow

---

### C. Mobile Testing (< 768px)
**Checklist:**
- [ ] Hamburger menu muncul di mobile header
- [ ] Sidebar slide dari kiri saat hamburger di-click
- [ ] Bottom navigation terlihat dan fixed di bottom
- [ ] Stats cards stack vertikal (1 kolom)
- [ ] Analytics cards stack vertikal (1 kolom)
- [ ] Tabel horizontal scroll dengan smooth scrolling
- [ ] Form full width, 1 kolom layout
- [ ] Buttons stack vertikal, full width
- [ ] Modal full width dengan minimal padding
- [ ] Touch targets minimal 48x48px

**Cara Test:**
1. Gunakan DevTools responsive mode
2. Test dengan profiles:
   - iPhone 14 Pro (393x852)
   - Samsung Galaxy S21 (360x800)
   - iPhone SE (375x667)
3. Test touch interactions:
   - Tap buttons
   - Scroll tables
   - Open/close sidebar
   - Fill forms
   - Open modals

**Mobile-specific Tests:**
- [ ] Sidebar open/close animation smooth
- [ ] Bottom nav icons clickable
- [ ] Tables scroll horizontally tanpa body scroll
- [ ] Inputs tidak zoom saat focus (font-size: 16px)
- [ ] Modal tidak keluar dari viewport

---

## 2. 🖨️ Testing Dot Matrix Invoice

### Pre-requisites
- Minimal 1 job order sudah dibuat
- Job order memiliki invoice items
- Container dan driver sudah diinput

### Test Cases

**Test 1: Invoice dengan Item Normal**
1. Buat job order dengan 3-5 invoice items
2. Click "Cetak Dot Matrix" pada job detail
3. Verify PDF output:
   - [ ] Header section tampil (INVOICE, nomor, tanggal)
   - [ ] Shipping details tampil (vessel, route)
   - [ ] Container list terformat rapi dengan numbering
   - [ ] Invoice items dalam table dengan alignment rapi
   - [ ] Subtotal, PPN, Grand Total ter-align ke kanan
   - [ ] Terbilang tidak overflow (wrapped properly)
   - [ ] Payment info tampil lengkap (bank details)
   - [ ] Footer message tampil

**Test 2: Invoice dengan Terbilang Panjang**
1. Buat job order dengan grand total > 100 juta
2. Generate invoice
3. Verify:
   - [ ] Terbilang text wrapped ke multiple lines
   - [ ] Tidak ada text yang terpotong
   - [ ] Alignment tetap rapi

**Test 3: Invoice dengan Banyak Containers**
1. Buat job order dengan 5+ containers
2. Generate invoice
3. Verify:
   - [ ] Semua container tampil dengan numbering
   - [ ] Format tetap konsisten untuk setiap container
   - [ ] Nama sopir tampil dengan benar

**Expected Output Structure:**
```
================================================================
                     NAMA PERUSAHAAN
                     ALAMAT PERUSAHAAN
================================================================

INVOICE NO: JO-XXX-XXXXX                     DATE: DD/MM/YYYY

----------------------------------------------------------------
SHIPPING DETAILS:
Vessel/Voyage : VESSEL-001
Route         : POL → POD
----------------------------------------------------------------

CONTAINERS:
  1. CONT-001 (Sopir: NAMA SOPIR)
  2. CONT-002 (Sopir: NAMA SOPIR)
----------------------------------------------------------------

INVOICE ITEMS:
Description                          Qty    Price         Total
----------------------------------------------------------------
Item 1                                 1    1,000,000  1,000,000
Item 2                                 2    2,500,000  5,000,000
----------------------------------------------------------------
                              Subtotal :           6,000,000
                              PPN 11%  :             660,000
----------------------------------------------------------------
                              GRAND TOTAL :        6,660,000
================================================================

TERBILANG: Enam Juta Enam Ratus Enam Puluh Ribu Rupiah
(text wrapped jika panjang)

================================================================
PAYMENT INFO:
Bank    : BANK NAME
Account : 1234567890
Holder  : ACCOUNT HOLDER NAME
================================================================

Thank you for your business!
```

---

## 3. 📊 Testing Dashboard Analytics

### A. Stats Cards
**Test Steps:**
1. Login dan pastikan berada di dashboard
2. Verify stats cards menampilkan:
   - [ ] Total Job Order (count)
   - [ ] Total Pendapatan (sum of all invoice totals)
   - [ ] Total Biaya (sum of all operational costs)
   - [ ] Laba Bersih (pendapatan - biaya)

**Test with Data:**
1. Create 3 new job orders
2. Add operational costs to each
3. Refresh dashboard
4. Verify:
   - [ ] Angka update dengan benar
   - [ ] Animated counter berjalan smooth
   - [ ] Format currency dengan Rp dan thousand separator

### B. Profit Margin Card
**Formula:** `(Net Profit / Total Revenue) * 100`

**Test Cases:**
1. **Positive Profit:**
   - Revenue: 10,000,000
   - Cost: 7,000,000
   - Expected: 30.0%
   - [ ] Progress bar width = 30%

2. **Negative Profit:**
   - Revenue: 5,000,000
   - Cost: 8,000,000
   - Expected: -60.0%
   - [ ] Progress bar width = 0% (capped at minimum)

3. **Zero Revenue:**
   - Revenue: 0
   - Cost: 0
   - Expected: 0.0%
   - [ ] No division by zero error

### C. Payment Status Card
**Test Steps:**
1. Create job orders dengan berbagai payment status:
   - 2 jobs fully paid (lunas)
   - 2 jobs partial paid (lunas sebagian)
   - 2 jobs unpaid (belum bayar)

2. Verify dashboard shows:
   - [ ] ✅ Lunas: 2 (green)
   - [ ] ⏳ Lunas Sebagian: 2 (blue)
   - [ ] ⚠️ Belum Bayar: 2 (red)

3. Add payment to 1 unpaid job
4. Refresh dashboard
5. Verify counts updated:
   - [ ] Lunas: 2 (unchanged)
   - [ ] Lunas Sebagian: 3 (+1)
   - [ ] Belum Bayar: 1 (-1)

### D. Job Type Distribution Card
**Test Steps:**
1. Create job orders:
   - 3 jobs dengan JO-PPN-* (dengan PPN)
   - 2 jobs dengan JO-NP-* (bebas PPN)

2. Verify dashboard shows:
   - [ ] PPN: 3 (60% bar width)
   - [ ] Non-PPN: 2 (40% bar width)

3. Create 1 more non-PPN job
4. Refresh dashboard
5. Verify updated:
   - [ ] PPN: 3 (50% bar width)
   - [ ] Non-PPN: 3 (50% bar width)

### E. Recent Jobs Table
**Test Steps:**
1. Verify table shows 5 most recent jobs
2. Verify columns:
   - [ ] No. Job
   - [ ] Pelanggan
   - [ ] Tanggal
   - [ ] Status (with colored badge)

3. Test interactions:
   - [ ] Hover effect works (background change)
   - [ ] Click row navigates to job order list
   - [ ] Cursor changes to pointer on hover

---

## 4. 🔄 Testing CRUD Operations

### A. Job Order
**Create Test:**
1. Navigate to "Buat Job Order"
2. Fill all required fields:
   - Customer
   - Shipping details (vessel, POL, POD)
   - Add 2 containers with drivers
   - Add 3 invoice items
   - Select bank account
3. Submit
4. Verify:
   - [ ] Success toast message
   - [ ] Job appears in job list
   - [ ] Job ID generated correctly (JO-PPN-* or JO-NP-*)
   - [ ] Dashboard stats updated

**Read/View Test:**
1. Click "Lihat Detail" on any job
2. Verify modal shows:
   - [ ] All job information
   - [ ] Container list
   - [ ] Invoice items with total
   - [ ] Payment status
   - [ ] Action buttons (Print, Add Payment, Add Cost)

**Update Test:**
1. Add operational cost to existing job
2. Add payment to existing job
3. Verify:
   - [ ] Cost added successfully
   - [ ] Payment recorded
   - [ ] Payment status updated
   - [ ] Dashboard analytics updated

**Delete Test:**
1. Click delete on a job
2. Confirm deletion
3. Verify:
   - [ ] Job removed from list
   - [ ] Dashboard stats updated
   - [ ] Success message shown

### B. Master Data (Customer, Driver, Bank)
- [ ] Create: Form validation works, data saved
- [ ] Read: List displays all entries
- [ ] Update: Edit functionality works
- [ ] Delete: Deletion with confirmation works

---

## 5. 📄 Testing Reports

### A. Daftar Piutang
1. Generate report for specific month/year
2. Verify:
   - [ ] Shows only unpaid/partial jobs
   - [ ] Total piutang calculated correctly
   - [ ] Print PDF works

### B. Laporan Pembayaran
1. Generate report for specific month/year
2. Verify:
   - [ ] Shows all payments in period
   - [ ] Total payment calculated correctly
   - [ ] Grouped by payment date

### C. Laporan Sopir
1. Generate report for specific month/year
2. Verify:
   - [ ] Shows driver activities
   - [ ] Jobs and costs grouped by driver
   - [ ] Total jobs and costs per driver accurate

### D. Laporan Laba/Rugi
1. Generate report for specific month/year
2. Verify:
   - [ ] Separated by PPN and Non-PPN
   - [ ] Shows revenue, cost, profit/loss per job
   - [ ] Grand totals calculated correctly
   - [ ] Profit/loss color coded (green/red)

---

## 6. 🔒 Testing Security & Auth

### Login Test
1. Try login with wrong password
   - [ ] Error message shown
   - [ ] Access denied

2. Login with correct credentials (admin/pilog2025)
   - [ ] Success message
   - [ ] Redirected to dashboard
   - [ ] Session stored

### Logout Test
1. Click logout button (sidebar or mobile)
2. Verify:
   - [ ] Session cleared
   - [ ] Redirected to login page
   - [ ] Cannot access pages without login

---

## 7. 🗄️ Testing Database Operations

### A. Supabase Connection
1. Check browser console for connection status
2. Verify:
   - [ ] Supabase client initialized
   - [ ] No connection errors
   - [ ] Data loads from cloud

### B. localStorage Fallback
1. Disconnect internet
2. Create/edit data
3. Verify:
   - [ ] Data saved to localStorage
   - [ ] Warning shown about offline mode
   - [ ] Data persists on page reload

4. Reconnect internet
5. Sync data (manual or auto)
6. Verify:
   - [ ] Local data pushed to Supabase
   - [ ] No data loss

---

## 8. 🎨 Testing UI/UX

### Animation Tests
- [ ] Card hover animations smooth
- [ ] Button ripple effect works
- [ ] Table row hover effect works
- [ ] Input focus effects work
- [ ] Sidebar slide animation smooth
- [ ] Stats counter animation smooth

### Accessibility Tests
- [ ] Keyboard navigation works
- [ ] Tab order logical
- [ ] Focus visible on all interactive elements
- [ ] Color contrast sufficient
- [ ] Icons have proper labels

### Loading States
- [ ] Login spinner shows during authentication
- [ ] Loading indicators for async operations
- [ ] Skeleton loading for reports (optional)

---

## 9. 🐛 Common Issues & Solutions

### Issue 1: Dashboard Analytics Tidak Muncul
**Solution:**
- Pastikan ada data job orders
- Check browser console for errors
- Verify element IDs match (profit-margin, paid-count, etc.)

### Issue 2: Tabel Overflow di Mobile
**Solution:**
- Pastikan parent div memiliki class `overflow-x-auto`
- Check min-width pada table
- Verify body tidak memiliki overflow-x: visible

### Issue 3: Dot Matrix PDF Tidak Rapi
**Solution:**
- Check browser PDF viewer (try different browser)
- Verify jsPDF library loaded correctly
- Check console for JavaScript errors

### Issue 4: Payment Status Tidak Update
**Solution:**
- Refresh page
- Check getPaymentStatus() function logic
- Verify payment.totalAmount calculation

---

## 10. ✅ Final Checklist

### Pre-Production
- [ ] All tests passed
- [ ] No console errors
- [ ] No console warnings (critical ones)
- [ ] Performance acceptable (< 3s load time)
- [ ] Mobile experience smooth
- [ ] Data persistence works
- [ ] Backup/restore tested

### Documentation
- [ ] CHANGELOG.md updated
- [ ] README.md updated
- [ ] Testing guide created (this file)
- [ ] User manual available

### Deployment
- [ ] Upload index.html to server
- [ ] Configure Supabase credentials
- [ ] Test on production URL
- [ ] SSL certificate valid (if HTTPS)
- [ ] Browser compatibility confirmed

---

## 📝 Test Report Template

```markdown
# Test Report - EMKL Management System

**Date:** [DATE]
**Tester:** [NAME]
**Version:** 3.0
**Browser:** [Chrome/Firefox/Edge] v[VERSION]
**Device:** [Desktop/Tablet/Mobile] [SPECS]

## Test Results

### Responsiveness
- Desktop: ✅ PASS / ❌ FAIL
- Tablet: ✅ PASS / ❌ FAIL
- Mobile: ✅ PASS / ❌ FAIL

### Dot Matrix Invoice
- Structure: ✅ PASS / ❌ FAIL
- Alignment: ✅ PASS / ❌ FAIL
- Word Wrap: ✅ PASS / ❌ FAIL

### Dashboard Analytics
- Stats Cards: ✅ PASS / ❌ FAIL
- Profit Margin: ✅ PASS / ❌ FAIL
- Payment Status: ✅ PASS / ❌ FAIL
- Job Distribution: ✅ PASS / ❌ FAIL

### CRUD Operations
- Create: ✅ PASS / ❌ FAIL
- Read: ✅ PASS / ❌ FAIL
- Update: ✅ PASS / ❌ FAIL
- Delete: ✅ PASS / ❌ FAIL

### Issues Found
1. [Describe issue]
   - Severity: Critical/High/Medium/Low
   - Steps to reproduce: [...]
   - Expected: [...]
   - Actual: [...]

### Recommendations
- [List recommendations for improvements]

**Overall Status:** ✅ APPROVED / ⚠️ APPROVED WITH ISSUES / ❌ REJECTED

**Signature:** ________________
```

---

## 🚀 Quick Test Commands

### Start Local Server
```bash
# Python 3
python -m http.server 8080

# Node.js
npx http-server -p 8080

# PHP
php -S localhost:8080
```

### Access Application
```
http://localhost:8080
```

### Login Credentials
```
Username: admin
Password: pilog2025
```

---

**Happy Testing! 🎉**
