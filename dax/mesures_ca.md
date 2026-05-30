# Mesures DAX : Chiffre d'Affaires et Temporel

Ces formules de calcul financier permettent de suivre les performances monétaires globales de Mexora.

---

## 1. Chiffre d'Affaires Total (`CA_Total`)
* **Définition** : Somme cumulée de la facturation brute en dirhams marocains (MAD).
* **Code DAX** :
  ```dax
  CA_Total = SUM('public_fact_sales'[montant_total])
  ```

---

## 2. Chiffre d'Affaires Année Précédente N-1 (`CA_N_Moins_1`)
* **Définition** : CA réalisé sur la même période calendaire lors de l'année d'exercice précédente (Time Intelligence).
* **Code DAX** :
  ```dax
  CA_N_Moins_1 = CALCULATE([CA_Total], SAMEPERIODLASTYEAR('public_dim_date'[date_key]))
  ```

---

## 3. Pourcentage d'Évolution du CA (`Evolution_CA_%`)
* **Définition** : Évolution relative de croissance du CA comparée à l'année précédente.
* **Code DAX** :
  ```dax
  Evolution_CA_% = DIVIDE([CA_Total] - [CA_N_Moins_1], [CA_N_Moins_1], 0)
  ```
