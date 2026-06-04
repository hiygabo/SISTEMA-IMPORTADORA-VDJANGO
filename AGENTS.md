# AGENTS.md — Sistema Importadora

## Project structure

- `importadora/` — Django project root (where `manage.py` lives)
- `importadora/importadora/` — settings, root URL conf, ASGI/WSGI
- `importadora/app/` — single Django app with views, models, forms, templates, urls
- `venv/` — Python virtual environment (gitignored)
- `script_bd.sql` — Oracle schema + seed data (run manually against DB)

## Framework & DB

- **Django 6.0.4**, Python 3.9+
- **Oracle Database** via `django.db.backends.oracle` (not SQLite)
- **All models are `managed = False`** — schema is created/maintained by running `script_bd.sql` directly on Oracle. Never run `makemigrations` or `migrate`.
- DB credentials: `importadora_db` / `123456` on `localhost:1521/xe` (in settings.py).

## Auth

- **Custom session-based auth** (not Django's contrib.auth).
- Users table is `usuario` (model `Usuario`), with fields: `id_usuario`, `nombre`, `rol`, `contrasena`.
- Roles: `admin`, `trabajador`, `cajero`.
- Login stores `usuario_id`, `usuario_nombre`, `usuario_rol` in `request.session`.
- Logout calls `request.session.flush()`.
- Role checks are manual: `if request.session.get('usuario_rol') != 'admin'`.

## Cart

- Cart is stored in `request.session['carrito']` as `{id_producto_str: cantidad}`.
- Created on Oracle table `detalle_pedido` only when an order is confirmed (with `transaction.atomic()`).

## Key commands

```bash
# from repo root
.venv\Scripts\activate           # activate venv (Windows PowerShell)
cd importadora
python manage.py runserver       # dev server at http://127.0.0.1:8000/

# dependencies
pip install django oracledb      # only two required packages
```

## Seed users (from script_bd.sql)

| id | nombre       | rol        | password       |
|----|-------------|------------|----------------|
| 1  | Gabriel Andia | trabajador | trabGOA2026    |
| 2  | Juan Peredo   | trabajador | trabJUAP2026   |
| 23 | (Marlene)     | cajero     | cajMARL2026    |
| 25 | (Admin)       | admin      | admADMN2026    |

## Testing

- `importadora/app/tests.py` exists but is empty. No test suite configured.
- No lint, typecheck, or format scripts in the project.

## No-go areas

- Do NOT run `python manage.py makemigrations` or `migrate` — DB is managed externally.
- Do NOT add new Django apps without discussion — there is one app (`app`).
- Do NOT convert auth to Django's built-in system — custom session auth is intentional.
- Do NOT remove `managed = False` from models.
