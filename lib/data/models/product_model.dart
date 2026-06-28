import 'package:flutter/material.dart';

// ── Enums ────────────────────────────────────────────────────────────────────
enum ProductCategory { phones, tablets, wearables, accessories }
enum ProductBrand { apple, samsung, xiaomi, oppo }

// ── Model ────────────────────────────────────────────────────────────────────
class ProductModel {
  final String id;
  final String name;
  final ProductBrand brand;
  final ProductCategory category;
  final String image;
  final double price;
  final double rating;
  final int reviewCount;
  final bool isNew;
  final List<String> colors;
  final List<String> storage;
  final String description;
  final String displaySpec;
  final String cameraSpec;
  final String processorSpec;
  final String batterySpec;
  final String connectivitySpec;
  final double monthlyPrice;
  final int monthlyDuration;

  const ProductModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.image,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.colors,
    required this.storage,
    required this.description,
    required this.displaySpec,
    required this.cameraSpec,
    required this.processorSpec,
    required this.batterySpec,
    required this.connectivitySpec,
    required this.monthlyPrice,
    required this.monthlyDuration,
    this.isNew = false,
  });
}

// ── Sample data ──────────────────────────────────────────────────────────────
final List<ProductModel> sampleProducts = [
  // ── APPLE ──
  ProductModel(
    id: '1',
    name: 'iPhone 15 Pro',
    brand: ProductBrand.apple,
    category: ProductCategory.phones,
    image: 'assets/images/iphone15pro.png',
    price: 999,
    rating: 4.9,
    reviewCount: 320,
    isNew: true,
    colors: ['Black Titanium', 'White Titanium', 'Blue Titanium'],
    storage: ['128GB', '256GB', '512GB', '1TB'],
    description: 'The iPhone 15 Pro features a titanium design with the A17 Pro chip, advanced camera system, and USB-C connectivity.',
    displaySpec: '6.1" Super Retina XDR, ProMotion 120Hz, 2000 nits',
    cameraSpec: '48MP main + 12MP ultra-wide + 12MP 3x telephoto',
    processorSpec: 'Apple A17 Pro, 6-core CPU, 6-core GPU',
    batterySpec: '3274 mAh, MagSafe 15W, USB-C 27W',
    connectivitySpec: '5G, Wi-Fi 6E, Bluetooth 5.3, USB-C 3.0',
    monthlyPrice: 41.63,
    monthlyDuration: 24,
  ),
  ProductModel(
    id: '2',
    name: 'iPhone 15',
    brand: ProductBrand.apple,
    category: ProductCategory.phones,
    image: 'assets/images/iphone15.jpg',
    price: 799,
    rating: 4.7,
    reviewCount: 280,
    isNew: true,
    colors: ['Pink', 'Yellow', 'Green', 'Blue', 'Black'],
    storage: ['128GB', '256GB', '512GB'],
    description: 'iPhone 15 brings Dynamic Island, a 48MP main camera, and USB-C to the mainstream lineup.',
    displaySpec: '6.1" Super Retina XDR, 60Hz, 2000 nits',
    cameraSpec: '48MP main + 12MP ultra-wide',
    processorSpec: 'Apple A16 Bionic, 6-core CPU',
    batterySpec: '3349 mAh, MagSafe 15W, USB-C 27W',
    connectivitySpec: '5G, Wi-Fi 6, Bluetooth 5.3, USB-C 2.0',
    monthlyPrice: 33.29,
    monthlyDuration: 24,
  ),
  ProductModel(
    id: '3',
    name: 'iPad Pro 12.9"',
    brand: ProductBrand.apple,
    category: ProductCategory.tablets,
    image: 'assets/images/ipad_pro.jpg',
    price: 1099,
    rating: 4.9,
    reviewCount: 210,
    isNew: false,
    colors: ['Space Gray', 'Silver'],
    storage: ['128GB', '256GB', '512GB', '1TB', '2TB'],
    description: 'iPad Pro with M2 chip and Liquid Retina XDR display — the ultimate iPad experience.',
    displaySpec: '12.9" Liquid Retina XDR, ProMotion 120Hz, 1600 nits',
    cameraSpec: '12MP main + 10MP ultra-wide + LiDAR scanner',
    processorSpec: 'Apple M2, 8-core CPU, 10-core GPU',
    batterySpec: '10758 mAh, USB-C 30W',
    connectivitySpec: 'Wi-Fi 6E, Bluetooth 5.3, USB-C 3.2, optional 5G',
    monthlyPrice: 45.79,
    monthlyDuration: 24,
  ),
  ProductModel(
    id: '4',
    name: 'Apple Watch Series 9',
    brand: ProductBrand.apple,
    category: ProductCategory.wearables,
    image: 'assets/images/apple_watch_s9.jpg',
    price: 399,
    rating: 4.8,
    reviewCount: 390,
    isNew: true,
    colors: ['Midnight', 'Starlight', 'Red', 'Pink', 'Silver'],
    storage: ['32GB'],
    description: 'Apple Watch Series 9 with the new S9 chip, Double Tap gesture, and brighter Always-On display.',
    displaySpec: '45mm Always-On Retina LTPO OLED, 2000 nits',
    cameraSpec: 'N/A',
    processorSpec: 'Apple S9 SiP, 64-bit dual-core',
    batterySpec: '308 mAh, up to 18h, magnetic fast charging',
    connectivitySpec: 'LTE/UMTS, Wi-Fi, Bluetooth 5.3, NFC, GPS',
    monthlyPrice: 16.63,
    monthlyDuration: 24,
  ),
  ProductModel(
    id: '5',
    name: 'AirPods Pro 2',
    brand: ProductBrand.apple,
    category: ProductCategory.accessories,
    image: 'assets/images/airpods_pro2.jpg',
    price: 249,
    rating: 4.9,
    reviewCount: 560,
    isNew: false,
    colors: ['White'],
    storage: ['N/A'],
    description: 'AirPods Pro 2 with H2 chip deliver up to 2x more ANC, Adaptive Audio, and Personalized Spatial Audio.',
    displaySpec: 'N/A',
    cameraSpec: 'N/A',
    processorSpec: 'Apple H2 chip',
    batterySpec: '6h ANC playback + 24h with case, MagSafe charging',
    connectivitySpec: 'Bluetooth 5.3, H2 chip, USB-C case',
    monthlyPrice: 10.38,
    monthlyDuration: 24,
  ),

  // ── SAMSUNG ──
  ProductModel(
    id: '6',
    name: 'Galaxy S24 Ultra',
    brand: ProductBrand.samsung,
    category: ProductCategory.phones,
    image: 'assets/images/galaxys24ultra.png',
    price: 1299,
    rating: 4.8,
    reviewCount: 510,
    isNew: true,
    colors: ['Titanium Black', 'Titanium Gray', 'Titanium Violet'],
    storage: ['256GB', '512GB', '1TB'],
    description: 'Galaxy S24 Ultra redefines mobile photography with a 200MP camera and Galaxy AI features built in.',
    displaySpec: '6.8" Dynamic AMOLED 2X, 120Hz, 2600 nits',
    cameraSpec: '200MP main + 12MP ultra-wide + 50MP 5x telephoto',
    processorSpec: 'Snapdragon 8 Gen 3, 8-core CPU',
    batterySpec: '5000 mAh, 45W wired, 15W wireless',
    connectivitySpec: '5G, Wi-Fi 7, Bluetooth 5.3, USB-C 3.2',
    monthlyPrice: 54.13,
    monthlyDuration: 24,
  ),
  ProductModel(
    id: '7',
    name: 'Galaxy Tab S9 Ultra',
    brand: ProductBrand.samsung,
    category: ProductCategory.tablets,
    image: 'assets/images/galaxy_tab_s9.jpg',
    price: 1099,
    rating: 4.7,
    reviewCount: 180,
    isNew: false,
    colors: ['Graphite', 'Beige'],
    storage: ['256GB', '512GB', '1TB'],
    description: 'Galaxy Tab S9 Ultra with a stunning 14.6" Dynamic AMOLED 2X display and built-in S Pen.',
    displaySpec: '14.6" Dynamic AMOLED 2X, 120Hz, 930 nits',
    cameraSpec: '13MP main + 8MP ultra-wide',
    processorSpec: 'Snapdragon 8 Gen 2, 8-core CPU',
    batterySpec: '11200 mAh, 45W wired, 15W wireless',
    connectivitySpec: 'Wi-Fi 6E, Bluetooth 5.3, USB-C 3.2, optional 5G',
    monthlyPrice: 45.79,
    monthlyDuration: 24,
  ),
  ProductModel(
    id: '8',
    name: 'Galaxy Watch 6 Classic',
    brand: ProductBrand.samsung,
    category: ProductCategory.wearables,
    image: 'assets/images/galaxy_watch6.jpg',
    price: 349,
    rating: 4.6,
    reviewCount: 270,
    isNew: false,
    colors: ['Black', 'Silver'],
    storage: ['16GB'],
    description: 'Galaxy Watch 6 Classic brings back the iconic rotating bezel with advanced health tracking and Wear OS.',
    displaySpec: '47mm Super AMOLED, Always-On, 579 nits',
    cameraSpec: 'N/A',
    processorSpec: 'Exynos W930, dual-core 1.4GHz',
    batterySpec: '425 mAh, up to 40h, 10W fast charging',
    connectivitySpec: 'LTE, Wi-Fi, Bluetooth 5.3, NFC, GPS',
    monthlyPrice: 14.54,
    monthlyDuration: 24,
  ),
  ProductModel(
    id: '9',
    name: 'Galaxy Buds 2 Pro',
    brand: ProductBrand.samsung,
    category: ProductCategory.accessories,
    image: 'assets/images/galaxy_buds2pro.jpg',
    price: 179,
    rating: 4.5,
    reviewCount: 340,
    isNew: false,
    colors: ['Bora Purple', 'Graphite', 'White'],
    storage: ['N/A'],
    description: 'Galaxy Buds 2 Pro with 24-bit Hi-Fi audio, intelligent ANC, and IPX7 water resistance.',
    displaySpec: 'N/A',
    cameraSpec: 'N/A',
    processorSpec: 'Dual-core processor',
    batterySpec: '5h + 18h with case, wireless charging',
    connectivitySpec: 'Bluetooth 5.3, USB-C',
    monthlyPrice: 7.46,
    monthlyDuration: 24,
  ),

  // ── XIAOMI ──
  ProductModel(
    id: '10',
    name: 'Xiaomi 14 Pro',
    brand: ProductBrand.xiaomi,
    category: ProductCategory.phones,
    image: 'assets/images/xiaomi14pro.png',
    price: 899,
    rating: 4.6,
    reviewCount: 450,
    isNew: true,
    colors: ['Black', 'White'],
    storage: ['256GB', '512GB', '1TB'],
    description: 'Xiaomi 14 Pro pairs the Snapdragon 8 Gen 3 with a Leica-tuned triple camera and 120W HyperCharge.',
    displaySpec: '6.73" LTPO AMOLED, 120Hz, 3000 nits',
    cameraSpec: '50MP Leica main + 50MP ultra-wide + 50MP telephoto',
    processorSpec: 'Snapdragon 8 Gen 3, 8-core CPU',
    batterySpec: '4880 mAh, 120W wired, 50W wireless',
    connectivitySpec: '5G, Wi-Fi 7, Bluetooth 5.4, USB-C 3.2',
    monthlyPrice: 37.46,
    monthlyDuration: 24,
  ),
  ProductModel(
    id: '11',
    name: 'Xiaomi Watch S3',
    brand: ProductBrand.xiaomi,
    category: ProductCategory.wearables,
    image: 'assets/images/xiaomi_watch_s3.jpg',
    price: 199,
    rating: 4.4,
    reviewCount: 150,
    isNew: false,
    colors: ['Silver', 'Black'],
    storage: ['N/A'],
    description: 'Xiaomi Watch S3 with HyperOS, AMOLED display, and up to 15-day battery life.',
    displaySpec: '1.43" AMOLED, 466x466, Always-On',
    cameraSpec: 'N/A',
    processorSpec: 'Dual-core 1.0GHz',
    batterySpec: '486 mAh, up to 15 days, magnetic charging',
    connectivitySpec: 'Bluetooth 5.2, GPS, NFC',
    monthlyPrice: 8.29,
    monthlyDuration: 24,
  ),
  ProductModel(
    id: '12',
    name: 'Xiaomi Buds 4 Pro',
    brand: ProductBrand.xiaomi,
    category: ProductCategory.accessories,
    image: 'assets/images/xiaomi_buds4pro.jpg',
    price: 119,
    rating: 4.4,
    reviewCount: 200,
    isNew: false,
    colors: ['White', 'Black'],
    storage: ['N/A'],
    description: 'Xiaomi Buds 4 Pro with Adaptive ANC 2.0, LDAC hi-res audio, and 9-hour playback.',
    displaySpec: 'N/A',
    cameraSpec: 'N/A',
    processorSpec: 'Xiaomi Surge A1 chip',
    batterySpec: '9h + 27h with case, wireless charging',
    connectivitySpec: 'Bluetooth 5.3, LDAC, USB-C',
    monthlyPrice: 4.96,
    monthlyDuration: 24,
  ),

  // ── OPPO ──
  ProductModel(
    id: '13',
    name: 'OPPO Find X7 Ultra',
    brand: ProductBrand.oppo,
    category: ProductCategory.phones,
    image: 'assets/images/oppo_findx7ultra.jpg',
    price: 1099,
    rating: 4.7,
    reviewCount: 190,
    isNew: true,
    colors: ['Ocean Blue', 'Black'],
    storage: ['256GB', '512GB'],
    description: 'OPPO Find X7 Ultra features Hasselblad quad cameras, Snapdragon 8 Gen 3, and 100W SUPERVOOC charging.',
    displaySpec: '6.82" LTPO AMOLED, 120Hz, 2500 nits',
    cameraSpec: '50MP Hasselblad main + 50MP ultra-wide + dual 50MP telephoto',
    processorSpec: 'Snapdragon 8 Gen 3, 8-core CPU',
    batterySpec: '5000 mAh, 100W wired, 50W wireless',
    connectivitySpec: '5G, Wi-Fi 7, Bluetooth 5.4, USB-C 3.2',
    monthlyPrice: 45.79,
    monthlyDuration: 24,
  ),
  ProductModel(
    id: '14',
    name: 'OPPO Watch X',
    brand: ProductBrand.oppo,
    category: ProductCategory.wearables,
    image: 'assets/images/oppo_watch_x.jpg',
    price: 279,
    rating: 4.4,
    reviewCount: 120,
    isNew: false,
    colors: ['Black Steel', 'Silver'],
    storage: ['N/A'],
    description: 'OPPO Watch X with Snapdragon W5 chip, Dual OS support, and AMOLED display.',
    displaySpec: '1.43" AMOLED, 466x466, Always-On',
    cameraSpec: 'N/A',
    processorSpec: 'Snapdragon W5 Gen 1',
    batterySpec: '500 mAh, up to 4 days, 7.5W charging',
    connectivitySpec: 'LTE, Bluetooth 5.0, Wi-Fi, GPS, NFC',
    monthlyPrice: 11.63,
    monthlyDuration: 24,
  ),
  ProductModel(
    id: '15',
    name: 'OPPO Enco X2',
    brand: ProductBrand.oppo,
    category: ProductCategory.accessories,
    image: 'assets/images/oppo_enco_x2.jpg',
    price: 139,
    rating: 4.3,
    reviewCount: 160,
    isNew: false,
    colors: ['Moonlight Silver', 'Obsidian Black'],
    storage: ['N/A'],
    description: 'OPPO Enco X2 co-engineered with Dynaudio for studio-grade sound with Adaptive ANC.',
    displaySpec: 'N/A',
    cameraSpec: 'N/A',
    processorSpec: 'Dual-core audio chip',
    batterySpec: '9h + 16h with case, wireless charging',
    connectivitySpec: 'Bluetooth 5.3, USB-C',
    monthlyPrice: 5.79,
    monthlyDuration: 24,
  ),
];

// ── Filter ────────────────────────────────────────────────────────────────────
class ProductListFilter {
  final ProductBrand? brand;
  final ProductCategory? category;
  final bool isNewArrivals;

  const ProductListFilter.byBrand(ProductBrand b)
      : brand = b, category = null, isNewArrivals = false;
  const ProductListFilter.byCategory(ProductCategory c)
      : brand = null, category = c, isNewArrivals = false;
  const ProductListFilter.newArrivals()
      : brand = null, category = null, isNewArrivals = true;

  String get title {
    if (isNewArrivals) return 'New Arrivals';
    if (brand != null) {
      final name = brand!.name;
      return name[0].toUpperCase() + name.substring(1);
    }
    switch (category!) {
      case ProductCategory.phones:      return 'Phones';
      case ProductCategory.tablets:     return 'Tablets';
      case ProductCategory.wearables:   return 'Wearables';
      case ProductCategory.accessories: return 'Accessories';
    }
  }

  List<ProductModel> apply(List<ProductModel> all) {
    if (isNewArrivals) return all.where((p) => p.isNew).toList();
    if (brand != null) return all.where((p) => p.brand == brand).toList();
    return all.where((p) => p.category == category).toList();
  }
}

// ── Favourites state ─────────────────────────────────────────────────────────
final ValueNotifier<Set<String>> favoriteIdsNotifier = ValueNotifier(<String>{});

bool isFavorite(ProductModel product) {
  return favoriteIdsNotifier.value.contains(product.id);
}

void toggleFavorite(ProductModel product) {
  final updatedIds = Set<String>.from(favoriteIdsNotifier.value);
  if (!updatedIds.remove(product.id)) {
    updatedIds.add(product.id);
  }
  favoriteIdsNotifier.value = updatedIds;
}

List<ProductModel> favoriteProducts() {
  return sampleProducts
      .where((p) => favoriteIdsNotifier.value.contains(p.id))
      .toList();
}

// ── Cart state ───────────────────────────────────────────────────────────────
final ValueNotifier<List<String>> cartIdsNotifier = ValueNotifier(<String>[]);

bool isInCart(ProductModel product) {
  return cartIdsNotifier.value.contains(product.id);
}

int cartQuantity(ProductModel product) {
  return cartIdsNotifier.value.where((id) => id == product.id).length;
}

void addToCart(ProductModel product) {
  final updated = List<String>.from(cartIdsNotifier.value);
  updated.add(product.id);
  cartIdsNotifier.value = updated;
}

void removeFromCart(ProductModel product) {
  final updated = List<String>.from(cartIdsNotifier.value);
  updated.remove(product.id);
  cartIdsNotifier.value = updated;
}

List<ProductModel> cartProducts() {
  final ids = cartIdsNotifier.value;
  final uniqueIds = ids.toSet().toList();
  return sampleProducts.where((p) => uniqueIds.contains(p.id)).toList();
}

// ── Compare state ────────────────────────────────────────────────────────────
final ValueNotifier<Set<String>> compareIdsNotifier = ValueNotifier(<String>{});

const int maxCompare = 3;

bool isCompared(ProductModel product) {
  return compareIdsNotifier.value.contains(product.id);
}

/// Returns true if the product was added, false if removed or at limit.
bool toggleCompare(ProductModel product) {
  final updated = Set<String>.from(compareIdsNotifier.value);
  if (!updated.remove(product.id)) {
    if (updated.length >= maxCompare) return false;
    updated.add(product.id);
  }
  compareIdsNotifier.value = updated;
  return true;
}

List<ProductModel> compareProducts() {
  return sampleProducts
      .where((p) => compareIdsNotifier.value.contains(p.id))
      .toList();
}