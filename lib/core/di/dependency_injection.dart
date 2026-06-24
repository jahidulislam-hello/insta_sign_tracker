import 'package:get/get.dart';
import '../../features/Authentication/presentation/controller/auth_controller.dart';
import '../../features/main_admin/admin_announcement/presentation/controller/admin_announcements_controller.dart';
import '../../features/main_admin/admin_printing/presentation/controller/admin_printing_controller.dart';
import '../../features/main_admin/dashboard_and_user_management/presentation/controller/dashboard_controller.dart';
import '../../features/main_admin/invoices/presentation/controller/admin_invoices_controller.dart';
import '../../features/main_admin/make_admin/presentation/controller/make_admin_controller.dart';
import '../../features/main_admin/settings_announcement/presentation/settings_controller.dart';
import '../../features/main_admin/warehouses_screen/presentation/controller/warehouses_controller.dart';
import '../../features/onboarding/presentation/controller/onboarding_controller.dart';
import '../../features/real_state_agent/academy_terms&pricing/presentation/controller/academy_controller.dart';
import '../../features/real_state_agent/home/presentation/controller/home_controller.dart';
import '../../features/real_state_agent/invoice_assistent/presentation/controller/invoice_controller.dart';
import '../../features/real_state_agent/services/home/presentation/controller/services_list_controller.dart';
import '../../features/real_state_agent/services/media_other_service/presentation/controller/media_controller.dart';
import '../../features/real_state_agent/services/media_other_service/presentation/controller/other_service_controller.dart';
import '../../features/real_state_agent/services/open_home_service/presentation/controller/home_service_second_controller.dart';
import '../../features/real_state_agent/services/open_home_service/presentation/controller/house_service_controller.dart';
import '../../features/real_state_agent/services/removal_change/presentation/controller/removal_change_controller.dart';
import '../../features/real_state_agent/services/sales_direction/presentation/controller/check_out_controller.dart';
import '../../features/real_state_agent/services/sales_direction/presentation/controller/sale_direction_controller.dart';
import '../../features/real_state_agent/services/sign_installation/presentation/controller/review_order_status.dart';
import '../../features/real_state_agent/services/sign_installation/presentation/controller/sign_installation_controller.dart';
import '../../features/real_state_agent/services/sign_printing/presentation/sign_printing_controller.dart';
import '../../features/real_state_agent/settings_profile/presentation/controller/profile_controller.dart';
import '../services/cache_service.dart';
import '../services/storage_service.dart';

class DependencyInjection {
  DependencyInjection._();
  static Future<void> init() async {
    //----------------StorageService — initialized eagerly----------------------
    final storageService = StorageService();
    await storageService.init();
    Get.put<StorageService>(storageService, permanent: true);

    //---------------------Core Services (Singletons)---------------------------
    Get.lazyPut<CacheService>(() => CacheService(), fenix: true);

    //-------------------------onboarding---------------------------------------
    Get.lazyPut<OnboardingController>(
          () => OnboardingController(),
      fenix: true,
    );

    //----------------------------auth------------------------------------------
    Get.lazyPut<AuthController>(
          () => AuthController(),
      fenix: true,
    );
    Get.lazyPut<ProfileController>(
          () => ProfileController(),
      fenix: true,
    );

    //--------------------------Real State Agent--------------------------------
    Get.lazyPut<HomeController>(
          () => HomeController(),
      fenix: true,
    );
    Get.lazyPut<InvoiceController>(
          () => InvoiceController(),
      fenix: true,
    );
    Get.lazyPut<AcademyController>(
          () => AcademyController(),
      fenix: true,
    );
    Get.lazyPut<ServicesListController>(
          () => ServicesListController(),
      fenix: true,
    );
    Get.lazyPut<SignInstallationController>(
          () => SignInstallationController(),
      fenix: true,
    );
    Get.lazyPut<ReviewOrderStatus>(
          () => ReviewOrderStatus(),
      fenix: true,
    );
    Get.lazyPut<SignPrintingController>(
          () => SignPrintingController(),
      fenix: true,
    );
    Get.lazyPut<RemovalChangeController>(
          () => RemovalChangeController(),
      fenix: true,
    );
    Get.lazyPut<MediaController>(
          () => MediaController(),
      fenix: true,
    );
    Get.lazyPut<OtherServiceController>(
          () => OtherServiceController(),
      fenix: true,
    );
    Get.lazyPut<SaleDirectionController>(
          () => SaleDirectionController(),
      fenix: true,
    );
    Get.lazyPut<CheckOutController>(
          () => CheckOutController(),
      fenix: true,
    );
    Get.lazyPut<HouseServiceController>(
          () => HouseServiceController(),
      fenix: true,
    );
    Get.lazyPut<HomeServiceSecondController>(
          () => HomeServiceSecondController(),
      fenix: true,
    );
    Get.lazyPut<SettingsController>(
          () => SettingsController(),
      fenix: true,
    );


    //-------------------------Main Admin---------------------------------------
    Get.lazyPut<DashboardController>(
          () => DashboardController(),
      fenix: true,
    );
    Get.lazyPut<AdminInvoicesController>(
          () => AdminInvoicesController(),
      fenix: true,
    );
    Get.lazyPut<WarehousesController>(
          () => WarehousesController(),
      fenix: true,
    );
    Get.lazyPut<MakeAdminController>(
          () => MakeAdminController(),
      fenix: true,
    );
    Get.lazyPut<AdminPrintingController>(
          () => AdminPrintingController(),
      fenix: true,
    );
    Get.lazyPut<AdminAnnouncementsController>(
          () => AdminAnnouncementsController(),
      fenix: true,
    );

  }

  static void clear() {
    Get.deleteAll(force: true);
  }
}