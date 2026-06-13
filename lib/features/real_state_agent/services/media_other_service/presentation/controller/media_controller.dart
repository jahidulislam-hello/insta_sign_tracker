import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:insta_sign_tracker/core/routes/app_routes.dart';

class MediaController extends GetxController {
  // ========== First Screen (Media Service) ==========
  // TextEditingControllers
  final addressController = TextEditingController();
  final unitAptController = TextEditingController();
  final dueDateController = TextEditingController();
  final lockboxCodeController = TextEditingController();
  final notesController = TextEditingController();

  // Observables
  final selectedOrder = ''.obs;
  final selectedPropertyType = ''.obs;
  final selectedAccessMethod = ''.obs;

  // Form Key
  final formKey = GlobalKey<FormState>();

  // Dropdowns data
  final propertyTypes = ['Residential', 'Commercial', 'Multi-family'];
  final accessMethods = ['Lockbox', 'Key holder', 'Door code'];

  // ========== Second Screen (Media Place Order) ==========
  // Image upload
  final selectedImage = Rx<File?>(null);

  // Photography, Videography, Media packages
  final selectedPhotographyPackage = ''.obs;
  final selectedVideographyPackage = ''.obs;
  final selectedMediaPackage = ''.obs;

  // Add-on Services
  final showroomChecked = false.obs;

  // Packages options
  final photographyPackages = [
    'Basic Photography',
    'Standard Photography',
    'Premium Photography'
  ];
  final videographyPackages = [
    'Basic Videography',
    'Standard Videography',
    'Premium Videography'
  ];
  final mediaPackages = [
    'Basic Media Package',
    'Standard Media Package',
    'Premium Media Package'
  ];

  // Price details
  final postInstallPrice = 50.0.obs;
  final creditCardFeePrice = 50.0.obs;
  final othersPrice = 50.0.obs;
  final totalPrice = 0.0.obs;

  // Order data
  final orderData = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      orderData.value = Get.arguments;
    }
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

  // Next button function - First screen
  void goToNextPage() {
    if (formKey.currentState!.validate()) {
      Get.toNamed(AppRoutes.mediaPlaceOrderScreen);
    }
  }

  // Calculate total price - Second screen
  void calculateTotal() {
    totalPrice.value =
        postInstallPrice.value + creditCardFeePrice.value + othersPrice.value;
  }

  // Place order function
  void placeOrder() {
    if (selectedPhotographyPackage.value.isEmpty ||
        selectedVideographyPackage.value.isEmpty ||
        selectedMediaPackage.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select all packages',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    Get.snackbar(
      'Success',
      'Order placed successfully!',
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
    // Navigate to order status or success page
  }

  @override
  void onClose() {
    addressController.dispose();
    unitAptController.dispose();
    dueDateController.dispose();
    lockboxCodeController.dispose();
    notesController.dispose();
    super.onClose();
  }
}