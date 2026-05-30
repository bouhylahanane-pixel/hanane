-- ==========================================
-- 02_CREATE_DIMENSIONS.SQL
-- DDL de création des tables de dimensions
-- ==========================================

-- 1. Table de Dimension Temps (public_dim_date)
CREATE TABLE dwh.public_dim_date (
    date_key DATE NOT NULL,
    annee INT NOT NULL,
    trimestre INT NOT NULL,
    mois INT NOT NULL,
    jour INT NOT NULL,
    est_ramadan INT NOT NULL DEFAULT 0,
    CONSTRAINT pk_dim_date PRIMARY KEY (date_key),
    CONSTRAINT chk_est_ramadan CHECK (est_ramadan IN (0, 1))
);

COMMENT ON TABLE dwh.public_dim_date IS 'Dimension Temps modélisant le calendrier grégorien et intégrant le flag binaire Ramadan';

-- 2. Table de Dimension Clients (public_dim_customers)
CREATE TABLE dwh.public_dim_customers (
    customer_key INT NOT NULL,
    nom VARCHAR(255) NOT NULL,
    email VARCHAR(255) NULL,
    segment VARCHAR(50) NOT NULL,
    ville VARCHAR(100) NULL,
    CONSTRAINT pk_dim_customers PRIMARY KEY (customer_key),
    CONSTRAINT chk_segment CHECK (segment IN ('Gold', 'Silver', 'Bronze'))
);

COMMENT ON TABLE dwh.public_dim_customers IS 'Dimension Clients modélisant les profils démographiques et leur niveau de fidélité';

-- 3. Table de Dimension Produits (public_dim_products)
CREATE TABLE dwh.public_dim_products (
    product_key INT NOT NULL,
    nom_produit VARCHAR(255) NOT NULL,
    categorie VARCHAR(100) NOT NULL,
    prix_actuel DECIMAL(10,2) NOT NULL,
    CONSTRAINT pk_dim_products PRIMARY KEY (product_key),
    CONSTRAINT chk_prix_positif CHECK (prix_actuel >= 0)
);

COMMENT ON TABLE dwh.public_dim_products IS 'Dimension Produits recensant le catalogue des articles de Mexora classés par catégorie';

-- 4. Table de Dimension Géographie (public_dim_geography)
CREATE TABLE dwh.public_dim_geography (
    geo_key INT NOT NULL,
    ville VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL,
    CONSTRAINT pk_dim_geography PRIMARY KEY (geo_key)
);

COMMENT ON TABLE dwh.public_dim_geography IS 'Dimension Géographie structurant le découpage par ville et région au Maroc';
