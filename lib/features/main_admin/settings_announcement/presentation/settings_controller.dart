import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/routes/app_routes.dart';
import '../widget/edite_profile_dialog.dart';

class SettingsController extends GetxController {
  // ===== Text Controllers =====
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  // ===== Edit Dialog Controllers =====
  late TextEditingController editNameController;
  late TextEditingController editEmailController;

  @override
  void onInit() {
    super.onInit();
    _initializeControllers();
  }

  void _initializeControllers() {
    nameController = TextEditingController(text: 'Architectural Utility Ltd');
    emailController = TextEditingController(text: 'example@gmail.com');
    phoneController = TextEditingController(text: '13456789');
    addressController = TextEditingController(
      text: '742 Evergreen Terrace, Springfield, OR 974',
    );

    editNameController = TextEditingController(text: 'Julian Draxler');
    editEmailController = TextEditingController(text: 'julian@arch.com');
  }

  // ===== Show Edit Dialog =====
  void showEditDialog() {
    Get.dialog(
      EditProfileDialog(
        nameController: editNameController,
        emailController: editEmailController,
        onSave: _handleSaveProfile,
      ),
      barrierDismissible: true,
    );
  }

  // ===== Handle Save Profile =====
  void _handleSaveProfile() {
    print('Name: ${editNameController.text}');
    print('Email: ${editEmailController.text}');

    Get.back();
    Get.snackbar(
      'Success',
      'Changes saved successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  // ===== Navigate to All Users Setting Screen =====
  void navigateToAllUsersScreen() {
    Get.toNamed(AppRoutes.allUserSettingScreen);
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    editNameController.dispose();
    editEmailController.dispose();
    super.onClose();
  }
}