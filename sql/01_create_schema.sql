-- ==========================================
-- 01_CREATE_SCHEMA.SQL
-- Initialisation logique du schéma décisionnel
-- ==========================================

-- Création du schéma d'entrepôt de données (DWH)
CREATE SCHEMA IF NOT EXISTS dwh;

COMMENT ON SCHEMA dwh IS 'Schéma centralisant les données structurées en étoile pour le projet décisionnel de Mexora Retail';
