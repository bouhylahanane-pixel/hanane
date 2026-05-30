-- ==========================================
-- 03_CREATE_FACT_SALES.SQL
-- DDL de création de la table de faits centrale
-- ==========================================

-- Création de la table de faits transactionnels
CREATE TABLE dwh.public_fact_sales (
    id_transaction INT NOT NULL,
    customer_key INT NOT NULL,
    product_key INT NOT NULL,
    date_key DATE NOT NULL,
    geo_key INT NOT NULL,
    id_commande_source VARCHAR(50) NOT NULL,
    quantite INT NOT NULL DEFAULT 1,
    montant_total DECIMAL(12,2) NOT NULL,
    est_retourne INT NOT NULL DEFAULT 0,
    CONSTRAINT pk_fact_sales PRIMARY KEY (id_transaction),
    CONSTRAINT chk_quantite_positive CHECK (quantite > 0),
    CONSTRAINT chk_est_retourne CHECK (est_retourne IN (0, 1))
);

COMMENT ON TABLE dwh.public_fact_sales IS 'Table de faits centrale consolidant l ensemble des lignes de commandes de Mexora';
