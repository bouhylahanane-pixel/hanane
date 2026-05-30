# Architecture Decisionnelle du Projet

L'écosystème décisionnel mis en œuvre pour Mexora repose sur une architecture robuste à 4 niveaux, garantissant une intégrité parfaite des données, une vitesse de calcul optimale pour les indicateurs complexes, et une expérience de visualisation dynamique premium.

---

## Schéma Global du Flux Décisionnel
```text
  ┌────────────────────────┐
  │ Sources Opérationnelles│  -> ERP (Transactions), CRM (Clients), Catalogues (Produits)
  └───────────┬────────────┘
              │ 
              ▼  [Extract]
  ┌────────────────────────┐
  │   ETL (Power Query)    │  -> Nettoyage, typage, dédoublonnage et calculs temporels
  └───────────┬────────────┘
              │ 
              ▼  [Transform & Load]
  ┌────────────────────────┐
  │   Data Warehouse       │  -> Modélisation en Étoile (Star Schema) optimisée
  └───────────┬────────────┘
              │ 
              ▼  [DAX Calculation]
  ┌────────────────────────┐
  │   Power BI (Dataviz)   │  -> Restitution interactive, filtres croisés et alertes visuelles
  └────────────────────────┘
```

---

## Description des Couches de l'Architecture

### 1. Couche Sources de Données (Data Sources)
Cette couche initiale stocke l'historique brut des opérations de Mexora. Elle est composée :
* Des transactions brutes de vente (historique des commandes avec quantités, montants et indicateurs de retours).
* De la base de contacts clients (informations de profil, adresses de livraison, classification d'appartenance).
* Du catalogue produits (identifiants, noms de produits, catégories logistiques et prix unitaires).
* Des tables géographiques modélisant le découpage administratif des villes et des régions du Maroc.

### 2. Couche ETL (Extract, Transform, Load - Power Query)
Le moteur Power Query intégré à Power BI Desktop fait office de processeur de nettoyage :
* **Extraction** : Connexion native aux sources de données.
* **Transformation** : 
  * Suppression des transactions doublonnées ou incomplètes.
  * Standardisation et typage des colonnes (conversion des chaînes en types numériques ou monétaires).
  * Alignement des identifiants clients et produits pour la création des dimensions.
  * Création d'indicateurs de date personnalisés (tels que la colonne logique `est_ramadan`).
* **Chargement** : Exportation des données normalisées directement dans la base en mémoire du moteur Tabulaire de Power BI.

### 3. Couche Data Warehouse (Modélisation)
Pour garantir des performances de calcul optimales en DAX, les données sont organisées sous forme de **schéma en étoile (Star Schema)**. Ce schéma sépare logiquement les faits mesurables et quantifiables (au centre) des axes d'analyse (dimensions environnantes). Les liaisons sont strictement de type **1:* (Un-à-Plusieurs)** avec une direction de filtrage descendante de la dimension vers la table de faits.

### 4. Couche Dataviz & Restitution (Power BI)
La couche de restitution propose aux utilisateurs de Mexora une interface interactive découpée en 5 pages thématiques. Elle tire parti des filtres croisés (slicers) pour permettre aux directeurs d'isoler une région (ex. Tanger), un trimestre ou une année, mettant à jour instantanément les indicateurs visuels clés.
