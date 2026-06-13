import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/routes/app_routes.dart';

class ReviewOrderStatus extends GetxController
    with GetSingleTickerProviderStateMixin {
  // ========== Review Order Screen ==========
  // Price details
  final postInstallPrice = 50.0.obs;
  final creditCardFeePrice = 50.0.obs;
  final rushOrderFeePrice = 50.0.obs;
  final othersPrice = 50.0.obs;
  final totalPrice = 0.0.obs;

  // Order data from previous screens
  final orderData = <String, dynamic>{}.obs;

  // ========== Order Status Screen ==========
  late TabController tabController;
  final searchController = TextEditingController();
  final searchQuery = ''.obs;

  // Orders data
  final pendingOrders = <OrderModel>[].obs;
  final assignedOrders = <OrderModel>[].obs;
  final inProgressOrders = <OrderModel>[].obs;
  final completedOrders = <OrderModel>[].obs;
  final cancelledOrders = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 5, vsync: this);

    // Previous screen থেকে data পাবে
    if (Get.arguments != null) {
      orderData.value = Get.arguments;
    }

    // Total calculate করবে
    calculateTotal();

    // Dummy data load করবে
    _loadDummyData();
  }

  // ========== Review Order Functions ==========
  void calculateTotal() {
    totalPrice.value = postInstallPrice.value +
        creditCardFeePrice.value +
        rushOrderFeePrice.value +
        othersPrice.value;
  }

  void submitOrder() {
    Get.toNamed(AppRoutes.orderStatusScreen);
  }

  // ========== Order Status Functions ==========
  void _loadDummyData() {
    // Pending orders
    pendingOrders.addAll([
      OrderModel(
        id: '1',
        agentName: 'Marvin McKinney',
        location: '123778 LA, USA',
        status: 'Rush Order',
        dueDate: 'Oct 24, 2028',
        serviceType: 'Sign Installation',
        isPriority: true,
      ),
      OrderModel(
        id: '2',
        agentName: 'John Doe',
        location: '456789 CA, USA',
        status: 'Normal Order',
        dueDate: 'Oct 25, 2028',
        serviceType: 'Sign Printing',
        isPriority: false,
      ),
    ]);

    // Assigned orders
    assignedOrders.addAll([
      OrderModel(
        id: '3',
        agentName: 'Marvin McKinney',
        location: '123778 LA, USA',
        status: 'Rush Order',
        dueDate: 'Oct 24, 2028',
        serviceType: 'Sign Installation',
        isPriority: true,
      ),
      OrderModel(
        id: '8',
        agentName: 'David Lee',
        location: '789012 GA, USA',
        status: 'Rush Order',
        dueDate: 'Oct 23, 2028',
        serviceType: 'Sign Installation',
        isPriority: true,
      ),
    ]);

    // In Progress orders
    inProgressOrders.addAll([
      OrderModel(
        id: '4',
        agentName: 'Sarah Smith',
        location: '987654 NY, USA',
        status: 'Rush Order',
        dueDate: 'Oct 26, 2028',
        serviceType: 'Sign Installation',
        isPriority: true,
      ),
      OrderModel(
        id: '5',
        agentName: 'Mike Johnson',
        location: '555666 TX, USA',
        status: 'Normal Order',
        dueDate: 'Oct 27, 2028',
        serviceType: 'Sign Removal',
        isPriority: false,
      ),
    ]);

    // Completed orders
    completedOrders.addAll([
      OrderModel(
        id: '6',
        agentName: 'Emma Wilson',
        location: '111222 FL, USA',
        status: 'Completed',
        dueDate: 'Oct 20, 2028',
        serviceType: 'Sign Installation',
        isPriority: false,
      ),
      OrderModel(
        id: '9',
        agentName: 'Lisa Anderson',
        location: '444555 IL, USA',
        status: 'Completed',
        dueDate: 'Oct 19, 2028',
        serviceType: 'Sign Printing',
        isPriority: false,
      ),
    ]);

    // Cancelled orders
    cancelledOrders.addAll([
      OrderModel(
        id: '7',
        agentName: 'Alex Brown',
        location: '333444 WA, USA',
        status: 'Cancelled',
        dueDate: 'Oct 22, 2028',
        serviceType: 'Sign Installation',
        isPriority: true,
      ),
    ]);
  }

  // Get current tab orders
  List<OrderModel> getCurrentTabOrders() {
    final tabIndex = tabController.index;
    switch (tabIndex) {
      case 0:
        return pendingOrders;
      case 1:
        return assignedOrders;
      case 2:
        return inProgressOrders;
      case 3:
        return completedOrders;
      case 4:
        return cancelledOrders;
      default:
        return [];
    }
  }

  void updateSearch(String query) {
    searchQuery.value = query;
  }

  void viewOrderDetails(String orderId) {
    Get.toNamed('/order-details', arguments: orderId);
  }

  @override
  void onClose() {
    tabController.dispose();
    searchController.dispose();
    super.onClose();
  }
}

// Order model
class OrderModel {
  final String id;
  final String agentName;
  final String location;
  final String status;
  final String dueDate;
  final String serviceType;
  final bool isPriority;

  OrderModel({
    required this.id,
    required this.agentName,
    required this.location,
    required this.status,
    required this.dueDate,
    required this.serviceType,
    required this.isPriority,
  });
}