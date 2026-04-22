<h1 align="center">FleetFill</h1>

<p align="center">
  <a href="https://github.com/jhonny1994/fleetfill/releases"><img src="https://img.shields.io/github/v/release/jhonny1994/fleetfill?style=flat-square" alt="GitHub Release"></a>
  <a href="https://github.com/jhonny1994/fleetfill/actions/workflows/ci.yml"><img src="https://img.shields.io/github/actions/workflow/status/jhonny1994/fleetfill/ci.yml?branch=main&style=flat-square&label=CI" alt="CI"></a>
  <img src="https://img.shields.io/badge/Console_Admin-Hébergée-brightgreen?style=flat-square" alt="Console Admin">
</p>

<p align="center"><strong>La plateforme intelligente de fret routier pour l'Algérie.</strong></p>

<p align="center">
  FleetFill réunit expéditeurs, transporteurs et équipes d'exploitation dans un même système produit pour la réservation, la revue des preuves de paiement, le suivi des expéditions, la vérification transporteur, les litiges et les paiements.
</p>

<p align="center">
  <a href="README.md">العربية</a> · <a href="README.en.md">English</a>
</p>

## Pourquoi c'est utile

- recherche précise de trajets et de capacité
- prix clair avant validation
- contrôle des preuves de paiement avant confirmation
- suivi des expéditions par étapes réelles
- litiges, remboursements et paiements structurés
- support en arabe, français et anglais

## Surfaces en ligne

- releases Android officielles : [GitHub Releases](https://github.com/jhonny1994/fleetfill/releases)
- console d'exploitation : configurée sur le fournisseur d'hébergement actif

## Ce que contient ce dépôt

FleetFill est organisé comme un monorepo produit avec trois surfaces principales :

- `apps/mobile`
  - application Flutter pour expéditeurs et transporteurs
- `apps/admin-web`
  - console interne Next.js pour les opérations
- `backend/supabase`
  - schéma, politiques, RPC, seeds et Edge Functions

## Posture de production

- branche `main` protégée avec revue et contrôles obligatoires
- CI unifiée pour mobile, admin-web et backend
- workflows de déploiement séparés pour le backend, le web et le mobile
- orchestration globale des releases via GitHub Actions

Pour une vue technique rapide :

- [Index de la documentation](docs/README.fr.md)
- [Architecture](docs/architecture.md)
- [Modèle de delivery](docs/delivery.md)
- [Opérations de release](docs/releases.md)

## Aperçu produit

<div align="center">

| Mobile | Admin |
|:------:|:-----:|
| ![Suivre l'expédition](docs/assets/screenshots/mobile/shipper_track.png) | ![Revue des paiements](docs/assets/screenshots/admin/payments.png) |

</div>

## Accès et réutilisation

Ce dépôt est public pour l'évaluation du produit, la revue technique et l'accès aux releases officielles. Le code source, la documentation et les assets restent propriétaires. Aucun droit n'est accordé pour la réutilisation, la modification, la redistribution ou l'exploitation commerciale.

Voir [PROPRIETARY-NOTICE.md](PROPRIETARY-NOTICE.md) pour la formulation complète.

## Construit avec

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Supabase-3FCF8E?style=flat-square&logo=supabase&logoColor=white" alt="Supabase">
  <img src="https://img.shields.io/badge/Next.js-000?style=flat-square&logo=next.js&logoColor=white" alt="Next.js">
  <img src="https://img.shields.io/badge/Admin_Web-Hébergé-0A7CFF?style=flat-square" alt="Admin Web Hébergé">
</p>
