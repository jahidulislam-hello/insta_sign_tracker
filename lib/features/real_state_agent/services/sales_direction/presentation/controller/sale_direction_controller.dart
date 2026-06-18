import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/routes/app_routes.dart';

class SaleDirectionController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final currentInstall = ''.obs;
  final streetAddress = ''.obs;
  final unitApt = ''.obs;
  final dueDateController = TextEditingController();
  final leadInIntersectionController = TextEditingController();
  final noteController = TextEditingController();

  final selectedOrder = RxnString(); // null by default - unselected
  final selectedPackage = RxnString();
  final selectedSignPlacement = RxnString();
  final selectedDirectional = RxnString();

  final isShoeCoverSelected = true.obs;
  final isFlyerBoxSelected = false.obs;

  final basePrice = 177.0.obs;
  final shoeCoverPrice = 8.0;
  final flyerBoxPrice = 15.0;
  final creditCardFee = 15.0;

  double get addonsTotal {
    double total = 0;
    if (isShoeCoverSelected.value) total += shoeCoverPrice;
    if (isFlyerBoxSelected.value) total += flyerBoxPrice;
    return total;
  }

  double get totalPrice => basePrice.value + addonsTotal;

  final packageOptions = ['Basic Package', 'Standard Package', 'Premium Package'];
  final signPlacementOptions = ["I'll choose", 'Agent places', 'Installer places'];
  final directionalOptions = ['Directional A', 'Directional B', 'Directional C'];

  // Order Select
  void selectOrder(String order) => selectedOrder.value = order;

  void toggleShoeCover(bool? val) => isShoeCoverSelected.value = val ?? false;
  void toggleFlyerBox(bool? val) => isFlyerBoxSelected.value = val ?? false;

  // Date Picker
  Future<void> pickDueDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      dueDateController.text =
      '${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}';
    }
  }

  // Validation Methods
  String? validateCurrentInstall(String? val) {
    if (val == null || val.isEmpty) {
      return 'Please select a current install';
    }
    return null;
  }

  String? validateStreetAddress(String? val) {
    if (val == null || val.isEmpty) {
      return 'Street address is required';
    }
    return null;
  }

  String? validateDueDate(String? val) {
    if (val == null || val.isEmpty) {
      return 'Due date is required';
    }
    return null;
  }

  String? validateOrder(String? val) {
    if (val == null || val.isEmpty) {
      return 'Please select an order type';
    }
    return null;
  }

  String? validatePackage(String? val) {
    if (val == null || val.isEmpty) {
      return 'Please select a package';
    }
    return null;
  }

  String? validateDirectional(String? val) {
    if (val == null || val.isEmpty) {
      return 'Please select a directional';
    }
    return null;
  }

  // Place Order
  void placeOrder() {
    if (formKey.currentState!.validate()) {
      Get.toNamed(AppRoutes.checkOutScreen);
    }
  }

  @override
  void onClose() {
    dueDateController.dispose();
    leadInIntersectionController.dispose();
    noteController.dispose();
    super.onClose();
  }
}