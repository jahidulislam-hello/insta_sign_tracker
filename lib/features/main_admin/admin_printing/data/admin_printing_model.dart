// models.dart
class SignTypeModel {
  final String id;
  final String name;

  SignTypeModel({required this.id, required this.name});
}

class SizeModel {
  final String id;
  final String size;
  final double price;

  SizeModel({required this.id, required this.size, required this.price});
}

class MaterialModel {
  final String id;
  final String name;
  final double price;

  MaterialModel({required this.id, required this.name, required this.price});
}

class OptionModel {
  final String id;
  final String name;
  final double price;

  OptionModel({required this.id, required this.name, required this.price});
}

class DeliveryMethodModel {
  final String id;
  final String signType;
  final String name;
  final double price;

  DeliveryMethodModel({
    required this.id,
    required this.signType,
    required this.name,
    required this.price,
  });
}