# NEO-HUB — IoT Equipment & Project Marketplace

A full-stack e-commerce web application for buying IoT components and ready-made IoT project kits, built with Java Servlets, JSP, and MySQL.

---

## Tech Stack

| Layer | Technology |
|---|---|
| Backend | Java Servlets + JSP |
| Database | MySQL |
| Frontend | Tailwind CSS + HTMX |
| Payment | Khalti API |
| Email | Jakarta Mail (Gmail SMTP) |
| Server | Apache Tomcat 10+ |

---

## Features

- Browse, search, filter and paginate products
- Category-based filtering with live HTMX search
- Add to cart with quantity controls (no page reload)
- Checkout with Cash on Delivery or Khalti payment
- Order confirmation email sent automatically for COD orders
- Admin panel for managing products, orders, categories, promo codes and users
- Role-based access (USER / ADMIN)

---

## Project Structure

```
src/main/java/com/neospark/neohub/
  controller/user/     — User-facing servlets
  controller/admin/    — Admin servlets
  dao/                 — DAO interfaces + implementations
  model/               — Entity classes
  filter/              — Auth filters
  utils/               — EmailUtil, ImageUploadUtil, PasswordUtil

src/main/webapp/
  WEB-INF/views/user/          — User JSP pages
  WEB-INF/views/user/components/ — Reusable partials (product-grid, cart-btn)
  WEB-INF/views/admin/         — Admin JSP pages
  WEB-INF/templates/           — Shared header, footer, head
  static/                      — CSS, JS, images
```

---

## Setup

### 1. Prerequisites
- JDK 17+
- Apache Tomcat 10+
- MySQL 8+
- Maven

### 2. Database
```sql
-- Run the schema file
source neohub_schema.sql
```

### 3. Configure Email (Gmail)
Open `src/main/java/com/neospark/neohub/utils/EmailUtil.java`:
```java
private static final String FROM_EMAIL    = "your@gmail.com";
private static final String FROM_PASSWORD = "your_app_password";
```
Generate an App Password at: Google Account → Security → App Passwords

### 4. Configure Khalti
Open `KhaltiPaymentServlet.java`:
```java
private static final String KHALTI_SECRET_KEY = "your_khalti_secret_key";
```
Get your key from: [khalti.com/merchant](https://khalti.com/merchant)

### 5. Build & Deploy
```bash
mvn clean package
# Copy target/neohub.war to Tomcat webapps/
```

### 6. Image Storage
Uploaded images are stored outside the project at:
```
~/neohub-uploads/products/
~/neohub-uploads/categories/
~/neohub-uploads/profiles/
```
This folder is created automatically on first upload.

### 7. Default Admin Account
Manually insert an admin user into the database:
```sql
INSERT INTO users (full_name, email, password, role)
VALUES ('Admin', 'admin@neohub.com','$2a$10$aCaiJw4Zpmrko9FiWF1AzOUE542GKLfm8vB6JAeHRCYsaYAow8LSK', 'ADMIN');
```

---

## URLs

| Page | URL |
|---|---|
| Home | `/` or `/home` |
| Products | `/products` |
| Product Detail | `/product-detail?id={id}` |
| Cart | `/cart` |
| Checkout | `/checkout` |
| Order History | `/order-history` |
| Profile | `/profile` |
| Admin Dashboard | `/admin/dashboard` |