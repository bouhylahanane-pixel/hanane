# Data Warehouse Reporting avec Power BI — Performance Retail & Logistique (Mexora)

## Description du Projet
Ce projet présente la conception et la mise en œuvre d'une solution décisionnelle (Business Intelligence) complète pour **Mexora**, une entreprise retail fictive opérant à l'échelle nationale au Maroc.

L'objectif de cette plateforme décisionnelle est de centraliser les données transactionnelles et démographiques dans un **Data Warehouse modélisé en étoile**, puis de restituer des analyses dynamiques interactives sous **Power BI**. Cette solution dote la direction générale, les directeurs régionaux et les responsables de la chaîne logistique d'une véritable boussole décisionnelle pour piloter l'activité de vente et optimiser l'approvisionnement des stocks.

---

## Objectifs Business
* **Optimisation Commerciale** : Analyser le Chiffre d'Affaires (CA) national pour repérer les moteurs de croissance et ajuster la présence régionale.
* **Performance Supply Chain** : Suivre et anticiper la demande sur le hub logistique majeur de **Tanger** afin de prévenir les ruptures de stock.
* **Gestion de la Qualité et Rentabilité** : Surveiller le **taux de retour produit** par catégorie avec des alertes visuelles dynamiques pour minimiser les coûts de logistique inverse.
* **Fidélisation Clients** : Segmenter le portefeuille client (**Gold**, **Silver**, **Bronze**) pour mettre en place des actions marketing personnalisées.
* **Maîtrise de la Saisonnalité** : Quantifier scientifiquement **l'effet Ramadan** sur la catégorie Alimentation afin de doubler stratégiquement les approvisionnements en période de pic.

---

## Technologies et Méthodes
* **Modélisation de Données** : Schéma en étoile (Star Schema) avec 1 table de faits centrale (`public_fact_sales`) et 4 tables de dimensions.
* **SQL (DDL / DML)** : Structuration logique du Data Warehouse (schéma, tables, clés étrangères).
* **Power Query (Langage M)** : Couche ETL pour l'extraction, le nettoyage, le dédoublonnage et la normalisation des données temporelles.
* **Langage DAX (Data Analysis Expressions)** : Conception de KPIs complexes (Time Intelligence, calculs de moyennes conditionnelles, indices saisonniers).
* **Power BI Desktop** : Création d'un tableau de bord de 5 pages de restitution dynamique à forte valeur ajoutée visuelle.

---

## Aperçu du Modèle de Données (Schéma en Étoile)
Le modèle repose sur une table de faits transactionnelle centrale liée à des axes d'analyse :

```text
       ┌────────────────────────┐
       │ public_dim_customers   │
       └───────────┬────────────┘
                   │ 1
                   │
                   │ *
  ┌────────────────▼────────────────┐         ┌────────────────────────┐
  │        public_fact_sales        │─────────│  public_dim_products   │
  └────────────────▲────────────────┘ *     1 └────────────────────────┘
                   │ *
                   │
                   │ 1
       ┌───────────┴────────────┐
       │    public_dim_date     │
       └────────────────────────┘
                   │ 1
                   │
                   │ *
       ┌───────────▼────────────┐
       │ public_dim_geography   │
       └────────────────────────┘
```

---

## Liste des Dashboards Interactifs
Le rapport Power BI est découpé en **5 pages d'analyse thématique** :
1. **Évolution du chiffre d’affaires** : Suivi des ventes globales, évolution par rapport à l'année précédente (N-1) et cartographie des performances régionales.
2. **Top produits trimestriels** : Focus interactif sur la ville de **Tanger** pour analyser la stabilité des produits leaders et la volatilité saisonnière.
3. **Analyse Segment Client** : Étude du panier moyen et de la fréquence d'achat pour les profils Gold, Silver et Bronze.
4. **Analyse de la Qualité** : Taux de retour produit par catégorie sous forme de barres horizontales dotées d'une coloration conditionnelle tricolore d'alerte.
5. **Effet Ramadan** : Graphique d'évolution des ventes de la catégorie Alimentation avec surlignage temporel de la période sacrée et calcul de l'Indice Ramadan.

---

## Principaux KPI Extraits du Rapport
* **Chiffre d’affaires total** : **14,5 Millions MAD**
* **Évolution du CA vs N-1** : **+12,4%**
* **Top région génératrice de valeur** : **Casablanca-Settat** (générant **42%** du CA global)
* **Top région en croissance logistique** : **Tanger** (avec une progression de **+18%**)
* **Panier moyen par segment** :
  * **Gold** : **850 MAD** (4,2 achats/mois)
  * **Silver** : **410 MAD** (2,1 achats/mois)
  * **Bronze** : **120 MAD** (0,5 achat/mois)
* **Taux de retour produit** :
  * **Mode** : **7,8%** (Seuil critique - Alerte Rouge 🔴)
  * **Électronique** : **4,1%** (Seuil de vigilance - Alerte Orange 🟠)
  * **Alimentation** : **1,2%** (Seuil conforme - Alerte Verte 🟢)
* **Indice Ramadan (Alimentation)** : **135** (surperformance massive de **+35%** en volume de ventes)

---

## Guide d'Installation et d'Utilisation
1. **Cloner le projet** :
   ```bash
   git clone https://github.com/votre-username/Data-Warehouse-Reporting-PowerBI.git
   ```
2. **Ouvrir le modèle décisionnel** :
   * Lancer **Power BI Desktop**.
   * Ouvrir le fichier [Projet-PowerBI.pbix](file:///powerbi/Projet-PowerBI.pbix).
3. **Consulter la documentation et les scripts** :
   * Les scripts SQL de création des tables sont dans [sql/](file:///sql/).
   * Les scripts Power Query (M) sont archivés dans [powerquery/](file:///powerquery/).
   * Les calculs DAX thématiques sont classés dans [dax/](file:///dax/).
   * Le rapport académique original est consultable dans [reports/rapport_business_intelligence.pdf](file:///reports/rapport_business_intelligence.pdf).

---

## Structure du Dépôt
```text
Data-Warehouse-Reporting-PowerBI/
│
├── README.md                               <- Fiche de présentation principale
├── LICENSE                                 <- Licence MIT
├── .gitignore                              <- Règles d'exclusion Git
│
├── docs/                                   <- Documentation métier et technique
│   ├── 01_contexte_projet.md               <- Problématique retail et enjeux de Mexora
│   ├── 02_architecture_bi.md               <- Pipeline de données de la solution BI
│   ├── 03_modelisation_datawarehouse.md    <- Conception du schéma en étoile
│   ├── 04_processus_etl_powerquery.md      <- Étapes détaillées de préparation Power Query
│   ├── 05_mesures_dax.md                   <- Documentation centrale des mesures DAX
│   └── 06_analyse_metier.md                <- Analyses, constats et plans d'actions
│
├── powerbi/
│   ├── Projet-PowerBI.pbix                 <- Fichier Power BI Desktop original
│   └── exports/                            <- Emplacement pour exports d'images
│
├── data/
│   ├── raw/                                <- Fichiers de données brutes d'origine (exclus de Git)
│   ├── processed/                          <- Fichiers intermédiaires nettoyés (exclus de Git)
│   └── data_dictionary.md                  <- Dictionnaire de données complet
│
├── sql/
│   ├── 01_create_schema.sql                <- Initialisation logique du schéma DWH
│   ├── 02_create_dimensions.sql            <- Scripts DDL pour les tables de dimensions
│   ├── 03_create_fact_sales.sql            <- Script DDL pour la table de faits
│   └── 04_relations_constraints.sql        <- Clés étrangères et contraintes d'intégrité
│
├── powerquery/
│   ├── fact_sales_transformations.pq      <- Code M de transformation de la table de faits
│   ├── dim_customers_transformations.pq    <- Code M pour la dimension Clients
│   ├── dim_products_transformations.pq     <- Code M pour la dimension Produits
│   ├── dim_date_transformations.pq         <- Code M pour la table de dates
│   └── dim_geography_transformations.pq    <- Code M pour la dimension Géographie
│
├── dax/                                    <- Fichiers d'indicateurs par thème
│   ├── mesures_kpi.md                      <- Indicateurs généraux de commande et volume
│   ├── mesures_ca.md                       <- Chiffre d'affaires et analyses temporelles
│   ├── mesures_retours.md                  <- Taux de retours et mise en forme conditionnelle
│   ├── mesures_panier_moyen.md             <- Paniers moyens par segment client
│   └── mesures_ramadan.md                  <- Formules pour l'isolation de l'effet Ramadan
│
└── reports/
    └── rapport_business_intelligence.pdf   <- Rapport académique de synthèse
```

---

## Auteurs du Projet
* **BOUHYLA Hanane** - Licence Sciences et Techniques, Analytique de Données (LST AD)
* **EL KHOUMRI Meryem** - Licence Sciences et Techniques, Analytique de Données (LST AD)

**Faculté des Sciences et Techniques de Tanger (FSTT)**  
Département de Génie Informatique, Université Abdelmalek Essaâdi.  
Encadré par le **Pr. ZILI Hassan** (Année Universitaire 2025/2026).
