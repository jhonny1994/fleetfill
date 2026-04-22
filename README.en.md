<h1 align="center">FleetFill</h1>

<p align="center">
  <a href="https://github.com/jhonny1994/fleetfill/releases"><img src="https://img.shields.io/github/v/release/jhonny1994/fleetfill?style=flat-square" alt="GitHub Release"></a>
  <a href="https://github.com/jhonny1994/fleetfill/actions/workflows/ci.yml"><img src="https://img.shields.io/github/actions/workflow/status/jhonny1994/fleetfill/ci.yml?branch=main&style=flat-square&label=CI" alt="CI"></a>
  <img src="https://img.shields.io/badge/Admin-Hosted-brightgreen?style=flat-square" alt="Admin Console">
</p>

<p align="center"><strong>Smart road freight operations for Algeria.</strong></p>

<p align="center">
  FleetFill brings shippers, carriers, and operations teams onto one product system for booking, payment-proof review, shipment tracking, carrier verification, disputes, and payout follow-through.
</p>

<p align="center">
  <a href="README.md">العربية</a> · <a href="README.fr.md">Français</a>
</p>

## Why It Matters

- Better matching between freight demand and available truck capacity
- Clearer payment handling before operational commitment
- Real shipment lifecycle tracking instead of informal status chasing
- Structured support, dispute, and payout workflows
- Arabic, French, and English support built into the product

## Live Product Surfaces

- Android app releases: [GitHub Releases](https://github.com/jhonny1994/fleetfill/releases)
- Admin operations console: configured on the active production hosting provider

## What Is In This Repository

FleetFill is a product monorepo with three first-class surfaces:

- `apps/mobile`
  - Flutter mobile application for shippers and carriers
- `apps/admin-web`
  - Next.js internal operations console
- `backend/supabase`
  - Supabase schema, RLS, RPCs, seeds, and Edge Functions

## Production Posture

- protected `main` branch with required checks and review
- unified CI for mobile, admin-web, and backend validation
- production release workflows for backend, web, and mobile
- coordinated whole-product release orchestration through GitHub Actions

Start here for the engineering view:

- [Documentation index](docs/README.en.md)
- [Architecture](docs/architecture.md)
- [Delivery model](docs/delivery.md)
- [Release operations](docs/releases.md)

## Product Snapshots

<div align="center">

| Mobile | Admin |
|:------:|:-----:|
| ![Shipper mobile experience](docs/assets/screenshots/mobile/shipper_track.png) | ![Admin console](docs/assets/screenshots/admin/payments.png) |

</div>

## Repository Access And Reuse

This repository is publicly visible for product evaluation, due diligence, and access to official FleetFill releases. The source code, documentation, and assets remain proprietary. No license is granted to reuse, modify, redistribute, or commercially exploit this repository or its contents.

See [PROPRIETARY-NOTICE.md](PROPRIETARY-NOTICE.md) for the full notice.

## Technology

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Supabase-3FCF8E?style=flat-square&logo=supabase&logoColor=white" alt="Supabase">
  <img src="https://img.shields.io/badge/Next.js-000?style=flat-square&logo=next.js&logoColor=white" alt="Next.js">
  <img src="https://img.shields.io/badge/Hosted_Admin-Web-0A7CFF?style=flat-square" alt="Hosted Admin Web">
</p>
