// make_admin_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/model/make_admin_model.dart';
import '../widget/make_admin_widget.dart';

class MakeAdminController extends GetxController {
  final admins = <MakeAdminModel>[].obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final financialAccess = false.obs;
  final userManagementAccess = false.obs;
  final orderManagementAccess = false.obs;
  final inventoryManagementAccess = false.obs;
  final itemsAndPricingAccess = false.obs;
  final manageWarehouseAccess = false.obs;
  final announcementAccess = false.obs;
  final settingsAccess = false.obs;
  final isEditing = false.obs;

  MakeAdminModel? editingAdmin;

  @override
  void onInit() {
    super.onInit();
    admins.addAll([
      MakeAdminModel(
        id: '1',
        name: 'Nm Sujon',
        password: '1234567@s',
        email: 'nsujon8@gmail.com',
        financialAccess: true,
        userManagementAccess: true,
      ),
      MakeAdminModel(
        id: '2',
        name: 'Nm Sujon',
        password: '1234567@s',
        email: 'nsujon8@gmail.com',
        financialAccess: true,
      ),
      MakeAdminModel(
        id: '3',
        name: 'Nm Sujon',
        password: '1234567@s',
        email: 'nsujon8@gmail.com',
      ),
    ]);
  }

  void _clearFields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    financialAccess.value = false;
    userManagementAccess.value = false;
    orderManagementAccess.value = false;
    inventoryManagementAccess.value = false;
    itemsAndPricingAccess.value = false;
    manageWarehouseAccess.value = false;
    announcementAccess.value = false;
    settingsAccess.value = false;
    editingAdmin = null;
    isEditing.value = false;
  }

  void openAddDialog() {
    _clearFields();
    Get.dialog(const MakeAdminWidget(), barrierDismissible: false);
  }

  void openEditDialog(MakeAdminModel admin) {
    editingAdmin = admin;
    nameController.text = admin.name;
    emailController.text = admin.email;
    passwordController.text = admin.password;
    financialAccess.value = admin.financialAccess;
    userManagementAccess.value = admin.userManagementAccess;
    orderManagementAccess.value = admin.orderManagementAccess;
    inventoryManagementAccess.value = admin.inventoryManagementAccess;
    itemsAndPricingAccess.value = admin.itemsAndPricingAccess;
    manageWarehouseAccess.value = admin.manageWarehouseAccess;
    announcementAccess.value = admin.announcementAccess;
    settingsAccess.value = admin.settingsAccess;
    isEditing.value = true;
    Get.dialog(const MakeAdminWidget(), barrierDismissible: false);
  }

  void openDeleteDialog(MakeAdminModel admin) {
    Get.defaultDialog(
      title: 'Delete Admin',
      middleText: 'Are you sure you want to delete "${admin.name}"?',
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        admins.removeWhere((a) => a.id == admin.id);
        Get.back();
      },
    );
  }

  void submitDialog() {
    if (isEditing.value) {
      final index = admins.indexWhere((a) => a.id == editingAdmin!.id);
      if (index != -1) {
        admins[index] = editingAdmin!.copyWith(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          financialAccess: financialAccess.value,
          userManagementAccess: userManagementAccess.value,
          orderManagementAccess: orderManagementAccess.value,
          inventoryManagementAccess: inventoryManagementAccess.value,
          itemsAndPricingAccess: itemsAndPricingAccess.value,
          manageWarehouseAccess: manageWarehouseAccess.value,
          announcementAccess: announcementAccess.value,
          settingsAccess: settingsAccess.value,
        );
      }
    } else {
      admins.add(MakeAdminModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        financialAccess: financialAccess.value,
        userManagementAccess: userManagementAccess.value,
        orderManagementAccess: orderManagementAccess.value,
        inventoryManagementAccess: inventoryManagementAccess.value,
        itemsAndPricingAccess: itemsAndPricingAccess.value,
        manageWarehouseAccess: manageWarehouseAccess.value,
        announcementAccess: announcementAccess.value,
        settingsAccess: settingsAccess.value,
      ));
    }
    _clearFields();
    Get.back();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}