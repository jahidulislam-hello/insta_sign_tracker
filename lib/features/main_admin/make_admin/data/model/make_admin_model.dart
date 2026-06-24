// make_admin_model.dart
class MakeAdminModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final String userType;
  final bool financialAccess;
  final bool userManagementAccess;
  final bool orderManagementAccess;
  final bool inventoryManagementAccess;
  final bool itemsAndPricingAccess;
  final bool manageWarehouseAccess;
  final bool announcementAccess;
  final bool settingsAccess;

  MakeAdminModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.userType = 'Admin',
    this.financialAccess = false,
    this.userManagementAccess = false,
    this.orderManagementAccess = false,
    this.inventoryManagementAccess = false,
    this.itemsAndPricingAccess = false,
    this.manageWarehouseAccess = false,
    this.announcementAccess = false,
    this.settingsAccess = false,
  });

  MakeAdminModel copyWith({
    String? name,
    String? email,
    String? password,
    String? userType,
    bool? financialAccess,
    bool? userManagementAccess,
    bool? orderManagementAccess,
    bool? inventoryManagementAccess,
    bool? itemsAndPricingAccess,
    bool? manageWarehouseAccess,
    bool? announcementAccess,
    bool? settingsAccess,
  }) {
    return MakeAdminModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      userType: userType ?? this.userType,
      financialAccess: financialAccess ?? this.financialAccess,
      userManagementAccess: userManagementAccess ?? this.userManagementAccess,
      orderManagementAccess: orderManagementAccess ?? this.orderManagementAccess,
      inventoryManagementAccess: inventoryManagementAccess ?? this.inventoryManagementAccess,
      itemsAndPricingAccess: itemsAndPricingAccess ?? this.itemsAndPricingAccess,
      manageWarehouseAccess: manageWarehouseAccess ?? this.manageWarehouseAccess,
      announcementAccess: announcementAccess ?? this.announcementAccess,
      settingsAccess: settingsAccess ?? this.settingsAccess,
    );
  }
}