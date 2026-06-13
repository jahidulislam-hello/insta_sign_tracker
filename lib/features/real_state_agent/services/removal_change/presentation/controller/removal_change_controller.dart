import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RemovalChangeController extends GetxController {
  final selectedSign = ''.obs;
  final selectedPostInstalled = ''.obs;
  final selectedPickupLockbox = ''.obs;
  final dueDateController = TextEditingController();
  final notesController = TextEditingController();
  final selectSign = TextEditingController();
  final selectSignChange = TextEditingController();

  final List<String> yesNoOptions = ['Yes', 'No'];

  @override
  void onClose() {
    dueDateController.dispose();
    notesController.dispose();
    super.onClose();
  }
}