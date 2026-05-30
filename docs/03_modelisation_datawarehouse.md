# Modelisation du Data Warehouse (Schema en Etoile)

La modélisation multidimensionnelle en étoile est l'approche de référence pour l'analyse décisionnelle. Elle structure la donnée de façon intuitive pour l'utilisateur final et offre d'excellentes performances lors des calculs DAX complexes.

---

## 1. Table de Faits : `public_fact_sales`
Cette table transactionnelle centrale stocke l'ensemble des événements quantifiables de Mexora. Chaque ligne correspond à la facturation d'un produit à un client.

### Structure de la table de faits
| Nom de la Colonne | Type de Donnée | Contrainte / Rôle | Description |
|---|---|---|---|
| `id_transaction` | INT | Clé Primaire (PK) | Identifiant unique de la transaction. |
| `customer_key` | INT | Clé Étrangère (FK) | Référence vers la dimension client. |
| `product_key` | INT | Clé Étrangère (FK) | Référence vers la dimension produit. |
| `date_key` | DATE | Clé Étrangère (FK) | Référence vers la dimension calendrier. |
| `geo_key` | INT | Clé Étrangère (FK) | Référence vers la dimension géographie. |
| `id_commande_source` | VARCHAR(50) | Attribut d'audit | Identifiant de commande d'origine ERP. |
| `quantite` | INT | Mesure brute | Quantité d'articles achetés lors de la ligne de commande. |
| `montant_total` | DECIMAL(12,2) | Mesure brute | Chiffre d'affaires brut généré en dirhams marocains (MAD). |
| `est_retourne` | INT | Binaire (0 ou 1) | Flag indiquant si le produit a été retourné (1 = Oui, 0 = Non). |

---

## 2. Tables de Dimensions

### Dimension Clients : `public_dim_customers`
Fournit l'axe d'analyse démographique et marketing.
* `customer_key` (INT, PK) : Identifiant unique du client.
* `nom` (VARCHAR(255)) : Nom complet du client.
* `email` (VARCHAR(255)) : Adresse électronique.
* `segment` (VARCHAR(50)) : Classification marketing du client (**Gold**, **Silver**, **Bronze**).

### Dimension Produits : `public_dim_products`
Fournit l'axe d'analyse du catalogue de l'entreprise.
* `product_key` (INT, PK) : Identifiant unique du produit.
* `nom_produit` (VARCHAR(255)) : Nom de l'article en vente.
* `categorie` (VARCHAR(100)) : Catégorie principale (**Mode**, **Électronique**, **Alimentation**).
* `prix_actuel` (DECIMAL(10,2)) : Prix de vente catalogue hors promotion.

### Dimension Temps : `public_dim_date`
Permet les analyses temporelles dynamiques (Time Intelligence) et intègre la saisonnalité culturelle.
* `date_key` (DATE, PK) : Clé unique de la date.
* `annee` (INT) : Année sur 4 chiffres.
* `trimestre` (INT) : Numéro du trimestre (1 à 4).
* `mois` (INT) : Numéro du mois (1 à 12).
* `jour` (INT) : Jour de la semaine.
* `est_ramadan` (INT) : Indicateur binaire (1 si la date est incluse dans la période de Ramadan, 0 sinon).

### Dimension Géographie : `public_dim_geography`
Permet la cartographie et l'analyse de performance logistique locale.
* `geo_key` (INT, PK) : Identifiant unique du secteur géographique.
* `ville` (VARCHAR(100)) : Nom de la ville (ex: Tanger, Casablanca, Rabat, Marrakech).
* `region` (VARCHAR(100)) : Région administrative du Maroc (ex: Tanger-Tétouan-Al Hoceïma, Casablanca-Settat).

---

## 3. Relations et Direction du Filtrage
* **Cardinalité** : Toutes les liaisons entre les dimensions et la table de faits centrale sont de type **Un-à-Plusieurs (1:*)**.
* **Intégrité Référentielle** : Chaque transaction de `public_fact_sales` doit obligatoirement posséder un identifiant existant dans chacune des dimensions.
* **Direction du Filtrage** : Le filtre est strictement **unidirectionnel**, circulant de la dimension vers la table de faits. Lorsqu'une catégorie de produit (dans `public_dim_products`) ou une ville (dans `public_dim_geography`) est sélectionnée, le filtre se propage de manière descendante pour restreindre les transactions associées dans la table de faits.
