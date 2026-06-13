import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtherServiceController extends GetxController {
  // TextEditingControllers
  final signInstallController = TextEditingController();
  final dueDateController = TextEditingController();
  final notesController = TextEditingController();

  // Observables
  final selectedTab = 0.obs; // 0 = Current Install, 1 = New Service
  final selectedOrder = ''.obs;

  // Services checkboxes
  final undergroundSprinkler = false.obs;
  final restrictedGatedAccess1 = false.obs;
  final invisibleDogFence1 = false.obs;
  final undergroundWaterSystem = false.obs;
  final restrictedGatedAccess2 = false.obs;
  final invisibleDogFence2 = false.obs;

  // Price details
  final postInstallPrice = 50.0.obs;
  final creditCardFeePrice = 50.0.obs;
  final othersPrice = 50.0.obs;
  final totalPrice = 0.0.obs;

  // Form Key
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    calculateTotal();
  }

  // Date picker function
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      dueDateController.text =
      '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
    }
  }

  // Calculate total price
  void calculateTotal() {
    totalPrice.value =
        postInstallPrice.value + creditCardFeePrice.value + othersPrice.value;
  }

  // Place order
  void placeOrder() {
    if (formKey.currentState!.validate()) {
      Get.snackbar(
        'Success',
        'Order placed successfully!',
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }

  @override
  void onClose() {
    signInstallController.dispose();
    dueDateController.dispose();
    notesController.dispose();
    super.onClose();
  }
}