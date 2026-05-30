# Dictionnaire de Donnees du Data Warehouse (Mexora)

Ce dictionnaire répertorie et documente la sémantique de l'ensemble des attributs et colonnes du modèle en étoile.

---

## Table de Faits : `public_fact_sales`
Table centrale consolidant les flux transactionnels de commandes.

| Nom de la Colonne | Type SQL | Format Reporting | Description & Sémantique |
|---|---|---|---|
| `id_transaction` | INT | Entier naturel | Clé primaire identifiant de façon unique chaque ligne d'opération. |
| `customer_key` | INT | Entier naturel | Clé de liaison vers la dimension Client. |
| `product_key` | INT | Entier naturel | Clé de liaison vers la dimension Produit. |
| `date_key` | DATE | Date (AAAA-MM-JJ) | Clé de liaison vers le calendrier temporel. |
| `geo_key` | INT | Entier naturel | Clé de liaison vers le découpage Géographie. |
| `id_commande_source` | VARCHAR(50) | Texte libre | Numéro de la facture/commande provenant de la base opérationnelle ERP. |
| `quantite` | INT | Entier naturel | Quantité physique d'articles achetés dans la ligne. |
| `montant_total` | DECIMAL(12,2) | Devise (MAD) | Montant total en dirhams de la ligne facturée (Chiffre d'Affaires). |
| `est_retourne` | INT | Binaire (0 / 1) | Flag de retour : `1` si le client a retourné l'article, `0` sinon. |

---

## Dimension Clients : `public_dim_customers`
Contient les informations descriptives des clients.

| Nom de la Colonne | Type SQL | Format Reporting | Description & Sémantique |
|---|---|---|---|
| `customer_key` | INT | Entier naturel | Clé primaire unique de la dimension. |
| `nom` | VARCHAR(255) | Texte capitalisé | Nom complet de la personne physique ou morale. |
| `email` | VARCHAR(255) | Texte minuscule | Adresse électronique de contact client. |
| `segment` | VARCHAR(50) | Liste fermée | Profil de fidélité du portefeuille client : **Gold**, **Silver**, **Bronze**. |
| `ville` | VARCHAR(100) | Texte libre | Ville de résidence déclarée lors de l'achat. |

---

## Dimension Produits : `public_dim_products`
Contient la nomenclature complète du catalogue.

| Nom de la Colonne | Type SQL | Format Reporting | Description & Sémantique |
|---|---|---|---|
| `product_key` | INT | Entier naturel | Clé primaire unique de la dimension. |
| `nom_produit` | VARCHAR(255) | Texte libre | Libellé commercial descriptif de l'article. |
| `categorie` | VARCHAR(100) | Liste fermée | Catégorie de tri du catalogue : **Mode**, **Électronique**, **Alimentation**. |
| `prix_actuel` | DECIMAL(10,2) | Devise (MAD) | Prix unitaire standard de vente catalogue en Dirhams. |

---

## Dimension Temps : `public_dim_date`
Permet la navigation granulaire temporelle.

| Nom de la Colonne | Type SQL | Format Reporting | Description & Sémantique |
|---|---|---|---|
| `date_key` | DATE | Date (AAAA-MM-JJ) | Clé primaire représentant un jour civil unique. |
| `annee` | INT | Entier naturel | Année de l'opération sur 4 chiffres (ex: 2024). |
| `trimestre` | INT | Entier (1 à 4) | Numéro de trimestre d'exercice commercial. |
| `mois` | INT | Entier (1 à 12) | Numéro du mois calendaire (ex: 3 pour mars). |
| `jour` | INT | Entier (1 à 31) | Numéro du jour dans le mois. |
| `est_ramadan` | INT | Binaire (0 / 1) | Flag de saisonnalité : `1` si le jour fait partie du Ramadan, `0` sinon. |

---

## Dimension Géographie : `public_dim_geography`
Permet le découpage territorial national.

| Nom de la Colonne | Type SQL | Format Reporting | Description & Sémantique |
|---|---|---|---|
| `geo_key` | INT | Entier naturel | Clé primaire unique de la dimension. |
| `ville` | VARCHAR(100) | Texte libre | Nom de la commune urbaine (ex: Tanger, Marrakech). |
| `region` | VARCHAR(100) | Texte libre | Région administrative territoriale associée au Maroc. |
