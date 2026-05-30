// =====================================================================
// DIM_PRODUCTS_TRANSFORMATIONS.PQ
// Script Power Query (M) pour la dimension Produits
// =====================================================================

let
    // 1. Connexion à la source Base Articles (Fichier Excel de référence)
    Source = Excel.Workbook(File.Contents("C:\Data\catalogue_produits.xlsx"), null, true),
    CatalogSheet = Source{[Item="Catalog", Kind="Sheet"]}[Data],
    
    // 2. Promotion des en-têtes
    PromotedHeaders = Table.PromoteHeaders(CatalogSheet, [PromoteAllScalars=true]),
    
    // 3. Renommage des attributs
    RenamedColumns = Table.RenameColumns(PromotedHeaders, {
        {"id_produit", "product_key"},
        {"description", "nom_produit"},
        {"categorie_produit", "categorie"},
        {"prix_unitaire", "prix_actuel"}
    }),
    
    // 4. Nettoyage de la casse sur la catégorie
    CapitalizedCategory = Table.TransformColumns(RenamedColumns, {{"categorie", Text.Proper, type text}}),
    
    // 5. Typage et formatage
    TypedProducts = Table.TransformColumnTypes(CapitalizedCategory, {
        {"product_key", Int64.Type},
        {"nom_produit", type text},
        {"categorie", type text},
        {"prix_actuel", Currency.Type}
    }),
    
    // 6. Filtre des produits de test sans clé d'identification
    CleanProducts = Table.SelectRows(TypedProducts, each [product_key] <> null)
in
    CleanProducts
