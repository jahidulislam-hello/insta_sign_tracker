import 'package:get/get.dart';
import '../../data/model/service_item.dart';

class HomeController extends GetxController {
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
        iconPath: 'asset/images/real_state_agent/home/for_sale.png',
      ),
      ServiceItem(
        title: 'Sign Printing',
        iconPath: 'asset/images/real_state_agent/home/print.png',
      ),
      ServiceItem(
        title: 'Sign Removal',
        iconPath: 'asset/images/real_state_agent/home/remove.png',
      ),
      ServiceItem(
        title: 'Sign Change',
        iconPath: 'asset/images/real_state_agent/home/change.png',
      ),
      ServiceItem(
        title: 'Media',
        iconPath: 'asset/images/real_state_agent/home/camera.png',
      ),
      ServiceItem(
        title: 'Open House Services',
        iconPath: 'asset/images/real_state_agent/home/home.png',
      ),
      ServiceItem(
        title: 'Other Services',
        iconPath: 'asset/images/real_state_agent/home/services.png',
      ),
      ServiceItem(
        title: 'Order Directionals',
        iconPath: 'asset/images/real_state_agent/home/sale_directionals.png',
      ),
    ];
  }

  void onServiceSelected(String serviceType) {
    print('Selected: $serviceType');
    // Later implement navigation
  }
}