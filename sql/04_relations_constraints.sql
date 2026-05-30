-- ==========================================
-- 04_RELATIONS_CONSTRAINTS.SQL
-- Application des contraintes de clés étrangères
-- ==========================================

-- Liaison 1:* entre public_dim_customers et public_fact_sales
ALTER TABLE dwh.public_fact_sales
ADD CONSTRAINT fk_sales_customers
FOREIGN KEY (customer_key) 
REFERENCES dwh.public_dim_customers(customer_key)
ON DELETE RESTRICT ON UPDATE CASCADE;

-- Liaison 1:* entre public_dim_products et public_fact_sales
ALTER TABLE dwh.public_fact_sales
ADD CONSTRAINT fk_sales_products
FOREIGN KEY (product_key) 
REFERENCES dwh.public_dim_products(product_key)
ON DELETE RESTRICT ON UPDATE CASCADE;

-- Liaison 1:* entre public_dim_date et public_fact_sales
ALTER TABLE dwh.public_fact_sales
ADD CONSTRAINT fk_sales_date
FOREIGN KEY (date_key) 
REFERENCES dwh.public_dim_date(date_key)
ON DELETE RESTRICT ON UPDATE CASCADE;

-- Liaison 1:* entre public_dim_geography et public_fact_sales
ALTER TABLE dwh.public_fact_sales
ADD CONSTRAINT fk_sales_geography
FOREIGN KEY (geo_key) 
REFERENCES dwh.public_dim_geography(geo_key)
ON DELETE RESTRICT ON UPDATE CASCADE;
