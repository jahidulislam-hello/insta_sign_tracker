import 'package:get/get.dart';
import '../screen/home_screen.dart';

class HomeController extends GetxController {
  // Service items
  late List<ServiceItem> serviceItems;

  @override
  void onInit() {
    super.onInit();
    _initializeServiceItems();
  }

  void _initializeServiceItems() {
    serviceItems = [
      ServiceItem(
        title: 'Sign Installation',
        iconPath: 'assets/images/real_state_agent/home/for_sale.png',
      ),
      ServiceItem(
        title: 'Sign Printing',
        iconPath: 'assets/images/real_state_agent/home/print.png',
      ),
      ServiceItem(
        title: 'Sign Removal',
        iconPath: 'assets/images/real_state_agent/home/remove.png',
      ),
      ServiceItem(
        title: 'Sign Change',
        iconPath: 'assets/images/real_state_agent/home/change.png',
      ),
      ServiceItem(
        title: 'Media',
        iconPath: 'assets/images/real_state_agent/home/camera.png',
      ),
      ServiceItem(
        title: 'Open House Services',
        iconPath: 'assets/images/real_state_agent/home/home.png',
      ),
      ServiceItem(
        title: 'Other Services',
        iconPath: 'assets/images/real_state_agent/home/services.png',
      ),
      ServiceItem(
        title: 'Order Directionals',
        iconPath: 'assets/images/real_state_agent/home/sale_directionals.png',
      ),
    ];
  }
}