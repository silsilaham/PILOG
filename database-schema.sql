-- =====================================================
-- EMKL PILOG DATABASE SCHEMA FOR SUPABASE
-- =====================================================
-- Created: November 14, 2025
-- Version: 3.0
-- Description: Database schema untuk aplikasi EMKL PILOG
-- 
-- CARA MENGGUNAKAN:
-- 1. Login ke Supabase Dashboard
-- 2. Klik "SQL Editor" di sidebar
-- 3. Copy paste seluruh script ini
-- 4. Klik "Run" atau tekan Ctrl+Enter
-- =====================================================

-- Enable UUID extension for generating unique IDs
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- =====================================================
-- TABLE: jobs
-- Menyimpan semua job order (PPN dan Non-PPN)
-- =====================================================
CREATE TABLE IF NOT EXISTS public.jobs (
    id TEXT PRIMARY KEY,
    data JSONB NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

COMMENT ON TABLE public.jobs IS 'Menyimpan semua job order termasuk containers, invoice, payments, dan operational costs';
COMMENT ON COLUMN public.jobs.id IS 'Format: JO-PPN-YYYYMMDD-XXX atau JO-NP-YYYYMMDD-XXX';
COMMENT ON COLUMN public.jobs.data IS 'JSON object berisi: customerName, vesselVoyage, pol, pod, containers[], invoice{}, operationalCosts[], dll';

-- =====================================================
-- TABLE: banks
-- Menyimpan data rekening bank untuk invoice
-- =====================================================
CREATE TABLE IF NOT EXISTS public.banks (
    id TEXT PRIMARY KEY,
    data JSONB NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

COMMENT ON TABLE public.banks IS 'Menyimpan data rekening bank perusahaan untuk ditampilkan di invoice';
COMMENT ON COLUMN public.banks.data IS 'JSON object berisi: bankName, accountNumber, accountHolder';

-- =====================================================
-- TABLE: customers
-- Menyimpan data pelanggan
-- =====================================================
CREATE TABLE IF NOT EXISTS public.customers (
    id TEXT PRIMARY KEY,
    data JSONB NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

COMMENT ON TABLE public.customers IS 'Master data pelanggan/customer';
COMMENT ON COLUMN public.customers.id IS 'Format: CUST-{timestamp}';
COMMENT ON COLUMN public.customers.data IS 'JSON object berisi: name, address, phone, email';

-- =====================================================
-- TABLE: drivers
-- Menyimpan data sopir/driver
-- =====================================================
CREATE TABLE IF NOT EXISTS public.drivers (
    id TEXT PRIMARY KEY,
    data JSONB NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

COMMENT ON TABLE public.drivers IS 'Master data sopir/driver';
COMMENT ON COLUMN public.drivers.id IS 'Format: DRIVER-{timestamp}';
COMMENT ON COLUMN public.drivers.data IS 'JSON object berisi: name, phone, licensePlate';

-- =====================================================
-- TABLE: invoice_items_master
-- Master data item-item invoice (tidak digunakan di v3.0)
-- =====================================================
CREATE TABLE IF NOT EXISTS public.invoice_items_master (
    id TEXT PRIMARY KEY,
    data JSONB NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

COMMENT ON TABLE public.invoice_items_master IS 'Master data template item invoice (reserved for future use)';
COMMENT ON COLUMN public.invoice_items_master.data IS 'JSON object berisi: description, defaultPrice, category';

-- =====================================================
-- TABLE: operational_cost_items_master
-- Master data item-item biaya operasional
-- =====================================================
CREATE TABLE IF NOT EXISTS public.operational_cost_items_master (
    id TEXT PRIMARY KEY,
    data JSONB NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

COMMENT ON TABLE public.operational_cost_items_master IS 'Master data template item biaya operasional (uang jalan, solar, tol, dll)';
COMMENT ON COLUMN public.operational_cost_items_master.id IS 'Format: OPCITEM-{timestamp}';
COMMENT ON COLUMN public.operational_cost_items_master.data IS 'JSON object berisi: name, category';

-- =====================================================
-- INDEXES FOR PERFORMANCE
-- =====================================================

-- Index untuk pencarian jobs berdasarkan tanggal (descending)
CREATE INDEX IF NOT EXISTS idx_jobs_created_at 
ON public.jobs(created_at DESC);

-- Index untuk pencarian customer berdasarkan JSONB content
CREATE INDEX IF NOT EXISTS idx_customers_data 
ON public.customers USING GIN (data);

-- Index untuk pencarian drivers berdasarkan JSONB content
CREATE INDEX IF NOT EXISTS idx_drivers_data 
ON public.drivers USING GIN (data);

-- Index untuk jobs JSONB content (memungkinkan query complex)
CREATE INDEX IF NOT EXISTS idx_jobs_data 
ON public.jobs USING GIN (data);

-- =====================================================
-- ROW LEVEL SECURITY (RLS)
-- DISABLED karena hanya menggunakan 1 akun login
-- =====================================================

ALTER TABLE public.jobs DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.banks DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.customers DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.drivers DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.invoice_items_master DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.operational_cost_items_master DISABLE ROW LEVEL SECURITY;

-- Note: Jika di masa depan ingin enable RLS, uncomment ini:
-- ALTER TABLE public.jobs ENABLE ROW LEVEL SECURITY;
-- CREATE POLICY "Enable read access for all users" ON public.jobs FOR SELECT USING (true);
-- CREATE POLICY "Enable insert for all users" ON public.jobs FOR INSERT WITH CHECK (true);
-- CREATE POLICY "Enable update for all users" ON public.jobs FOR UPDATE USING (true);
-- CREATE POLICY "Enable delete for all users" ON public.jobs FOR DELETE USING (true);

-- =====================================================
-- REALTIME REPLICATION
-- Enable real-time sync untuk semua tables
-- =====================================================

-- Enable realtime untuk publication default
ALTER PUBLICATION supabase_realtime ADD TABLE public.jobs;
ALTER PUBLICATION supabase_realtime ADD TABLE public.banks;
ALTER PUBLICATION supabase_realtime ADD TABLE public.customers;
ALTER PUBLICATION supabase_realtime ADD TABLE public.drivers;
ALTER PUBLICATION supabase_realtime ADD TABLE public.invoice_items_master;
ALTER PUBLICATION supabase_realtime ADD TABLE public.operational_cost_items_master;

-- =====================================================
-- TRIGGERS
-- Auto-update updated_at timestamp
-- =====================================================

-- Function untuk update timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger untuk jobs
CREATE TRIGGER update_jobs_updated_at 
BEFORE UPDATE ON public.jobs
FOR EACH ROW 
EXECUTE FUNCTION update_updated_at_column();

-- Trigger untuk banks
CREATE TRIGGER update_banks_updated_at 
BEFORE UPDATE ON public.banks
FOR EACH ROW 
EXECUTE FUNCTION update_updated_at_column();

-- Trigger untuk customers
CREATE TRIGGER update_customers_updated_at 
BEFORE UPDATE ON public.customers
FOR EACH ROW 
EXECUTE FUNCTION update_updated_at_column();

-- Trigger untuk drivers
CREATE TRIGGER update_drivers_updated_at 
BEFORE UPDATE ON public.drivers
FOR EACH ROW 
EXECUTE FUNCTION update_updated_at_column();

-- Trigger untuk invoice_items_master
CREATE TRIGGER update_invoice_items_master_updated_at 
BEFORE UPDATE ON public.invoice_items_master
FOR EACH ROW 
EXECUTE FUNCTION update_updated_at_column();

-- Trigger untuk operational_cost_items_master
CREATE TRIGGER update_operational_cost_items_master_updated_at 
BEFORE UPDATE ON public.operational_cost_items_master
FOR EACH ROW 
EXECUTE FUNCTION update_updated_at_column();

-- =====================================================
-- SAMPLE DATA (Opsional - untuk testing)
-- Uncomment untuk insert data contoh
-- =====================================================

/*
-- Sample Bank
INSERT INTO public.banks (id, data) VALUES 
('BANK-001', '{"bankName": "Bank BCA", "accountNumber": "1234567890", "accountHolder": "PT Pasir Indah Logistik"}'),
('BANK-002', '{"bankName": "Bank Mandiri", "accountNumber": "9876543210", "accountHolder": "PT Pasir Indah Logistik"}')
ON CONFLICT (id) DO NOTHING;

-- Sample Customer
INSERT INTO public.customers (id, data) VALUES 
('CUST-001', '{"id": "CUST-001", "name": "PT Contoh Pelanggan", "address": "Jl. Contoh No. 123, Jakarta", "phone": "021-12345678", "email": "customer@example.com"}')
ON CONFLICT (id) DO NOTHING;

-- Sample Driver
INSERT INTO public.drivers (id, data) VALUES 
('DRIVER-001', '{"id": "DRIVER-001", "name": "Budi Santoso", "phone": "081234567890", "licensePlate": "B 1234 XYZ"}')
ON CONFLICT (id) DO NOTHING;

-- Sample Operational Cost Items
INSERT INTO public.operational_cost_items_master (id, data) VALUES 
('OPCITEM-001', '{"id": "OPCITEM-001", "name": "Uang Jalan Sopir"}'),
('OPCITEM-002', '{"id": "OPCITEM-002", "name": "Solar"}'),
('OPCITEM-003', '{"id": "OPCITEM-003", "name": "Tol"}'),
('OPCITEM-004', '{"id": "OPCITEM-004", "name": "Parkir"}'),
('OPCITEM-005', '{"id": "OPCITEM-005", "name": "Makan Sopir"}')
ON CONFLICT (id) DO NOTHING;
*/

-- =====================================================
-- VERIFICATION QUERIES
-- Jalankan query ini untuk verifikasi setup berhasil
-- =====================================================

-- Cek semua tables sudah dibuat
SELECT table_name, table_type 
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_name IN ('jobs', 'banks', 'customers', 'drivers', 'invoice_items_master', 'operational_cost_items_master')
ORDER BY table_name;

-- Cek indexes
SELECT indexname, tablename 
FROM pg_indexes 
WHERE schemaname = 'public' 
AND tablename IN ('jobs', 'banks', 'customers', 'drivers', 'invoice_items_master', 'operational_cost_items_master')
ORDER BY tablename, indexname;

-- Cek triggers
SELECT trigger_name, event_object_table 
FROM information_schema.triggers 
WHERE trigger_schema = 'public' 
AND event_object_table IN ('jobs', 'banks', 'customers', 'drivers', 'invoice_items_master', 'operational_cost_items_master')
ORDER BY event_object_table, trigger_name;

-- Cek jumlah rows di setiap table
SELECT 
    'jobs' as table_name, 
    COUNT(*) as row_count 
FROM public.jobs
UNION ALL
SELECT 
    'banks' as table_name, 
    COUNT(*) as row_count 
FROM public.banks
UNION ALL
SELECT 
    'customers' as table_name, 
    COUNT(*) as row_count 
FROM public.customers
UNION ALL
SELECT 
    'drivers' as table_name, 
    COUNT(*) as row_count 
FROM public.drivers
UNION ALL
SELECT 
    'invoice_items_master' as table_name, 
    COUNT(*) as row_count 
FROM public.invoice_items_master
UNION ALL
SELECT 
    'operational_cost_items_master' as table_name, 
    COUNT(*) as row_count 
FROM public.operational_cost_items_master
ORDER BY table_name;

-- =====================================================
-- DONE!
-- =====================================================
-- Jika semua query verification berhasil, setup database selesai!
-- 
-- Selanjutnya:
-- 1. Copy Project URL dari Settings -> API
-- 2. Copy anon key dari Settings -> API  
-- 3. Update file index.html dengan credentials tersebut
-- 4. Buka aplikasi dan test login
-- 
-- Login default:
-- Username: admin
-- Password: pilog2024
-- =====================================================
