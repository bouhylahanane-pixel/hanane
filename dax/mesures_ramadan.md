# Mesures DAX : Saisonnalite et Indice Ramadan

Ces mesures isolent et mesurent mathématiquement la surperformance ou sous-performance de consommation durant le mois de Ramadan.

---

## 1. Moyenne des Ventes Hebdomadaires en Ramadan (`Moyenne_Ventes_Ramadan`)
* **Définition** : Quantité moyenne d'articles vendus par semaine sur les dates marquées comme étant incluses dans la période de Ramadan.
* **Code DAX** :
  ```dax
  Moyenne_Ventes_Ramadan = CALCULATE(AVERAGE('public_fact_sales'[quantite]), 'public_dim_date'[est_ramadan] = 1)
  ```

---

## 2. Moyenne des Ventes Hebdomadaires Hors Ramadan (`Moyenne_Ventes_Hors_Ramadan`)
* **Définition** : Quantité moyenne d'articles vendus par semaine en dehors de la période de Ramadan.
* **Code DAX** :
  ```dax
  Moyenne_Ventes_Hors_Ramadan = CALCULATE(AVERAGE('public_fact_sales'[quantite]), 'public_dim_date'[est_ramadan] = 0)
  ```

---

## 3. Indice Saisonnier Ramadan (`Indice_Ramadan`)
* **Définition** : Rapport de comparaison en base 100 de la performance commerciale. Un indice de **135** indique une surperformance de **+35%** en volume alimentaire.
* **Code DAX** :
  ```dax
  Indice_Ramadan = DIVIDE([Moyenne_Ventes_Ramadan], [Moyenne_Ventes_Hors_Ramadan], 0) * 100
  ```
