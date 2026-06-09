import 'package:get/get.dart';
import '../../features/Authentication/presentation/screen/select_role.dart';
import '../../features/onboarding/presentation/controller/onboarding_controller.dart';
import '../../features/onboarding/presentation/screen/onboarding_screen.dart';
import '../../features/onboarding/presentation/screen/splash_screen.dart';
import 'app_routes.dart';

abstract class AppPages {
  AppPages._();

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.onboardingScreen,
      page: () => const OnboardingScreen(),
      binding: BindingsBuilder(() {
        Get.put(OnboardingController(), permanent: false);
      }),
    ),
    GetPage(
      name: AppRoutes.selectRole, // '/select-role'
      page: () => const SelectRole(),
      // binding: BindingsBuilder(() {
      //   Get.put(SelectRoleController());
      // }),
    ),
  ];
}