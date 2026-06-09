import 'package:get/get.dart';
import '../../features/Authentication/presentation/controller/auth_controller.dart';
import '../../features/onboarding/presentation/controller/onboarding_controller.dart';
import '../services/cache_service.dart';
import '../services/storage_service.dart';

class DependencyInjection {
  DependencyInjection._();
  static Future<void> init() async {
    // Core Services (Singletons)
    Get.lazyPut<CacheService>(() => CacheService(), fenix: true);

    //onboarding
    Get.lazyPut<OnboardingController>(() => OnboardingController());

    //auth
    Get.lazyPut<AuthController>(() => AuthController());

    // StorageService — initialized eagerly because SharedPreferences.getInstance() is async
    final storageService = StorageService();
    await storageService.init();
    Get.put<StorageService>(storageService, permanent: true);


  }
  /// ```
  static void clear() {
    Get.deleteAll(force: true);
  }
}