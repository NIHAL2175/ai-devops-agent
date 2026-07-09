-- Database initialization script for Boutique Microservices
-- This file will be executed when PostgreSQL container starts

-- ============================================================
-- AUTH DB
-- ============================================================
\c auth_db

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    role VARCHAR(50) DEFAULT 'customer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (email, password_hash, first_name, last_name, role) VALUES
('admin@boutique.com', '$2a$10$placeholder_hash', 'Admin', 'User', 'admin'),
('customer@boutique.com', '$2a$10$placeholder_hash', 'John', 'Doe', 'customer');

-- ============================================================
-- PRODUCTS DB
-- ============================================================
\c products_db

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS categories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL,
    description TEXT,
    image_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS products (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255),
    description TEXT,
    short_description TEXT,
    sku VARCHAR(100),
    brand VARCHAR(100),
    category_id UUID REFERENCES categories(id),
    price DECIMAL(10,2) NOT NULL,
    compare_price DECIMAL(10,2),
    materials TEXT,
    care_instructions TEXT,
    inventory_quantity INTEGER DEFAULT 0,
    is_featured BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS product_images (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id UUID REFERENCES products(id) ON DELETE CASCADE,
    image_url VARCHAR(500) NOT NULL,
    alt_text VARCHAR(255),
    is_primary BOOLEAN DEFAULT false,
    sort_order INTEGER DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO categories (id, name, description) VALUES
('10000000-0000-0000-0000-000000000001', 'Dresses', 'Elegant dresses for special occasions'),
('10000000-0000-0000-0000-000000000002', 'Accessories', 'Luxury accessories and fashion items'),
('10000000-0000-0000-0000-000000000003', 'Bags', 'Designer handbags and tote bags'),
('10000000-0000-0000-0000-000000000004', 'Outerwear', 'Coats and jackets'),
('10000000-0000-0000-0000-000000000005', 'Shoes', 'Designer footwear and heels');

INSERT INTO products (id, name, slug, description, short_description, sku, brand, category_id, price, compare_price, inventory_quantity, is_featured) VALUES
(gen_random_uuid(), 'Black Tshirt', 'black-tshirt',
'Premium black cotton t-shirt', 'Premium black cotton t-shirt', 'LEG-101', 'Fabric Clothing',
'10000000-0000-0000-0000-000000000001', 600.00, 799.00, 50, true),

(gen_random_uuid(), 'White Hoodie', 'white-hoodie',
'Premium white hoodie', 'Premium white hoodie', 'HOOD-101', 'Fabric Clothing',
'10000000-0000-0000-0000-000000000004', 999.00, 1299.00, 35, true),

(gen_random_uuid(), 'Ceramic Baselayer', 'ceramic-baselayer',
'High performance baselayer', 'High performance baselayer', 'BASE-101', 'Fabric Clothing',
'10000000-0000-0000-0000-000000000001', 2000.00, 2400.00, 20, true),

(gen_random_uuid(), 'Navy Blue Tshirt', 'navy-blue-tshirt',
'Premium navy t-shirt', 'Premium navy t-shirt', 'TSHN-101', 'Fabric Clothing',
'10000000-0000-0000-0000-000000000001', 650.00, 850.00, 40, true),

(gen_random_uuid(), 'Sand Pant', 'sand-pant',
'Premium casual pants', 'Premium casual pants', 'PANT-101', 'Fabric Clothing',
'10000000-0000-0000-0000-000000000004', 1200.00, 1499.00, 25, true),

(gen_random_uuid(), 'Off Grid Pants', 'off-grid-pants',
'Outdoor cargo pants', 'Outdoor cargo pants', 'CARG-101', 'Fabric Clothing',
'10000000-0000-0000-0000-000000000004', 1800.00, 2200.00, 30, true),

(gen_random_uuid(), 'Chad Blanco', 'chad-blanco',
'Premium fashion shirt', 'Premium fashion shirt', 'SHRT-101', 'Fabric Clothing',
'10000000-0000-0000-0000-000000000001', 2200.00, 2700.00, 18, true),

(gen_random_uuid(), 'Abravisto Blu', 'abravisto-blu',
'Luxury blue shirt', 'Luxury blue shirt', 'SHRT-102', 'Fabric Clothing',
'10000000-0000-0000-0000-000000000001', 2500.00, 2999.00, 12, true);

-- ============================================================
-- ORDERS DB
-- ============================================================
\c orders_db

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS orders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID,
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) DEFAULT 'pending',
    shipping_address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS order_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id UUID REFERENCES orders(id) ON DELETE CASCADE,
    product_id UUID,
    quantity INTEGER NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
