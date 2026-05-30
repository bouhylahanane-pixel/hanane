// =====================================================================
// DIM_DATE_TRANSFORMATIONS.PQ
// Script de génération automatique de la dimension Date en langage M
// =====================================================================

let
    // 1. Définition des bornes temporelles de Mexora
    StartDate = #date(2023, 1, 1),
    EndDate = #date(2025, 12, 31),
    
    // 2. Calcul du nombre de jours de différence
    DurationDays = Duration.Days(EndDate - StartDate) + 1,
    
    // 3. Génération de la liste séquentielle de dates
    DatesList = List.Dates(StartDate, DurationDays, #duration(1, 0, 0, 0)),
    
    // 4. Conversion de la liste en tableau
    TableFromList = Table.FromList(DatesList, Splitter.SplitByNothing(), {"date_key"}, null, ExtraValues.Error),
    TypedDateKey = Table.TransformColumnTypes(TableFromList, {{"date_key", type date}}),
    
    // 5. Extraction des colonnes temporelles standardisées
    AddedYear = Table.AddColumn(TypedDateKey, "annee", each Date.Year([date_key]), Int64.Type),
    AddedQuarter = Table.AddColumn(AddedYear, "trimestre", each Date.QuarterOfYear([date_key]), Int64.Type),
    AddedMonth = Table.AddColumn(AddedQuarter, "mois", each Date.Month([date_key]), Int64.Type),
    AddedDay = Table.AddColumn(AddedMonth, "jour", each Date.Day([date_key]), Int64.Type),
    
    // 6. Ajout dynamique du flag Ramadan pour les dates associées au mois sacré au Maroc
    // Exemple pour 2024 (du 11 mars au 9 avril) et 2025 (du 1er mars au 29 mars)
    AddedRamadanFlag = Table.AddColumn(AddedDay, "est_ramadan", each 
        if ([date_key] >= #date(2024, 3, 11) and [date_key] <= #date(2024, 4, 9)) 
        or ([date_key] >= #date(2025, 3, 1) and [date_key] <= #date(2025, 3, 29)) 
        then 1 else 0, Int64.Type)
in
    AddedRamadanFlag
