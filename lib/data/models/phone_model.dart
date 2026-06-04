class PhoneModel {
  final String id;
  final String name;
  final String brand;
  final String image; // asset path
  final double price;
  final double rating;
  final int reviewCount;
  final bool isNew;
  final List<String> colors;
  final List<String> storage;
  final String description;

  // Spec section content
  final String displaySpec;
  final String cameraSpec;
  final String processorSpec;
  final String batterySpec;
  final String connectivitySpec;

  // Monthly payment
  final double monthlyPrice;
  final int monthlyDuration;

  const PhoneModel({
    required this.id,
    required this.name,
    required this.brand,
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
final List<PhoneModel> samplePhones = [
  PhoneModel(
    id: '1',
    name: 'iPhone 15 Pro',
    brand: 'Apple',
    image: 'assets/images/iphone15pro.png',
    price: 999,
    rating: 4.9,
    reviewCount: 320,
    isNew: true,
    colors: ['Black Titanium', 'White Titanium', 'Blue Titanium'],
    storage: ['128GB', '256GB', '512GB', '1TB'],
    description:
        'The iPhone 15 Pro features a titanium design with the A17 Pro chip, advanced camera system, and USB-C connectivity.',
    displaySpec: '6.1" Super Retina XDR, ProMotion 120Hz, 2000 nits',
    cameraSpec: '48MP main + 12MP ultra-wide + 12MP 3x telephoto',
    processorSpec: 'Apple A17 Pro, 6-core CPU, 6-core GPU',
    batterySpec: '3274 mAh, MagSafe 15W, USB-C 27W',
    connectivitySpec: '5G, Wi-Fi 6E, Bluetooth 5.3, USB-C 3.0',
    monthlyPrice: 41.63,
    monthlyDuration: 24,
  ),
  PhoneModel(
    id: '2',
    name: 'Galaxy S24 Ultra',
    brand: 'Samsung',
    image: 'assets/images/galaxys24ultra.png',
    price: 1299,
    rating: 4.8,
    reviewCount: 510,
    isNew: true,
    colors: ['Titanium Black', 'Titanium Gray', 'Titanium Violet'],
    storage: ['256GB', '512GB', '1TB'],
    description:
        'Galaxy S24 Ultra redefines mobile photography with a 200MP camera and Galaxy AI features built in.',
    displaySpec: '6.8" Dynamic AMOLED 2X, 120Hz, 2600 nits',
    cameraSpec: '200MP main + 12MP ultra-wide + 50MP 5x telephoto',
    processorSpec: 'Snapdragon 8 Gen 3, 8-core CPU',
    batterySpec: '5000 mAh, 45W wired, 15W wireless',
    connectivitySpec: '5G, Wi-Fi 7, Bluetooth 5.3, USB-C 3.2',
    monthlyPrice: 54.13,
    monthlyDuration: 24,
  ),
  PhoneModel(
    id: '3',
    name: 'Xiaomi 14 Pro',
    brand: 'Xiaomi',
    image: 'assets/images/xiaomi14pro.png',
    price: 899,
    rating: 4.6,
    reviewCount: 450,
    isNew: true,
    colors: ['Black', 'White'],
    storage: ['256GB', '512GB', '1TB'],
    description:
        'Xiaomi 14 Pro pairs the Snapdragon 8 Gen 3 with a Leica-tuned triple camera and 120W HyperCharge.',
    displaySpec: '6.73" LTPO AMOLED, 120Hz, 3000 nits',
    cameraSpec: '50MP Leica main + 50MP ultra-wide + 50MP telephoto',
    processorSpec: 'Snapdragon 8 Gen 3, 8-core CPU',
    batterySpec: '4880 mAh, 120W wired, 50W wireless',
    connectivitySpec: '5G, Wi-Fi 7, Bluetooth 5.4, USB-C 3.2',
    monthlyPrice: 37.46,
    monthlyDuration: 24,
  ),
];