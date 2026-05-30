# Documentation des Mesures DAX Calculées

L'ensemble de la logique métier et des indicateurs de performance clé de Mexora a été développé en langage DAX. Ce document répertorie les formules clés écrites au sein du fichier Power BI.

---

## Indicateurs Généraux et Ventes (Chiffre d'Affaires)

### Chiffre d'Affaires Total (`CA_Total`)
* **Formule DAX** :
  ```dax
  CA_Total = SUM('public_fact_sales'[montant_total])
  ```
* **Objectif** : Calcule le chiffre d'affaires cumulé sur l'ensemble des transactions filtrées.
* **Visualisation** : Utilisé dans les cartes de synthèse (KPI Cards) globales de la page 1 et de l'ensemble des pages.

### CA Année Précédente N-1 (`CA_N_Moins_1`)
* **Formule DAX** :
  ```dax
  CA_N_Moins_1 = CALCULATE([CA_Total], SAMEPERIODLASTYEAR('public_dim_date'[date_key]))
  ```
* **Objectif** : Utilise les fonctions d'intelligence temporelle pour renvoyer le CA de la période équivalente sur l'année N-1.
* **Visualisation** : Utilisé dans les graphiques en courbe d'évolution mensuelle pour comparer visuellement les performances.

### Pourcentage de Croissance du CA (`Evolution_CA_%`)
* **Formule DAX** :
  ```dax
  Evolution_CA_% = DIVIDE([CA_Total] - [CA_N_Moins_1], [CA_N_Moins_1], 0)
  ```
* **Objectif** : Mesure la croissance relative des ventes. Utilise la fonction sécurisée `DIVIDE` pour éviter les erreurs de division par zéro.
* **Visualisation** : Affiché en évidence dans les en-têtes des rapports de performance.

---

## Logistique, Qualité et Retours

### Volume d'Articles Vendus (`Quantite_Vendue`)
* **Formule DAX** :
  ```dax
  Quantite_Vendue = SUM('public_fact_sales'[quantite])
  ```
* **Objectif** : Somme globale des quantités physiques livrées.
* **Visualisation** : Permet de calculer les volumes par entrepôt (ex: Tanger).

### Volume d'Articles Retournés (`Total_Retours`)
* **Formule DAX** :
  ```dax
  Total_Retours = CALCULATE(SUM('public_fact_sales'[quantite]), 'public_fact_sales'[est_retourne] = 1)
  ```
* **Objectif** : Calcule le volume d'articles retournés par les clients pour insatisfaction ou défaut.
* **Visualisation** : Utilisé dans les calculs de qualité opérationnelle.

### Taux de Retour Produit (`Taux_de_Retour`)
* **Formule DAX** :
  ```dax
  Taux_de_Retour = DIVIDE([Total_Retours], [Quantite_Vendue], 0)
  ```
* **Objectif** : Pourcentage d'articles retournés par rapport aux ventes physiques totales.
* **Visualisation** : Graphique de suivi qualité de la page 4 avec mise en forme conditionnelle dynamique (Vert/Orange/Rouge).

---

## Analyses Clients et Saisonnalité (Ramadan)

### Panier Moyen (`Panier_Moyen`)
* **Formule DAX** :
  ```dax
  Panier_Moyen = DIVIDE([CA_Total], DISTINCTCOUNT('public_fact_sales'[id_commande_source]), 0)
  ```
* **Objectif** : Valeur moyenne facturée par commande unique.
* **Visualisation** : Tableau matriciel de la page 3 croisant panier moyen et fréquence d'achat par segment client.

### Indice de Performance Ramadan (`Indice_Ramadan`)
* **Formule DAX** :
  ```dax
  Indice_Ramadan = 
  VAR MoyenneVentesRamadan = CALCULATE(AVERAGE('public_fact_sales'[quantite]), 'public_dim_date'[est_ramadan] = 1)
  VAR MoyenneVentesHorsRamadan = CALCULATE(AVERAGE('public_fact_sales'[quantite]), 'public_dim_date'[est_ramadan] = 0)
  RETURN DIVIDE(MoyenneVentesRamadan, MoyenneVentesHorsRamadan, 0) * 100
  ```
* **Objectif** : Divise la moyenne des ventes en volume pendant le Ramadan par la moyenne des ventes hors Ramadan, multipliée par 100 pour obtenir une base d'indice 100.
* **Visualisation** : Affiché en KPI majeur de la page 5 (Effet Ramadan) pour étayer mathématiquement la surperformance de l'Alimentation.
