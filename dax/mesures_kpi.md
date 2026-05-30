# Mesures DAX : KPIs Generaux de Volume et Commandes

Ces indicateurs calculent la volumétrie générale d'activité commerciale pour Mexora.

---

## 1. Nombre de Commandes Uniques (`Total_Commandes`)
* **Définition** : Compte de manière distincte les numéros de commandes pour identifier le volume global d'achats.
* **Code DAX** :
  ```dax
  Total_Commandes = DISTINCTCOUNT('public_fact_sales'[id_commande_source])
  ```

---

## 2. Volume Total d'Articles Vendus (`Quantite_Vendue`)
* **Définition** : Somme cumulée du nombre d'unités physiques vendues.
* **Code DAX** :
  ```dax
  Quantite_Vendue = SUM('public_fact_sales'[quantite])
  ```

---

## 3. Évolution en Volume vs N-1 (`Evolution_Volume_%`)
* **Définition** : Pourcentage de croissance physique du nombre d'articles vendus par rapport à la même période de l'année précédente.
* **Code DAX** :
  ```dax
  Evolution_Volume_% = 
  VAR Volume_N_1 = CALCULATE([Quantite_Vendue], SAMEPERIODLASTYEAR('public_dim_date'[date_key]))
  RETURN DIVIDE([Quantite_Vendue] - Volume_N_1, Volume_N_1, 0)
  ```
