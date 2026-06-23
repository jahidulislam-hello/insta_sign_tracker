enum InvoiceStatus { paid, pending, unpaid }

class WarehouseModel {
  final String id;
  final String name;
  final String location;

  WarehouseModel({
    required this.id,
    required this.name,
    required this.location,
  });
}

class StaffModel {
  final String id;
  final String name;
  final String role;

  StaffModel({
    required this.id,
    required this.name,
    required this.role,
  });
}