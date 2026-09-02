# Amna Food Industries Mobile App

Flutter mobile app for **Amna Food Industries** order bookers.

## Features

- Username + password login (mock mode when `API_BASE_URL` is empty)
- Dashboard with quick access to create sales orders
- Odoo-style sales order form: customer, product, quantity, unit price, notes
- Mock customers/products until backend APIs are connected

## Setup

```bash
cd M:\WMSols\amna_food_industries_mobile_app
flutter pub get
cp .env.example .env   # already present for local dev
flutter run
```

## Environment (`.env`)

| Variable | Description |
|---|---|
| `API_BASE_URL` | Odoo/backend base URL. Leave empty for mock mode. |
| `ODOO_DATABASE` | Odoo database name (sent as `X-Odoo-Database` header). |
| `API_ENVELOPE` | `ok_data` (default) or `direct` response parsing. |

## Platforms

Android and iOS only.

When `API_BASE_URL` is empty, any username/password signs in and catalog data is seeded locally.

## Branding

- App label: **AF**
- Primary: `#ED1B24`
- Secondary: `#00A9E2`
