/// ---------------------------------------------------------------------
/// Models
/// ---------------------------------------------------------------------

class SignType {
  String id;
  String title;

  SignType({required this.id, required this.title});
}

class SizeItem {
  String id;
  String signTypeId;
  String size;
  double price;

  SizeItem({
    required this.id,
    required this.signTypeId,
    required this.size,
    required this.price,
  });
}

class MaterialItem {
  String id;
  String name;
  String category;
  String vendor;
  DateTime? purchaseDate;
  DateTime? receivedDate;
  double unitCost;
  double price;

  MaterialItem({
    required this.id,
    required this.name,
    required this.category,
    required this.vendor,
    required this.purchaseDate,
    required this.receivedDate,
    required this.unitCost,
    required this.price,
  });
}

class PrintOption {
  String id;
  String signTypeId;
  String name;
  double price;

  PrintOption({
    required this.id,
    required this.signTypeId,
    required this.name,
    required this.price,
  });
}

class DeliveryMethod {
  String id;
  String signTypeId;
  String name;
  double price;

  DeliveryMethod({
    required this.id,
    required this.signTypeId,
    required this.name,
    required this.price,
  });
}

/// ---------------------------------------------------------------------
/// Seed / in-memory data store (shared across screens for this session)
/// ---------------------------------------------------------------------

class AppData {
  AppData._();
  static final AppData instance = AppData._();

  int _idCounter = 1000;
  String nextId() => (_idCounter++).toString();

  final List<SignType> signTypes = [
    SignType(id: '1', title: 'Rider'),
    SignType(id: '2', title: 'For Sale Signs'),
    SignType(id: '3', title: 'For Sale Directionals'),
    SignType(id: '4', title: 'Open House sign'),
  ];

  final List<SizeItem> sizes = [
    SizeItem(id: '1', signTypeId: '1', size: '24x6', price: 45),
    SizeItem(id: '2', signTypeId: '1', size: '24x9', price: 55),
    SizeItem(id: '3', signTypeId: '2', size: '24x18', price: 95),
    SizeItem(id: '4', signTypeId: '2', size: '24x24', price: 105),
    SizeItem(id: '5', signTypeId: '2', size: '24x30', price: 115),
    SizeItem(id: '6', signTypeId: '2', size: '24x36', price: 125),
    SizeItem(id: '7', signTypeId: '2', size: '30x24', price: 135),
    SizeItem(id: '8', signTypeId: '3', size: '18x24', price: 80),
    SizeItem(id: '9', signTypeId: '4', size: '24x24', price: 110),
  ];

  final List<String> materialCategories = [
    'Sign Post',
    'Main Panel',
    'Rider Panel',
  ];

  final List<MaterialItem> materials = [
    MaterialItem(
        id: '1',
        name: 'Aluminum Sheet',
        category: 'Sign Post',
        vendor: 'ABC Metals',
        purchaseDate: DateTime(2026, 4, 1),
        receivedDate: DateTime(2026, 4, 3),
        unitCost: 12,
        price: 120),
    MaterialItem(
        id: '2',
        name: 'Acrylic Board',
        category: 'Main Panel',
        vendor: 'Plastico Ltd',
        purchaseDate: DateTime(2026, 4, 2),
        receivedDate: DateTime(2026, 4, 4),
        unitCost: 9.5,
        price: 95),
    MaterialItem(
        id: '3',
        name: 'PVC Foam Board',
        category: 'Rider Panel',
        vendor: 'Foam House',
        purchaseDate: DateTime(2026, 4, 3),
        receivedDate: DateTime(2026, 4, 5),
        unitCost: 7.5,
        price: 75),
    MaterialItem(
        id: '4',
        name: 'LED Strip',
        category: 'Sign Post',
        vendor: 'Bright Lights Co',
        purchaseDate: DateTime(2026, 4, 4),
        receivedDate: DateTime(2026, 4, 6),
        unitCost: 4.5,
        price: 45),
    MaterialItem(
        id: '5',
        name: 'Steel Frame',
        category: 'Main Panel',
        vendor: 'SteelWorks Ltd',
        purchaseDate: DateTime(2026, 4, 5),
        receivedDate: DateTime(2026, 4, 7),
        unitCost: 15,
        price: 150),
    MaterialItem(
        id: '6',
        name: 'Glass Panel',
        category: 'Rider Panel',
        vendor: 'ClearView Glass',
        purchaseDate: DateTime(2026, 4, 6),
        receivedDate: DateTime(2026, 4, 8),
        unitCost: 18,
        price: 180),
    MaterialItem(
        id: '7',
        name: 'Vinyl Sticker Roll',
        category: 'Sign Post',
        vendor: 'PrintPro Supplies',
        purchaseDate: DateTime(2026, 4, 7),
        receivedDate: DateTime(2026, 4, 9),
        unitCost: 6,
        price: 60),
    MaterialItem(
        id: '8',
        name: 'Wooden Panel',
        category: 'Main Panel',
        vendor: 'Timber Mart',
        purchaseDate: DateTime(2026, 4, 8),
        receivedDate: DateTime(2026, 4, 10),
        unitCost: 11,
        price: 110),
    MaterialItem(
        id: '9',
        name: 'Backlit Flex',
        category: 'Rider Panel',
        vendor: 'FlexPrint Ltd',
        purchaseDate: DateTime(2026, 4, 9),
        receivedDate: DateTime(2026, 4, 11),
        unitCost: 8.5,
        price: 85),
    MaterialItem(
        id: '10',
        name: 'LED Driver',
        category: 'Sign Post',
        vendor: 'PowerTech',
        purchaseDate: DateTime(2026, 4, 10),
        receivedDate: DateTime(2026, 4, 12),
        unitCost: 5.5,
        price: 55),
  ];

  final List<PrintOption> options = [
    PrintOption(id: '1', signTypeId: '2', name: '2 Hole Top', price: 120),
    PrintOption(id: '2', signTypeId: '1', name: '2 hole slider', price: 95),
    PrintOption(id: '3', signTypeId: '3', name: 'Side Hole', price: 75),
  ];

  final List<DeliveryMethod> deliveryMethods = [
    DeliveryMethod(id: '1', signTypeId: '2', name: 'Shipping', price: 12.50),
    DeliveryMethod(id: '2', signTypeId: '1', name: 'Store Pickup', price: 0),
    DeliveryMethod(id: '3', signTypeId: '3', name: 'Local Courier', price: 25),
  ];

  SignType? signTypeById(String id) {
    for (final s in signTypes) {
      if (s.id == id) return s;
    }
    return null;
  }
}
