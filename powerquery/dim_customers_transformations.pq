// =====================================================================
// DIM_CUSTOMERS_TRANSFORMATIONS.PQ
// Script Power Query (M) pour la dimension Clients
// =====================================================================

let
    // 1. Connexion à la source CRM (Fichier plat CSV exporté)
    Source = Csv.Document(File.Contents("C:\Data\crm_customers.csv"), [Delimiter=";", Columns=5, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    
    // 2. Promotion de la première ligne comme en-tête de colonne
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    
    // 3. Renommage des colonnes pour correspondre au format du Data Warehouse
    RenamedColumns = Table.RenameColumns(PromotedHeaders, {
        {"id_client", "customer_key"},
        {"nom_client", "nom"},
        {"email_client", "email"},
        {"segment_client", "segment"},
        {"ville_livraison", "ville"}
    }),
    
    // 4. Suppression stricte des doublons sur l'identifiant unique client (PK)
    RemovedDuplicates = Table.Distinct(RenamedColumns, {"customer_key"}),
    
    // 5. Remplacement des valeurs manquantes dans le segment client
    ReplacedMissingSegments = Table.ReplaceValue(RemovedDuplicates, "", "Bronze", Replacer.ReplaceValue, {"segment"}),
    
    // 6. Typage final
    TypedCustomers = Table.TransformColumnTypes(ReplacedMissingSegments, {
        {"customer_key", Int64.Type},
        {"nom", type text},
        {"email", type text},
        {"segment", type text},
        {"ville", type text}
    })
in
    TypedCustomers
