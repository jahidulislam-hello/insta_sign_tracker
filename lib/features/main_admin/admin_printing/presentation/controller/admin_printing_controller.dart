// admin_printing_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/admin_printing_model.dart';


class AdminPrintingController extends GetxController {
  final searchController = TextEditingController();
  final signTypes = <SignTypeModel>[].obs;
  final sizes = <SizeModel>[].obs;
  final materials = <MaterialModel>[].obs;
  final options = <OptionModel>[].obs;
  final deliveryMethods = <DeliveryMethodModel>[].obs;

  final currentTabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  void _initializeData() {
    // Sign Types
    signTypes.addAll([
      SignTypeModel(id: '1', name: 'For Safe Signs'),
      SignTypeModel(id: '2', name: 'Open House sign'),
      SignTypeModel(id: '3', name: 'For Sale Directionals'),
      SignTypeModel(id: '4', name: 'Rider'),
      SignTypeModel(id: '5', name: 'For Sale Signs'),
    ]);

    // Sizes
    sizes.addAll([
      SizeModel(id: '1', size: '30x20', price: 120.00),
      SizeModel(id: '2', size: '30x20', price: 120.00),
      SizeModel(id: '3', size: '30x20', price: 120.00),
      SizeModel(id: '4', size: '30x20', price: 120.00),
      SizeModel(id: '5', size: '30x20', price: 120.00),
    ]);

    // Materials
    materials.addAll([
      MaterialModel(id: '1', name: 'Aluminum Sheet', price: 120.00),
      MaterialModel(id: '2', name: 'Stainless Steel Rod', price: 85.50),
      MaterialModel(id: '3', name: 'Copper Wire', price: 64.75),
      MaterialModel(id: '4', name: 'Brass Tube', price: 92.30),
      MaterialModel(id: '5', name: 'Titanium Bolt', price: 150.00),
    ]);

    // Options
    options.addAll([
      OptionModel(id: '1', name: 'Aluminum Sheet', price: 120.00),
      OptionModel(id: '2', name: 'Stainless Steel Rod', price: 85.50),
      OptionModel(id: '3', name: 'Copper Wire', price: 64.75),
      OptionModel(id: '4', name: 'Brass Tube', price: 92.30),
      OptionModel(id: '5', name: 'Titanium Bolt', price: 150.00),
    ]);

    // Delivery Methods
    deliveryMethods.addAll([
      DeliveryMethodModel(id: '1', signType: 'For Safe Signs', name: 'Shipping', price: 120.00),
      DeliveryMethodModel(id: '2', signType: 'For Safe Signs', name: 'Shipping', price: 120.00),
      DeliveryMethodModel(id: '3', signType: 'Home', name: 'Shipping', price: 120.00),
      DeliveryMethodModel(id: '4', signType: 'For Safe Signs', name: 'Shipping', price: 120.00),
      DeliveryMethodModel(id: '5', signType: '', name: 'Shipping', price: 120.00),
    ]);
  }

  // Sign Types
  void addSignType(String name) {
    signTypes.add(SignTypeModel(
      id: DateTime.now().toString(),
      name: name,
    ));
  }

  void editSignType(int index, String name) {
    signTypes[index] = SignTypeModel(
      id: signTypes[index].id,
      name: name,
    );
    signTypes.refresh();
  }

  void deleteSignType(int index) {
    signTypes.removeAt(index);
  }

  // Sizes
  void addSize(String size, double price) {
    sizes.add(SizeModel(
      id: DateTime.now().toString(),
      size: size,
      price: price,
    ));
  }

  void editSize(int index, String size, double price) {
    sizes[index] = SizeModel(
      id: sizes[index].id,
      size: size,
      price: price,
    );
    sizes.refresh();
  }

  void deleteSize(int index) {
    sizes.removeAt(index);
  }

  // Materials
  void addMaterial(String name, double price) {
    materials.add(MaterialModel(
      id: DateTime.now().toString(),
      name: name,
      price: price,
    ));
  }

  void editMaterial(int index, String name, double price) {
    materials[index] = MaterialModel(
      id: materials[index].id,
      name: name,
      price: price,
    );
    materials.refresh();
  }

  void deleteMaterial(int index) {
    materials.removeAt(index);
  }

  // Options
  void addOption(String name, double price) {
    options.add(OptionModel(
      id: DateTime.now().toString(),
      name: name,
      price: price,
    ));
  }

  void editOption(int index, String name, double price) {
    options[index] = OptionModel(
      id: options[index].id,
      name: name,
      price: price,
    );
    options.refresh();
  }

  void deleteOption(int index) {
    options.removeAt(index);
  }

  // Delivery Methods
  void addDeliveryMethod(String signType, String name, double price) {
    deliveryMethods.add(DeliveryMethodModel(
      id: DateTime.now().toString(),
      signType: signType,
      name: name,
      price: price,
    ));
  }

  void editDeliveryMethod(int index, String signType, String name, double price) {
    deliveryMethods[index] = DeliveryMethodModel(
      id: deliveryMethods[index].id,
      signType: signType,
      name: name,
      price: price,
    );
    deliveryMethods.refresh();
  }

  void deleteDeliveryMethod(int index) {
    deliveryMethods.removeAt(index);
  }
}