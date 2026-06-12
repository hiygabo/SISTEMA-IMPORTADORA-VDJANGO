# MIRANDA IMPORT MANAGEMENT SYSTEM

**Developed by:** Gabriel Omar Andia Alave

A transactional web system developed with Django and Oracle Database. It features a minimalist "Flat Design" with a Scandinavian aesthetic (100% responsive UI/UX). It efficiently manages cash flows, inventory control, and a shopping cart using logic entirely based on sessions and user roles.

## System Purpose

The primary purpose of the system is to manage the store's product catalog and streamline the checkout process. Sales representatives or customers send a selected list of products along with the customer's name directly to the cashier.
- Upon receiving the product list and the customer's name, the cashier processes the payment with a single click linked to the customer's reference, automatically generating an invoice with all product and customer details.
- Once the payment is completed at the register, the pending order is cleared from the queue.

## Core Features

The system enforces strict access control based on three specific roles (`admin`, `worker`, `cashier`).

1. **Admin (Administration):**
   - Full inventory management dashboard.
   - Can Create, Read, Update, and Delete (CRUD) products, with changes reflecting directly in the Oracle database.
2. **Worker (Sales):**
   - Access to the product catalog with an optimized search bar (using Django ORM's `__icontains`).
   - Temporary shopping cart managed in Memory/Cache (`request.session['carrito']`), preventing database saturation with unapproved orders.
   - Order Submission: Automatically records details (quantities and subtotals), deducts from stock, saves atomically using `transaction.atomic()`, and flags the order as "Pending".
3. **Cashier (Checkout and Billing):**
   - Exclusive access to the "Pending Orders" dashboard.
   - Solely responsible for reviewing order integrity and marking it as "Paid" via a dedicated button, which permanently updates the order status in the database.
   - Generates an automatic invoice upon payment completion.
4. **Secure Custom Login:** - Native identity control utilizing a pre-existing Oracle `usuario` table. Features manual validation with automatic redirection to role-restricted views.

---

## Installation and Deployment Guide

### 1. Prerequisites
- **Python** (version 3.9 or higher).
- **Oracle Database** engine (e.g., Oracle XE local or connected to a remote server), or a DB manager like DBeaver/SQL Developer.

### 2. Database Setup (Oracle)
In the root of this project, you will find the **`script_bd.sql`** file. You need to execute this script entirely in your preferred database manager.

This script is responsible for accurately recreating the database structure:
- Log in to Oracle using SYSTEM, SYS, or any user with DBA privileges and create the following user:
- `CREATE USER importadora_db IDENTIFIED BY 123456;`
- `GRANT ALL PRIVILEGES TO importadora_db;`
- Once the user is ready, simply execute the `script_db.sql` script with this new user to generate the database structure and initial records.

### 3. Clone and Setup the Project (VS Code / Terminal)

```bash
# 1. Clone the repository
git clone [https://github.com/hiygabo/SISTEMA-IMPORTADORA-VDJANGO.git](https://github.com/hiygabo/SISTEMA-IMPORTADORA-VDJANGO.git)

# 2. Enter the cloned root folder
cd SISTEMA-IMPORTADORA-VDJANGO

# 3. Create a Python virtual environment
python -m venv venv

# 4. Activate the environment (Windows PowerShell)
.\venv\Scripts\activate

# 5. Install Django and Oracle utilities (oracledb is the modern driver)
pip install django oracledb


### 4. Configuration in `settings.py`

Navigate to `importadora/importadora/settings.py` and make sure to configure your Oracle connection.
In the `DATABASES` section, adapt the credentials to match your Oracle system:

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.oracle',
        'NAME': 'localhost:1521/xe',       # <--- URL or Service Name of your Oracle instance
        'USER': 'importadora_db',          # <--- Your DB user created earlier
        'PASSWORD': '123456',              # <--- DB password
        'HOST': '',
        'PORT': ''
    }
}
```

### 4. Running the Server

With the script and configuration saved, proceed to start the application:

```bash
# Navigate to the folder where manage.py lives
cd importadora
# Start the server
python manage.py runserver
```

Visit **http://127.0.0.1:8000/** in a web browser. The system will detect that you have no active session and will immediately redirect you to the Flat Design secured login page.

### 5. Screenshots

### Login
![Login](https://i.postimg.cc/QNngWsN1/Captura-de-pantalla-2026-06-12-000524.png)

### Worker Panel
![Worker Panel](https://i.postimg.cc/ydxgVgZw/Captura-de-pantalla-2026-06-12-000752.png)

### Shopping Cart Panel
![Shopping Cart](https://i.postimg.cc/zXKjm68Z/Captura-de-pantalla-2026-06-12-000852.png)

### Cashier Panel
![Cashier Panel](https://i.postimg.cc/3JXgfGFr/Captura-de-pantalla-2026-06-12-000946.png)

### Generated Invoice
![Invoice](https://i.postimg.cc/wBvLBGKC/Captura-de-pantalla-2026-06-12-001032.png)

### Admin Panel (Basic CRUD)
![Admin Panel](https://i.postimg.cc/MKmQmSzX/Captura-de-pantalla-2026-06-12-001227.png)
![Admin Panel](https://i.postimg.cc/1XZ8DWTt/Captura-de-pantalla-2026-06-12-001300.png)
