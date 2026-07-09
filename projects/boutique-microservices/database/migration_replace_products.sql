BEGIN;

DELETE FROM product_images
WHERE product_id IN (
  SELECT id FROM products
  WHERE name IN (
    'Silk Evening Gown',
    'Cashmere Coat',
    'Leather Handbag',
    'Diamond Necklace',
    'Designer Heels'
  )
);

DELETE FROM products
WHERE name IN (
  'Silk Evening Gown',
  'Cashmere Coat',
  'Leather Handbag',
  'Diamond Necklace',
  'Designer Heels'
);

INSERT INTO products (
  name,
  slug,
  description,
  short_description,
  sku,
  brand,
  category_id,
  price,
  compare_price,
  materials,
  care_instructions,
  inventory_quantity,
  is_featured
)
SELECT
  v.name,
  v.slug,
  v.description,
  v.short_description,
  v.sku,
  v.brand,
  c.id,
  v.price,
  v.compare_price,
  NULL,
  NULL,
  v.inventory_quantity,
  v.is_featured
FROM (
  VALUES
    ('Black Tshirt', 'black-tshirt', 'Premium black cotton t-shirt', 'Premium black cotton t-shirt', 'LEG-101', 'Fabric Clothing', 'Dresses', 600.00::numeric(10,2), 799.00::numeric(10,2), 50, true),
    ('White Hoodie', 'white-hoodie', 'Premium white hoodie', 'Premium white hoodie', 'HOOD-101', 'Fabric Clothing', 'Outerwear', 999.00::numeric(10,2), 1299.00::numeric(10,2), 35, true),
    ('Ceramic Baselayer', 'ceramic-baselayer', 'High performance baselayer', 'High performance baselayer', 'BASE-101', 'Fabric Clothing', 'Dresses', 2000.00::numeric(10,2), 2400.00::numeric(10,2), 20, true),
    ('Navy Blue Tshirt', 'navy-blue-tshirt', 'Premium navy t-shirt', 'Premium navy t-shirt', 'TSHN-101', 'Fabric Clothing', 'Dresses', 650.00::numeric(10,2), 850.00::numeric(10,2), 40, true),
    ('Sand Pant', 'sand-pant', 'Premium casual pants', 'Premium casual pants', 'PANT-101', 'Fabric Clothing', 'Outerwear', 1200.00::numeric(10,2), 1499.00::numeric(10,2), 25, true),
    ('Off Grid Pants', 'off-grid-pants', 'Outdoor cargo pants', 'Outdoor cargo pants', 'CARG-101', 'Fabric Clothing', 'Outerwear', 1800.00::numeric(10,2), 2200.00::numeric(10,2), 30, true),
    ('Chad Blanco', 'chad-blanco', 'Premium fashion shirt', 'Premium fashion shirt', 'SHRT-101', 'Fabric Clothing', 'Dresses', 2200.00::numeric(10,2), 2700.00::numeric(10,2), 18, true),
    ('Abravisto Blu', 'abravisto-blu', 'Luxury blue shirt', 'Luxury blue shirt', 'SHRT-102', 'Fabric Clothing', 'Dresses', 2500.00::numeric(10,2), 2999.00::numeric(10,2), 12, true)
) AS v(name, slug, description, short_description, sku, brand, category_name, price, compare_price, inventory_quantity, is_featured)
JOIN categories c ON c.name = v.category_name;

COMMIT;