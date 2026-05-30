// =====================================================================
// FACT_SALES_TRANSFORMATIONS.PQ
// Script de nettoyage et chargement de la table de faits en langage M
// =====================================================================

let
    // 1. Connexion à la source SQL Server locale
    Source = Sql.Database("localhost", "mexora_olap"),
    
    // 2. Extraction de la table de ventes transactionnelle brute
    public_fact_sales_raw = Source{[Schema="public", Item="fact_sales_raw"]}[Data],
    
    // 3. Suppression des attributs techniques d'audit inutiles pour le reporting
    RemovedColumns = Table.RemoveColumns(public_fact_sales_raw, {"created_by", "modified_at"}),
    
    // 4. Remplacement des valeurs nulles logiques dans le flag de retour
    ReplacedNullReturns = Table.ReplaceValue(RemovedColumns, null, 0, Replacer.ReplaceValue, {"est_retourne"}),
    
    // 5. Normalisation des formats et types de données
    TypedColumns = Table.TransformColumnTypes(ReplacedNullReturns, {
        {"id_transaction", Int64.Type}, 
        {"customer_key", Int64.Type}, 
        {"product_key", Int64.Type}, 
        {"date_key", type date}, 
        {"geo_key", Int64.Type}, 
        {"id_commande_source", type text}, 
        {"quantite", Int64.Type}, 
        {"montant_total", Currency.Type}, 
        {"est_retourne", Int64.Type}
    }),
    
    // 6. Filtrage des ventes aberrantes (ex. montants strictement négatifs)
    FilteredCleanSales = Table.SelectRows(TypedColumns, each [montant_total] >= 0 and [quantite] > 0)
in
    FilteredCleanSales
