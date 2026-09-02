import 'package:get/get.dart';
import 'package:insta_sign_tracker/features/main_admin/dispatch_board/dispatch_board_screen.dart';
import 'package:insta_sign_tracker/features/main_admin/inventory/inventory_management_screen.dart';
import 'package:insta_sign_tracker/features/main_admin/invoices_items/client/client.dart';
import 'package:insta_sign_tracker/features/main_admin/invoices_items/technician/technician.dart';
import 'package:insta_sign_tracker/features/main_admin/item_pricing/screens/addon_services_screen.dart';
import 'package:insta_sign_tracker/features/main_admin/item_pricing/screens/categories_screen.dart';
import 'package:insta_sign_tracker/features/main_admin/item_pricing/screens/coupons_screen.dart';
import 'package:insta_sign_tracker/features/main_admin/item_pricing/screens/discounts_screen.dart';
import 'package:insta_sign_tracker/features/main_admin/item_pricing/screens/installer_charge_screen.dart';
import 'package:insta_sign_tracker/features/main_admin/item_pricing/screens/packages_screen.dart';
import 'package:insta_sign_tracker/features/main_admin/item_pricing/screens/purchase_orders_screen.dart';
import 'package:insta_sign_tracker/features/main_admin/item_pricing/screens/service_categories_screen.dart';
import 'package:insta_sign_tracker/features/main_admin/item_pricing/screens/services_screen.dart';
import 'package:insta_sign_tracker/features/main_admin/item_pricing/screens/trip_charge_screen.dart';
import 'package:insta_sign_tracker/features/main_admin/media/screens/calendar_view_screen.dart';
import 'package:insta_sign_tracker/features/main_admin/media/screens/media_delivery_screen.dart';
import 'package:insta_sign_tracker/features/main_admin/media/screens/task_manager_screen.dart';
import 'package:insta_sign_tracker/features/main_admin/media/screens/working_days_screen.dart';
import 'package:insta_sign_tracker/features/main_admin/order_management/order_management.dart';
import 'package:insta_sign_tracker/features/main_admin/printing/screens/delivery_methods_screen.dart';
import 'package:insta_sign_tracker/features/main_admin/printing/screens/options_screen.dart';
import 'package:insta_sign_tracker/features/main_admin/printing/screens/sign_types_screen.dart';
import 'package:insta_sign_tracker/features/main_admin/printing/screens/size_screen.dart';
import 'package:insta_sign_tracker/features/main_admin/procurement_screen/procurement_screen.dart';
import 'package:insta_sign_tracker/features/main_admin/revenue/revenue.dart';
import 'package:insta_sign_tracker/features/main_admin/routing/routing_screen.dart';
import 'package:insta_sign_tracker/features/main_admin/settings/admin_list.dart';
import 'package:insta_sign_tracker/features/main_admin/settings/announcement_page.dart';
import 'package:insta_sign_tracker/features/main_admin/settings/auto_renenual_page.dart';
import 'package:insta_sign_tracker/features/main_admin/settings/brokerage_page.dart';
import 'package:insta_sign_tracker/features/main_admin/settings/company_information.dart';
import 'package:insta_sign_tracker/features/main_admin/settings/every_method_page.dart';
import 'package:insta_sign_tracker/features/main_admin/settings/invoice_settings.dart';
import 'package:insta_sign_tracker/features/main_admin/settings/photographer_settings.dart';
import 'package:insta_sign_tracker/features/main_admin/settings/schedule_settings/screens/scheduling_settings_screen.dart';
import 'package:insta_sign_tracker/features/main_admin/settings/task_builder_page.dart';
import 'package:insta_sign_tracker/features/main_admin/user_management/agents/screens/agents_screen.dart';
import 'package:insta_sign_tracker/features/main_admin/user_management/approvals.dart';
import 'package:insta_sign_tracker/features/main_admin/user_management/assistnats/screens/assistants_screen.dart';
import 'package:insta_sign_tracker/features/main_admin/user_management/feild_technicians/screens/technicians_list_screen.dart';
import 'package:insta_sign_tracker/features/main_admin/user_management/office_manager.dart';
import 'package:insta_sign_tracker/features/main_admin/user_management/warehouse_managers.dart';
import '../../features/Authentication/presentation/screen/enter_email_screen.dart';
import '../../features/Authentication/presentation/screen/login_screen.dart';
import '../../features/Authentication/presentation/screen/otp_verify_screen.dart';
import '../../features/Authentication/presentation/screen/reset_pass_screen.dart';
import '../../features/Authentication/presentation/screen/select_role.dart';
import '../../features/Authentication/presentation/screen/sign_up_screen.dart';
import '../../features/main_admin/admin_announcement/presentation/screen/admin_announcements_screen.dart';
import '../../features/main_admin/admin_printing/presentation/screen/admin_printing_screen.dart';
import '../../features/main_admin/dashboard_and_user_management/presentation/screen/dashboard_screen.dart';
import '../../features/main_admin/invoices/presentation/screen/admin_invoices_screen.dart';
import '../../features/main_admin/make_admin/presentation/screen/make_admin_screen.dart';
import '../../features/main_admin/printing/screens/materials_screen.dart';
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
    GetPage(
      name: AppRoutes.makeAdminScreen,
      page: () => MakeAdminScreen(),
    ),
    GetPage(
      name: AppRoutes.adminPrintingScreen,
      page: () => AdminPrintingScreen(),
    ),
    GetPage(
      name: AppRoutes.adminAnnouncementsScreen,
      page: () => AdminAnnouncementsScreen(),
    ),
    GetPage(
      name: AppRoutes.agentsScreen,
      page: () => AgentsScreen(),
    ),
    GetPage(
      name: AppRoutes.assistantsScreen,
      page: () => AssistantsScreen(),
    ),
    GetPage(
      name: AppRoutes.entryMethod,
      page: () => EntryMethodsPage(),
    ),
    GetPage(
      name: AppRoutes.scedulMethod,
      page: () => const SchedulingSettingsScreen(),
    ),
    GetPage(
      name: AppRoutes.photographer,
      page: () => const PhotographerSettingsScreen(),
    ),
    GetPage(
      name: AppRoutes.invoicing,
      page: () => const InvoicingSettingsScreen(),
    ),
    GetPage(
      name: AppRoutes.taskbuilder,
      page: () => const TaskBuilderPage(),
    ),
    GetPage(
      name: AppRoutes.companyInformation,
      page: () => const CompanyInformationPage(),
    ),
    GetPage(
      name: AppRoutes.autoRenewal,
      page: () => const AutoRenewalPage(),
    ),
    GetPage(
      name: AppRoutes.announcement,
      page: () => const AnnouncementsPage(),
    ),
    GetPage(
      name: AppRoutes.brokerage,
      page: () => const BrokeragePage(),
    ),
    GetPage(
      name: AppRoutes.makeAdmin,
      page: () => const AdminListPage(),
    ),
    GetPage(
      name: AppRoutes.deliveryMethods,
      page: () => const DeliveryMethodsScreen(),
    ),
    GetPage(
      name: AppRoutes.materialsScreen,
      page: () => const MaterialsScreen(),
    ),
    GetPage(
      name: AppRoutes.optionsScreen,
      page: () => const OptionsScreen(),
    ),
    GetPage(
      name: AppRoutes.sizesScreen,
      page: () => const SizeScreen(),
    ),
    GetPage(
      name: AppRoutes.sizesTypeScreen,
      page: () => const SignTypesScreen(),
    ),
    GetPage(
      name: AppRoutes.calenderView,
      page: () => const CalendarViewScreen(),
    ),
    GetPage(
      name: AppRoutes.mediaDelivery,
      page: () => const MediaDeliveryScreen(),
    ),
    GetPage(
      name: AppRoutes.taskManager,
      page: () => const TaskManagerScreen(),
    ),
    GetPage(
      name: AppRoutes.workingsDay,
      page: () => const WorkingDaysScreen(),
    ),
    GetPage(
      name: AppRoutes.client,
      page: () => const ClientPage(),
    ),
    GetPage(
      name: AppRoutes.technician,
      page: () => const TechnicianPage(),
    ),
    GetPage(
      name: AppRoutes.services,
      page: () => const ServicesScreen(),
    ),
    GetPage(
      name: AppRoutes.serviceCategories,
      page: () => const ServiceCategoriesScreen(),
    ),
    GetPage(
      name: AppRoutes.tripCharge,
      page: () => const TripChargeScreen(),
    ),
    GetPage(
      name: AppRoutes.variants,
      page: () => const PurchaseOrdersScreen(),
    ),
    GetPage(
      name: AppRoutes.packages,
      page: () => const PackagesScreen(),
    ),
    GetPage(
      name: AppRoutes.installerCharge,
      page: () => const InstallerChargeScreen(),
    ),
    GetPage(
      name: AppRoutes.discounts,
      page: () => const DiscountsScreen(),
    ),
    GetPage(
      name: AppRoutes.coupons,
      page: () => const CouponsScreen(),
    ),
    GetPage(
      name: AppRoutes.categories,
      page: () => const CategoriesScreen(),
    ),
    GetPage(
      name: AppRoutes.addServices,
      page: () => const AddOnServicesScreen(),
    ),
    GetPage(
      name: AppRoutes.fieldTechnicians,
      page: () => const TechniciansListScreen(),
    ),
    GetPage(
      name: AppRoutes.officeManager,
      page: () => const OfficeManagerPage(),
    ),
    GetPage(
      name: AppRoutes.wareHouseManager,
      page: () => const WarehouseManagersPage(),
    ),
    GetPage(
      name: AppRoutes.approvals,
      page: () => const AllApprovalsPage(),
    ),
    GetPage(
      name: AppRoutes.inventoryManagement,
      page: () => const InventoryManagementScreen(),
    ),
    GetPage(
  name: AppRoutes.orderManagement,
  page: () => const OrderManagementScreen(),
  ),
    GetPage(
      name: AppRoutes.disPatchBoard,
      page: () => const DispatchBoardScreen(),
    ),
    GetPage(
      name: AppRoutes.procurement,
      page: () => const ProcurementScreen(),
    ),
    GetPage(
      name: AppRoutes.revenue,
      page: () => const RevenueScreen(),
    ),
    GetPage(
      name: AppRoutes.routing,
      page: () => const RoutingScreen(),
    ),


    // GetPage(
    //   name: AppRoutes.technician,
    //   page: () => const TechnicianPage(),
    // ),GetPage(
    //   name: AppRoutes.technician,
    //   page: () => const TechnicianPage(),
    // ),





    // GetPage(
    //   name: AppRoutes.scedulMethod,
    //   page: () => const ScedulMethod(),
    // ),
    // GetPage(
    //   name: AppRoutes.scedulMethod,
    //   page: () => const ScedulMethod(),
    // ),


  ];
}