import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/routes/app_routes.dart';
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
        goNextPage: (){
           Get.toNamed(AppRoutes.signInstallationScreen);
        }
      ),
      ServiceItem(
        title: 'Sign Printing',
        iconPath: 'asset/images/real_state_agent/home/print.png',
          goNextPage: (){
            Get.toNamed(AppRoutes.signPrintingScreen);
          }
      ),
      ServiceItem(
        title: 'Sign Removal',
        iconPath: 'asset/images/real_state_agent/home/remove.png',
          goNextPage: (){
            Get.toNamed(AppRoutes.signRemovalScreen);
          }
      ),
      ServiceItem(
        title: 'Sign Change',
        iconPath: 'asset/images/real_state_agent/home/change.png',
          goNextPage: (){
            Get.toNamed(AppRoutes.signChangeScreen);
          }
      ),
      ServiceItem(
        title: 'Media',
        iconPath: 'asset/images/real_state_agent/home/camera.png',
          goNextPage: (){
            Get.toNamed(AppRoutes.mediaServiceScreen);
          }
      ),
      ServiceItem(
        title: 'Open House Services',
        iconPath: 'asset/images/real_state_agent/home/home.png',
          goNextPage: (){
            Get.toNamed(AppRoutes.houseServiceScreen);
          }
      ),
      ServiceItem(
        title: 'Other Services',
        iconPath: 'asset/images/real_state_agent/home/services.png',
          goNextPage: (){
            Get.toNamed(AppRoutes.otherServiceScreen);
          }
      ),
      ServiceItem(
        title: 'Order Directionals',
        iconPath: 'asset/images/real_state_agent/home/sale_directionals.png',
          goNextPage: (){
            Get.toNamed(AppRoutes.saleDirectionScreen);
          }
      ),
    ];
  }

  void onServiceSelected(String serviceType) {
    print('Selected: $serviceType');
    // Later implement navigation
  }
}