const PRODUCT_IMAGE_MAP: Record<string, string> = {
  'black tshirt': '/product-images/black-tshirt.webp',
  'black-tshirt': '/product-images/black-tshirt.webp',
  'white hoodie': '/product-images/white-hoodie.webp',
  'white-hoodie': '/product-images/white-hoodie.webp',
  'ceramic baselayer': '/product-images/ceramic-baselayer.webp',
  'ceramic-baselayer': '/product-images/ceramic-baselayer.webp',
  'navy blue tshirt': '/product-images/navy-blue-tshirt.webp',
  'navy-blue-tshirt': '/product-images/navy-blue-tshirt.webp',
  'sand pant': '/product-images/sand-pant.webp',
  'sand-pant': '/product-images/sand-pant.webp',
  'off grid pants': '/product-images/off-grid-pant.webp',
  'off-grid-pants': '/product-images/off-grid-pant.webp',
  'chad blanco': '/product-images/chad-blanco.webp',
  'chad-blanco': '/product-images/chad-blanco.webp',
  'abravisto blu': '/product-images/abravisto-blu.webp',
  'abravisto-blu': '/product-images/abravisto-blu.webp',
};

const normalizeKey = (value?: string): string => (value || '').trim().toLowerCase();

export const resolveProductImageUrl = (product: {
  imageUrl?: string;
  image_url?: string;
  name?: string;
  slug?: string;
}): string => {
  const directImage = product.imageUrl || product.image_url;
  if (directImage) {
    return directImage;
  }

  const keyCandidates = [product.slug, product.name]
    .map(normalizeKey)
    .filter(Boolean);

  for (const key of keyCandidates) {
    const mappedImage = PRODUCT_IMAGE_MAP[key];
    if (mappedImage) {
      return mappedImage;
    }
  }

  return '/product-images/placeholder.jpg';
};