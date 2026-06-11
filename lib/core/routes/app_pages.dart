import 'package:get/get.dart';
import '../../features/Authentication/presentation/screen/enter_email_screen.dart';
import '../../features/Authentication/presentation/screen/login_screen.dart';
import '../../features/Authentication/presentation/screen/otp_verify_screen.dart';
import '../../features/Authentication/presentation/screen/reset_pass_screen.dart';
import '../../features/Authentication/presentation/screen/select_role.dart';
import '../../features/Authentication/presentation/screen/sign_up_screen.dart';
import '../../features/onboarding/presentation/screen/onboarding_screen.dart';
import '../../features/onboarding/presentation/screen/splash_screen.dart';
import '../../features/real_state_agent/academy_terms&pricing/presentation/screen/academy_details_screen.dart';
import '../../features/real_state_agent/academy_terms&pricing/presentation/screen/academy_screen.dart';
import '../../features/real_state_agent/academy_terms&pricing/presentation/screen/terms_pricing_screen.dart';
import '../../features/real_state_agent/home/presentation/screen/home_screen.dart';
import '../../features/real_state_agent/invoice_assistent/presentation/screen/assistant_management_screen.dart';
import '../../features/real_state_agent/invoice_assistent/presentation/screen/invoice_screen.dart';
import '../../features/real_state_agent/services/presentation/screen/services_list_screen.dart';
import '../../features/real_state_agent/settings_profile/presentation/screen/profile_screen.dart';
import 'app_routes.dart';

abstract class AppPages {
  AppPages._();

  static final List<GetPage> routes = [
    //onboarding Screen
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.onboardingScreen,
      page: () => const OnboardingScreen(),
    ),
    GetPage(
      name: AppRoutes.selectRole,
      page: () => const SelectRole(),
    ),

    //auth screen
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.enterEmailScreen,
      page: () => const EnterEmailScreen(),
    ),
    GetPage(
      name: AppRoutes.otpVerifyScreen,
      page: () => const OtpVerifyScreen(),
    ),
    GetPage(
      name: AppRoutes.resetPassScreen,
      page: () => const ResetPassScreen(),
    ),

    //------------Real State Agent-------
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.invoiceScreen,
      page: () => const InvoiceScreen(),
    ),
    GetPage(
      name: AppRoutes.assistantManagementScreen,
      page: () => const AssistantManagementScreen(),
    ),
    GetPage(
      name: AppRoutes.academyScreen,
      page: () => const AcademyScreen(),
    ),
    GetPage(
      name: AppRoutes.academyDetailsScreen,
      page: () => const AcademyDetailsScreen(),
    ),
    GetPage(
      name: AppRoutes.termsPricingScreen,
      page: () => const TermsPricingScreen(),
    ),
    GetPage(
      name: AppRoutes.profileScreen,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.servicesListScreen,
      page: () => const ServicesListScreen(),
    ),

  ];
}