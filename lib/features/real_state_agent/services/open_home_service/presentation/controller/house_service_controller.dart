import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/routes/app_routes.dart';

class HouseServiceController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Form Fields
  final currentInstallController = TextEditingController();
  final addressController = TextEditingController();
  final unitAptController = TextEditingController();
  final dueDateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();

  // Observables
  final selectedOrder = RxnString();
  final selectedPackage = RxnString();

  // Packages list
  final packages = [
    'Package 1',
    'Package 2',
    'Package 3',
    'Premium Package',
  ];

  String? validatePackage(String? val) {
    if (val == null || val.isEmpty) {
      return 'Please select a package';
    }
    return null;
  }

  // Date Picker
  Future<void> pickDueDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
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
      '${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}';
    }
  }

  // Time Picker
  Future<void> pickStartTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
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
      startTimeController.text = picked.format(context);
    }
  }

  Future<void> pickEndTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
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
      endTimeController.text = picked.format(context);
    }
  }

  // Select Order
  void selectOrder(String order) => selectedOrder.value = order;

  // Next Button
  void goToNext() {
    if (formKey.currentState!.validate()) {
     Get.toNamed(AppRoutes.homeServiceSecondScreen);
    }
  }

  @override
  void onClose() {
    currentInstallController.dispose();
    addressController.dispose();
    unitAptController.dispose();
    dueDateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    super.onClose();
  }
}