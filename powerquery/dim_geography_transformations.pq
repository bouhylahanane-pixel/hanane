// =====================================================================
// DIM_GEOGRAPHY_TRANSFORMATIONS.PQ
// Script Power Query (M) pour la dimension Géographie
// =====================================================================

let
    // 1. Connexion au fichier référentiel des villes marocaines
    Source = Xml.Tables(File.Contents("C:\Data\referentiel_maroc.xml")),
    
    // 2. Navigation vers la table interne des villes
    VillesTable = Source{[Name="Villes"]}[Table],
    
    // 3. Renommage des colonnes logiques
    RenamedColumns = Table.RenameColumns(VillesTable, {
        {"id_secteur", "geo_key"},
        {"nom_ville", "ville"},
        {"nom_region", "region"}
    }),
    
    // 4. Typage et dédoublonnage des clés géographiques
    TypedGeography = Table.TransformColumnTypes(RenamedColumns, {
        {"geo_key", Int64.Type},
        {"ville", type text},
        {"region", type text}
    }),
    CleanGeography = Table.Distinct(TypedGeography, {"geo_key"})
in
    CleanGeography
