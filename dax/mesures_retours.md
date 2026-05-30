# Mesures DAX : Analyse de la Qualite et des Retours

Ces indicateurs permettent d'auditer la chaîne logistique et la qualité en surveillant la part de marchandises retournées.

---

## 1. Quantité d'Articles Retournés (`Total_Retours`)
* **Définition** : Somme des quantités physiques pour lesquelles le statut de retour est validé.
* **Code DAX** :
  ```dax
  Total_Retours = CALCULATE(SUM('public_fact_sales'[quantite]), 'public_fact_sales'[est_retourne] = 1)
  ```

---

## 2. Taux de Retour Produit (`Taux_de_Retour`)
* **Définition** : Ratio en pourcentage entre les articles retournés et les articles vendus.
* **Code DAX** :
  ```dax
  Taux_de_Retour = DIVIDE([Total_Retours], [Quantite_Vendue], 0)
  ```

---

## 3. Règle Dynamique de Coloration (Seuils d'Alerte)
Pour la mise en forme conditionnelle du graphique en barres horizontales dans Power BI, la logique de seuils de tolérance appliquée est :
* **Vert** (Taux inférieur à 3%) : Zone saine de conformité logistique.
* **Orange** (Taux compris entre 3% et 5%) : Zone de vigilance modérée.
* **Rouge** (Taux supérieur à 5%) : Zone d'alerte critique nécessitant une rupture ou un audit immédiat de la catégorie (ex. la catégorie **Mode** à **7,8%**).
