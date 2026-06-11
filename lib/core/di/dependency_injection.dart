import 'package:get/get.dart';
import '../../features/Authentication/presentation/controller/auth_controller.dart';
import '../../features/onboarding/presentation/controller/onboarding_controller.dart';
import '../../features/real_state_agent/academy_terms&pricing/presentation/controller/academy_controller.dart';
import '../../features/real_state_agent/home/presentation/controller/home_controller.dart';
import '../../features/real_state_agent/invoice_assistent/presentation/controller/invoice_controller.dart';
import '../../features/real_state_agent/services/presentation/controller/services_list_controller.dart';
import '../../features/real_state_agent/settings_profile/presentation/controller/profile_controller.dart';
import '../services/cache_service.dart';
import '../services/storage_service.dart';

class DependencyInjection {
  DependencyInjection._();
  static Future<void> init() async {
    // StorageService — initialized eagerly
    final storageService = StorageService();
    await storageService.init();
    Get.put<StorageService>(storageService, permanent: true);

    // Core Services (Singletons)
    Get.lazyPut<CacheService>(() => CacheService(), fenix: true);

    // onboarding
    Get.lazyPut<OnboardingController>(
          () => OnboardingController(),
      fenix: true,
    );

    // auth
    Get.lazyPut<AuthController>(
          () => AuthController(),
      fenix: true,
    );
    Get.lazyPut<ProfileController>(
          () => ProfileController(),
      fenix: true,
    );

    // realStateAgent - সব controllers `fenix: true` দিয়েছি
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

  }

  static void clear() {
    Get.deleteAll(force: true);
  }
}