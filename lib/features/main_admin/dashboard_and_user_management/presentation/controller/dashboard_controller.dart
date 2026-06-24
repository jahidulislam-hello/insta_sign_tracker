// dashboard_controller.dart
import 'package:get/get.dart';

class DashboardController extends GetxController {
  // Observable data
  var monthlyIncome = 12450.80.obs;
  var todayDeposit = 1000.0.obs;
  var pendingOrders = 100.0.obs;
  var unpaidInvoices = 08.obs;
  var lowStock = 03.obs;

  // Chart data - mock data (API theke asbe pora)
  var chartData = <double>[4500, 5200, 3800, 6100, 5400, 7200, 6800, 5900, 6500, 7100, 7800, 6200].obs;

  // Order distribution - DYNAMIC
  var activeOrders = 312.obs;
  var completedOrders = 88.obs;
  var activePercentage = 78.obs;
  var completedPercentage = 22.obs;

  @override
  void onInit() {
    super.onInit();
    // TODO: API call korbi eikhane
  }

  // Method to update order distribution based on total
  void updateOrderDistribution() {
    int total = activeOrders.value + completedOrders.value;
    if (total > 0) {
      activePercentage.value = ((activeOrders.value / total) * 100).toInt();
      completedPercentage.value = ((completedOrders.value / total) * 100).toInt();
    }
  }
}