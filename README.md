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