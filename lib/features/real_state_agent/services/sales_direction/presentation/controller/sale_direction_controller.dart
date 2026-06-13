import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaleDirectionController extends GetxController {
  final currentInstall = ''.obs;
  final streetAddress = ''.obs;
  final unitApt = ''.obs;
  final dueDateController = TextEditingController();
  final selectedOrder = 'ASAP'.obs;
  final selectedPackage = RxnString();
  final selectedSignPlacement = RxnString();
  final leadInIntersection = ''.obs;
  final note = ''.obs;
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

  void selectOrder(String order) => selectedOrder.value = order;
  void toggleShoeCover(bool? val) => isShoeCoverSelected.value = val ?? false;
  void toggleFlyerBox(bool? val) => isFlyerBoxSelected.value = val ?? false;

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

  void placeOrder() {
    if (currentInstall.value.isEmpty) {
      Get.snackbar('Error', 'Please select a current install',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (streetAddress.value.isEmpty) {
      Get.snackbar('Error', 'Please enter a street address',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    Get.snackbar('Success', 'Order placed successfully!',
        snackPosition: SnackPosition.BOTTOM);
  }

  @override
  void onClose() {
    dueDateController.dispose();
    super.onClose();
  }
}