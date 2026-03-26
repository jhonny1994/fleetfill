<h1 align="center">FleetFill</h1>

<p align="center">
  <a href="https://github.com/jhonny1994/fleetfill/releases"><img src="https://img.shields.io/github/v/release/jhonny1994/fleetfill?style=flat-square" alt="GitHub Release"></a>
  <a href="https://github.com/jhonny1994/fleetfill/releases"><img src="https://img.shields.io/github/downloads/jhonny1994/fleetfill/total?style=flat-square" alt="GitHub Downloads"></a>
  <a href="https://fleetfill.vercel.app"><img src="https://img.shields.io/badge/Console_Admin-Live-brightgreen?style=flat-square" alt="Console Admin"></a>
</p>

<p align="center">La plateforme intelligente de fret routier pour l'Algérie.</p>

<p align="center">
  <a href="README.md">العربية</a> · <a href="README.en.md">English</a>
</p>

Aide les expéditeurs et les transporteurs à gérer le transport quotidien avec plus de confiance, plus de clarté sur les paiements et une meilleure organisation opérationnelle.

## Mention de propriete

- Ce depot est proprietaire et reste la propriete privee de son auteur.
- Aucun droit ni licence n'est accorde pour utiliser, copier, modifier, redistribuer ou exploiter commercialement ce code source.
- L'acces a ce depot ne donne aucun droit de reutilisation a des tiers.

## Pourquoi FleetFill

- recherche précise de trajets et de capacité
- prix clair avant validation
- contrôle des preuves de paiement avant confirmation
- suivi des expéditions par étapes réelles
- litiges, remboursements et paiements structurés
- support en arabe, français et anglais

## Pour les expéditeurs

- créer une expédition rapidement
- trouver le bon transporteur selon le trajet et la date
- déposer la preuve de paiement et suivre sa validation
- suivre l'avancement de l'expédition étape par étape
- ouvrir un ticket support ou un litige si nécessaire

## Pour les transporteurs

- publier des trajets récurrents ou ponctuels
- gérer véhicules et documents de vérification
- recevoir les réservations dans un flux clair
- mettre à jour les étapes de transport et de livraison
- gérer les comptes de paiement et le suivi opérationnel

## Pour les équipes d'exploitation

- console interne pour la revue des paiements
- workflows de vérification transporteur
- gestion des litiges et des paiements transporteurs
- visibilité support, audit et santé du système

## Téléchargement

<p align="center">
  <a href="https://github.com/jhonny1994/fleetfill/releases/latest"><img src="https://img.shields.io/github/v/release/jhonny1994/fleetfill?label=Télécharger%20APK&style=for-the-badge&logo=android&logoColor=white&color=3DDC84" alt="Télécharger l'APK"></a>
</p>

<p align="center">Téléchargez la dernière version depuis <a href="https://github.com/jhonny1994/fleetfill/releases">GitHub Releases</a>.</p>

## Console d'administration

<p align="center">
  <a href="https://fleetfill.vercel.app"><img src="https://img.shields.io/badge/Console_Admin-Live-brightgreen?style=for-the-badge&logo=vercel&logoColor=white" alt="Console Admin"></a>
</p>

<p align="center">Console interne pour la revue des paiements, la vérification des transporteurs, la gestion des litiges et le suivi de la santé du système.</p>

## Captures d'écran

### Expérience expéditeur

<div align="center">

| Créer une expédition | Trouver un transporteur | Suivre l'expédition |
|:-------------------:|:----------------------:|:------------------:|
| ![Créer une expédition](docs/assets/screenshots/mobile/shipper_create.png) | ![Trouver un transporteur](docs/assets/screenshots/mobile/shipper_search.png) | ![Suivre l'expédition](docs/assets/screenshots/mobile/shipper_track.png) |

</div>

### Expérience transporteur

<div align="center">

| Publier un trajet | Gérer les réservations | Mettre à jour la livraison |
|:----------------:|:---------------------:|:-------------------------:|
| ![Publier un trajet](docs/assets/screenshots/mobile/carrier_trip.png) | ![Gérer les réservations](docs/assets/screenshots/mobile/carrier_bookings.png) | ![Mettre à jour la livraison](docs/assets/screenshots/mobile/carrier_delivery.png) |

</div>

### Console d'administration

<div align="center">

| Revue des paiements | Vérification transporteur | Gestion des litiges |
|:-------------------:|:------------------------:|:-------------------:|
| ![Revue des paiements](docs/assets/screenshots/admin/payments.png) | ![Vérification transporteur](docs/assets/screenshots/admin/carrier_verify.png) | ![Gestion des litiges](docs/assets/screenshots/admin/disputes.png) |

</div>

## Points forts

- produit pensé d'abord pour le marché algérien et la langue arabe
- une seule base d'exploitation pour l'app et l'admin
- notifications, email et suivi dans un même modèle opérationnel
- posture orientée production pour les releases et la validation

## Modèle du dépôt

FleetFill est maintenu comme un monorepo produit pragmatique avec trois surfaces principales :

- application mobile
- admin web
- backend Supabase

Les trois surfaces vivent maintenant comme des racines sœurs dans le dépôt et doivent être comprises comme un seul système produit.

## Construit avec

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Supabase-3FCF8E?style=flat-square&logo=supabase&logoColor=white" alt="Supabase">
  <img src="https://img.shields.io/badge/Next.js-000?style=flat-square&logo=next.js&logoColor=white" alt="Next.js">
  <img src="https://img.shields.io/badge/Vercel-000?style=flat-square&logo=vercel&logoColor=white" alt="Vercel">
</p>

## En savoir plus

- documentation technique et opérationnelle : [docs/README.md](docs/README.md)
- releases signées et chemin de publication : [docs/releases.md](docs/releases.md)
