CREATE TABLE `kimia_farma.tabel_analisis` AS
SELECT t.transaction_id, t.date, t.branch_id, 
b.branch_name, b.kota, b.provinsi, b.rating AS rating_cabang, 
t.customer_name, t.product_id, p.product_name, 
p.price AS actual_price, t.discount_percentage,
CASE 
  WHEN p.price <= 50000 THEN 0.1
  WHEN p.price <= 100000 THEN 0.15
  WHEN p.price <= 300000 THEN 0.2
  WHEN p.price <= 500000 THEN 0.25
  ELSE 0.3
END AS persentase_gross_laba,
p.price * (1 - t.discount_percentage) AS nett_sales,
p.price * (1 - t.discount_percentage) *
  CASE 
    WHEN p.price <= 50000 THEN 0.1
    WHEN p.price <= 100000 THEN 0.15
    WHEN p.price <= 300000 THEN 0.2
    WHEN p.price <= 500000 THEN 0.25
    ELSE 0.3
  END AS nett_profit,
t.rating AS rating_transaksi
FROM `kimia_farma.kf_final_transaction` t
JOIN `kimia_farma.kf_kantor_cabang` b 
  ON t.branch_id = b.branch_id
JOIN `kimia_farma.kf_product` p
  ON t.product_id = p.product_id

