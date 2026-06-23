import 'package:get/get.dart';
import '../../features/Authentication/presentation/screen/enter_email_screen.dart';
import '../../features/Authentication/presentation/screen/login_screen.dart';
import '../../features/Authentication/presentation/screen/otp_verify_screen.dart';
import '../../features/Authentication/presentation/screen/reset_pass_screen.dart';
import '../../features/Authentication/presentation/screen/select_role.dart';
import '../../features/Authentication/presentation/screen/sign_up_screen.dart';
import '../../features/main_admin/dashboard_and_user_management/presentation/screen/dashboard_screen.dart';
import '../../features/main_admin/invoices/presentation/screen/admin_invoices_screen.dart';
import '../../features/main_admin/settings_announcement/screen/all_user_setting_screen.dart';
import '../../features/main_admin/settings_announcement/screen/settings_screen.dart';
import '../../features/main_admin/warehouses_screen/presentation/screen/warehouses_screen.dart';
import '../../features/onboarding/presentation/screen/onboarding_screen.dart';
import '../../features/onboarding/presentation/screen/splash_screen.dart';
import '../../features/real_state_agent/academy_terms&pricing/presentation/screen/academy_details_screen.dart';
import '../../features/real_state_agent/academy_terms&pricing/presentation/screen/academy_screen.dart';
import '../../features/real_state_agent/academy_terms&pricing/presentation/screen/terms_pricing_screen.dart';
import '../../features/real_state_agent/home/presentation/screen/home_screen.dart';
import '../../features/real_state_agent/invoice_assistent/presentation/screen/assistant_management_screen.dart';
import '../../features/real_state_agent/invoice_assistent/presentation/screen/invoice_screen.dart';
import '../../features/real_state_agent/services/home/presentation/screen/services_list_screen.dart';
import '../../features/real_state_agent/services/media_other_service/presentation/screen/media_place_order_screen.dart';
import '../../features/real_state_agent/services/media_other_service/presentation/screen/media_service_screen.dart';
import '../../features/real_state_agent/services/media_other_service/presentation/screen/other_service_screen.dart';
import '../../features/real_state_agent/services/open_home_service/presentation/screen/home_service_second_screen.dart';
import '../../features/real_state_agent/services/open_home_service/presentation/screen/house_service_screen.dart';
import '../../features/real_state_agent/services/open_home_service/presentation/screen/house_service_therd_screen.dart';
import '../../features/real_state_agent/services/removal_change/presentation/screen/sign_change_screen.dart';
import '../../features/real_state_agent/services/removal_change/presentation/screen/sign_removal_screen.dart';
import '../../features/real_state_agent/services/sales_direction/presentation/screen/add_card_screen.dart';
import '../../features/real_state_agent/services/sales_direction/presentation/screen/check_out_screen.dart';
import '../../features/real_state_agent/services/sales_direction/presentation/screen/sale_direction_screen.dart';
import '../../features/real_state_agent/services/sign_installation/presentation/screen/order_status_screen.dart';
import '../../features/real_state_agent/services/sign_installation/presentation/screen/review_order_screen.dart';
import '../../features/real_state_agent/services/sign_installation/presentation/screen/sign_installation_screen.dart';
import '../../features/real_state_agent/services/sign_installation/presentation/screen/sign_sistallation_2ndscreen.dart';
import '../../features/real_state_agent/services/sign_printing/screen/sign_printing_screen.dart';
import '../../features/real_state_agent/settings_profile/presentation/screen/profile_screen.dart';
import 'app_routes.dart';

abstract class AppPages {
  AppPages._();

  static final List<GetPage> routes = [
    //----------------------onboarding Screen-----------------------------------
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

    //-----------------------auth screen----------------------------------------
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

    //-----------------Real State Agent-----------------------------------------
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
    GetPage(
      name: AppRoutes.signInstallationScreen,
      page: () => const SignInstallationScreen(),
    ),
    GetPage(
      name: AppRoutes.signInstallation2ndScreen,
      page: () => const SignInstallation2ndScreen(),
    ),
    GetPage(
      name: AppRoutes.reviewOrderScreen,
      page: () => const ReviewOrderScreen(),
    ),
    GetPage(
      name: AppRoutes.orderStatusScreen,
      page: () => const OrderStatusScreen(),
    ),
    GetPage(
      name: AppRoutes.signPrintingScreen,
      page: () => const SignPrintingScreen(),
    ),
    GetPage(
      name: AppRoutes.signRemovalScreen,
      page: () => const SignRemovalScreen(),
    ),
    GetPage(
      name: AppRoutes.signChangeScreen,
      page: () => const SignChangeScreen(),
    ),
    GetPage(
      name: AppRoutes.mediaServiceScreen,
      page: () => const MediaServiceScreen(),
    ),
    GetPage(
      name: AppRoutes.mediaPlaceOrderScreen,
      page: () => const MediaPlaceOrderScreen(),
    ),
    GetPage(
      name: AppRoutes.otherServiceScreen,
      page: () => const OtherServiceScreen(),
    ),
    GetPage(
      name: AppRoutes.saleDirectionScreen,
      page: () => const SaleDirectionScreen(),
    ),
    GetPage(
      name: AppRoutes.checkOutScreen,
      page: () => const CheckOutScreen(),
    ),
    GetPage(
      name: AppRoutes.addCardScreen,
      page: () => const AddCardScreen(),
    ),
    GetPage(
      name: AppRoutes.houseServiceScreen,
      page: () => const HouseServiceScreen(),
    ),
    GetPage(
      name: AppRoutes.homeServiceSecondScreen,
      page: () => const HomeServiceSecondScreen(),
    ),
    GetPage(
      name: AppRoutes.houseServiceTherdScreen,
      page: () => const HouseServiceTherdScreen(),
    ),
    GetPage(
      name: AppRoutes.settingsScreen,
      page: () => const SettingsScreen(),
    ),
    GetPage(
      name: AppRoutes.allUserSettingScreen,
      page: () => const AllUserSettingScreen(),
    ),

    //------------------------Main Admin----------------------------------------
    GetPage(
      name: AppRoutes.dashboardScreen,
      page: () => DashboardScreen(),
    ),
    GetPage(
      name: AppRoutes.adminInvoicesScreen,
      page: () => AdminInvoicesScreen(),
    ),
    GetPage(
      name: AppRoutes.warehousesScreen,
      page: () => WarehousesScreen(),
    ),
  ];
}