import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignPrintingController extends GetxController {
  final selectedSize = '24"x30"'.obs;
  final selectedMaterial = 'PVC'.obs;
  final selectedOption = ''.obs;
  final selectedQuantity = '1'.obs;
  final selectedDelivery = ''.obs;
  final notesController = TextEditingController().obs;

  final List<String> sizes = ['12"x18"', '18"x24"', '24"x30"', '24"x36"'];
  final List<String> materials = ['PVC', 'Paper', 'Vinyl', 'Canvas'];
  final List<String> options = ['Glossy', 'Matte'];
  final List<String> quantities = ['1', '2', '5', '10', '20'];
  final List<String> deliveryMethods = [
    'Standard (5-7 days)',
    'Express (2-3 days)',
  ];

  @override
  void onClose() {
    notesController.value.dispose();
    super.onClose();
  }
}