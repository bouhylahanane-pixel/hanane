# Processus ETL (Extract, Transform, Load) avec Power Query

Le processus de préparation de données a été modélisé dans l'éditeur Power Query en utilisant le langage de script fonctionnel **M**. Cette étape garantit la qualité de la donnée en entrée du Data Warehouse.

---

## Principales Étapes de Transformation Réalisées

### 1. Connexion et Extraction des Sources
Les sources de données opérationnelles (ventes, catalogue produits, fichiers démographiques clients, géographie) sont importées dans l'éditeur. Les chemins et connexions sont paramétrés de façon dynamique.

### 2. Typage Rigoureux des Données
Pour s'assurer du bon fonctionnement des calculs mathématiques et géographiques ultérieurs, les types sont explicitement déclarés :
* `montant_total` converti en type Devise (`Currency.Type`).
* `quantite` converti en type Entier (`Int64.Type`).
* Les clés de date converties en type Date (`type date`).
* Les données textuelles normalisées (première lettre majuscule, suppression des espaces inutiles en début et fin).

### 3. Gestion des Valeurs Nulles et Dédoublonnage
* **Nettoyage** : Remplacement des valeurs vides ou non renseignées sur l'attribut `est_retourne` par la valeur `0` (valeur logique par défaut pour indiquer qu'un produit n'a pas été retourné).
* **Unicité** : Application de l'étape de dédoublonnage (`Table.Distinct`) sur les dimensions `public_dim_customers` et `public_dim_products` en se basant sur les identifiants clés d'origine pour garantir une relation saine de type 1:* vers les faits.

### 4. Normalisation de la Table de Date
Génération d'un calendrier complet à partir des dates de vente minimale et maximale. Les colonnes d'analyses temporelles sont dérivées à l'aide des fonctions de date natives (`Date.Year`, `Date.QuarterOfYear`, `Date.Month`).

### 5. Intégration de la Saisonnalité Ramadan
Pour isoler et analyser l'impact du Ramadan sur la catégorie Alimentation, le processus ETL intègre un calendrier hégirien ou une colonne logique conditionnelle :
* La colonne binaire `est_ramadan` prend la valeur `1` pour toutes les dates correspondant aux périodes du mois sacré de Ramadan pour les années concernées, et la valeur `0` pour le reste de l'année. Cette colonne est ensuite chargée dans le modèle décisionnel pour servir de filtre croisé dans la couche Dataviz.

---

## Fichiers de Scripts M Archivés
Pour permettre un déploiement ou un audit technique rapide, les codes sources de transformation M de chaque table ont été documentés et placés dans le dossier [powerquery/](file:///powerquery/) de ce dépôt :
* [fact_sales_transformations.pq](file:///powerquery/fact_sales_transformations.pq)
* [dim_customers_transformations.pq](file:///powerquery/dim_customers_transformations.pq)
* [dim_products_transformations.pq](file:///powerquery/dim_products_transformations.pq)
* [dim_date_transformations.pq](file:///powerquery/dim_date_transformations.pq)
* [dim_geography_transformations.pq](file:///powerquery/dim_geography_transformations.pq)
