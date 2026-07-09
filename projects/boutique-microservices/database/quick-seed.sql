-- Simple product seeding with proper UUIDs and working images

-- Add a few sample products
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

-- Add images for these products
INSERT INTO product_images (product_id, image_url, alt_text, is_primary, sort_order)
SELECT 
    p.id,
    CASE 
        WHEN p.name LIKE '%Gown%' THEN 'https://images.unsplash.com/photo-15946338031b5-7f31b2c0d8b5?w=800&q=80'
        WHEN p.name LIKE '%Coat%' THEN 'https://images.unsplash.com/photo-1544967003-f26d5581c8a2?w=800&q=80'
        WHEN p.name LIKE '%Handbag%' THEN 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=800&q=80'
        WHEN p.name LIKE '%Necklace%' THEN 'https://images.unsplash.com/photo-1596944924647-6e6e2b08b550?w=800&q=80'
        WHEN p.name LIKE '%Heels%' THEN 'https://images.unsplash.com/photo-1543166928-355bad0c79e4?w=800&q=80'
    END,
    p.name || ' - Main image',
    true,
    1
FROM products p
WHERE p.sku IN ('LEG-001', 'COAT-001', 'BAG-001', 'JWL-001', 'SHOES-001');