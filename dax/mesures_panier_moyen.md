# Mesures DAX : Panier Moyen et Profils Clients

Ces formules segmentent les ventes en calculant la contribution financière et les habitudes d'achat.

---

## 1. Dépense Moyenne par Commande (`Panier_Moyen`)
* **Définition** : Somme facturée moyenne pour chaque commande unique validée.
* **Code DAX** :
  ```dax
  Panier_Moyen = DIVIDE([CA_Total], DISTINCTCOUNT('public_fact_sales'[id_commande_source]), 0)
  ```

---

## 2. CA Spécifique au Segment Gold (`CA_Segment_Gold`)
* **Définition** : Chiffre d'affaires cumulé exclusivement sur le portefeuille de clients classés Gold.
* **Code DAX** :
  ```dax
  CA_Segment_Gold = CALCULATE([CA_Total], 'public_dim_customers'[segment] = "Gold")
  ```
