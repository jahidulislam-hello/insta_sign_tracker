import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/model/warehouse_model.dart';
import '../screen/warehouses_details.dart';
import '../widget/add_warehouse_dialog.dart';


class WarehousesController extends GetxController {
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final selectedStaff = Rxn<StaffModel>();

  final warehouses = <WarehouseModel>[
    WarehouseModel(id: '1', name: 'Warehouse-2', location: 'Regional Annex South'),
    WarehouseModel(id: '2', name: 'Distribution Center-7', location: 'East Coast Hub'),
    WarehouseModel(id: '3', name: 'Fulfillment Hub-3', location: 'Central Logistics Point'),
    WarehouseModel(id: '4', name: 'Storage Facility-9', location: 'Northern Depot'),
    WarehouseModel(id: '5', name: 'Packaging Station-5', location: 'Westside Operations'),
  ].obs;

  final staffList = <StaffModel>[
    StaffModel(id: '1', name: 'Nm sujon', role: 'Frontend'),
    StaffModel(id: '2', name: 'Jamil', role: 'UI/UX Designer'),
    StaffModel(id: '3', name: 'Rony', role: 'Installer'),
    StaffModel(id: '4', name: 'John doe', role: 'Warehouse Manager'),
    StaffModel(id: '5', name: 'Packaging Station-5', role: 'Westside Operations'),
  ].obs;

  final tabs = ['All Items', 'Paid', 'Pending', 'Unpaid'];

  void openDetailsPage(WarehouseModel warehouse) {
    Get.to(() => WarehousesDetails(warehouse: warehouse));
  }

  void openAddDialog() {
    nameController.clear();
    locationController.clear();
    Get.dialog(const AddWarehouseDialog());
  }

  void openEditDialog(WarehouseModel warehouse) {
    nameController.text = warehouse.name;
    locationController.text = warehouse.location;
    Get.dialog(AddWarehouseDialog(editWarehouse: warehouse));
  }

  void openDeleteDialog(WarehouseModel warehouse) {
    Get.dialog(DeleteWarehouseDialog(
      name: warehouse.name,
      onDelete: () {
        warehouses.removeWhere((e) => e.id == warehouse.id);
        Get.back();
      },
    ));
  }

  void openAssignStaffDialog() {
    selectedStaff.value = null;
    Get.dialog(const AssignStaffDialog());
  }

  void assignStaff() {
    if (selectedStaff.value == null) return;
    Get.back();
  }

  void removeStaff(StaffModel staff) {
    Get.dialog(DeleteWarehouseDialog(
      name: staff.name,
      onDelete: () {
        staffList.removeWhere((e) => e.id == staff.id);
        Get.back();
      },
    ));
  }

  void addWarehouse() {
    final name = nameController.text.trim();
    final location = locationController.text.trim();
    if (name.isEmpty || location.isEmpty) return;
    warehouses.add(WarehouseModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      location: location,
    ));
    Get.back();
  }

  void editWarehouse(WarehouseModel warehouse) {
    final name = nameController.text.trim();
    final location = locationController.text.trim();
    if (name.isEmpty || location.isEmpty) return;
    final index = warehouses.indexWhere((e) => e.id == warehouse.id);
    if (index != -1) {
      warehouses[index] = WarehouseModel(
        id: warehouse.id,
        name: name,
        location: location,
      );
    }
    Get.back();
  }

  @override
  void onClose() {
    nameController.dispose();
    locationController.dispose();
    super.onClose();
  }
}