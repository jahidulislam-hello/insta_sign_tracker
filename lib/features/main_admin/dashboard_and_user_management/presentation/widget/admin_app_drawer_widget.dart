import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_sign_tracker/core/routes/app_routes.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';

class AdminAppDrawerWidget extends StatefulWidget {
  const AdminAppDrawerWidget({super.key});

  @override
  State<AdminAppDrawerWidget> createState() => _AdminAppDrawerWidgetState();
}

class _AdminAppDrawerWidgetState extends State<AdminAppDrawerWidget> {
  bool _isUserManagementExpanded = false;
  bool _isItemPricingExpanded = false;
  bool _isSettingsExpanded = false;
  bool _isPrintingExpanded = false;
  bool _isInvoiceExpanded = false;
  bool _isMediaExpanded = false;

  // ===== NAVIGATION FUNCTION =====
  void _navigateToPage(String route) {
    Get.back(); // drawer close
    if (Get.currentRoute == route) return; // same page হলে শুধু close
    Get.offNamedUntil(
      route,
      ModalRoute.withName(AppRoutes.dashboardScreen), // back করলে dashboard
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileSection(),
              SizedBox(height: 24.h),
              _buildMenuItems(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 32.r,
                backgroundColor: const Color(0xFFE8E8E8),
                backgroundImage:
                const AssetImage("asset/images/onboarding/blackMan.png"),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                    _navigateToPage(AppRoutes.profileScreen);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Albert Flamingo',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Icon(Icons.edit,
                              size: 14.sp, color: Colors.grey[600]),
                          SizedBox(width: 4.w),
                          Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return Column(
      children: [
        _buildMenuItem(
          icon: Icons.dashboard_outlined,
          label: 'Dashboard',
          onTap: () => _navigateToPage(AppRoutes.dashboardScreen),
        ),
        _buildMenuItemWithDropdown(
          icon: Icons.people_outline,
          label: 'User Management',
          isExpanded: _isUserManagementExpanded,
          onTap: () {
            setState(() {
              _isUserManagementExpanded = !_isUserManagementExpanded;
            });
          },
        ),
        if (_isUserManagementExpanded)
          _buildDropdownItem(label: 'Agents', onTap: () => _navigateToPage(AppRoutes.agentsScreen),),
        if (_isUserManagementExpanded)
          _buildDropdownItem(label: 'Assistants', onTap: () => _navigateToPage(AppRoutes.assistantsScreen)),
        if (_isUserManagementExpanded)
          _buildDropdownItem(label: 'Field Technicians', onTap: () => _navigateToPage(AppRoutes.fieldTechnicians)),
        if (_isUserManagementExpanded)
          _buildDropdownItem(label: 'Office Manager', onTap: () => _navigateToPage(AppRoutes.officeManager)),
        if (_isUserManagementExpanded)
          _buildDropdownItem(label: 'Warehouse Managers', onTap: () => _navigateToPage(AppRoutes.wareHouseManager)),
        if (_isUserManagementExpanded)
          _buildDropdownItem(label: 'Approvals', onTap: () => _navigateToPage(AppRoutes.approvals)),
        _buildMenuItem(
          icon: Icons.shopping_cart,
          label: 'Orders Management',
          onTap: () => _navigateToPage(AppRoutes.dashboardScreen),
        ),
        _buildMenuItem(
          icon: Icons.local_shipping_outlined,
          label: 'Dispatch Board',
          onTap: () => _navigateToPage(AppRoutes.disPatchBoard),
        ),
        _buildMenuItemWithDropdown(
          icon: Icons.camera_alt_outlined,
          label: 'Media',
          isExpanded: _isMediaExpanded,
          onTap: () {
            setState(() {
              _isMediaExpanded = !_isMediaExpanded;
            });
          },
        ),
        if (_isMediaExpanded)
          _buildDropdownItem(label: 'Time Off', onTap: () => _navigateToPage(AppRoutes.workingsDay)),
        if (_isMediaExpanded)
          _buildDropdownItem(label: 'Calender View', onTap: () => _navigateToPage(AppRoutes.calenderView)),
        if (_isMediaExpanded)
          _buildDropdownItem(label: 'Make Delivery', onTap: () => _navigateToPage(AppRoutes.mediaDelivery)),
        if (_isMediaExpanded)
          _buildDropdownItem(label: 'Task Manager', onTap: () => _navigateToPage(AppRoutes.taskManager)),


        _buildMenuItem(
          icon: Icons.inventory_2_outlined,
          label: 'Inventory',
          onTap: () => _navigateToPage(AppRoutes.inventoryManagement),
        ),
        _buildMenuItem(
          icon: Icons.shopping_bag_outlined,
          label: 'Procurement',
          onTap: () => _navigateToPage(AppRoutes.procurement),
        ),
        // _buildMenuItem(
        //   icon: Icons.receipt_outlined,
        //   label: 'Invoices',
        //   onTap: () => _navigateToPage(AppRoutes.adminInvoicesScreen),
        // ),
        _buildMenuItemWithDropdown(
          icon: Icons.insert_drive_file_outlined,
          label: 'Invoices',
          isExpanded: _isInvoiceExpanded,
          onTap: () {
            setState(() {
              _isInvoiceExpanded = !_isInvoiceExpanded;
            });
          },
        ),
        if (_isInvoiceExpanded)
          _buildDropdownItem(label: 'Client', onTap: () => _navigateToPage(AppRoutes.client),),
        if (_isInvoiceExpanded)
          _buildDropdownItem(label: 'Technician', onTap: () => _navigateToPage(AppRoutes.technician)),

        _buildMenuItem(
          icon: Icons.euro_outlined,
          label: 'Revenue',
          onTap: () => _navigateToPage(AppRoutes.revenue),
        ),
        _buildMenuItem(
          icon: Icons.route_outlined,
          label: 'Routing',
          onTap: () => _navigateToPage(AppRoutes.routing),
        ),
        _buildMenuItemWithDropdown(
          icon: Icons.local_offer_outlined,
          label: 'Items & Pricing',
          isExpanded: _isItemPricingExpanded,
          onTap: () {
            setState(() {
              _isItemPricingExpanded = !_isItemPricingExpanded;
            });
          },
        ),
        if (_isItemPricingExpanded)
          _buildDropdownItem(label: 'Categories', onTap: () => _navigateToPage(AppRoutes.categories)),
        if (_isItemPricingExpanded)
          _buildDropdownItem(label: 'Variants', onTap: () => _navigateToPage(AppRoutes.variants)),
        if (_isItemPricingExpanded)
          _buildDropdownItem(label: 'Add-on Services', onTap: () => _navigateToPage(AppRoutes.addServices),),
        if (_isItemPricingExpanded)
          _buildDropdownItem(label: 'Installer Charge', onTap: () => _navigateToPage(AppRoutes.installerCharge),),
        if (_isItemPricingExpanded)
          _buildDropdownItem(label: 'Trip Charge', onTap: () => _navigateToPage(AppRoutes.tripCharge),),
        if (_isItemPricingExpanded)
          _buildDropdownItem(label: 'Packages', onTap: () => _navigateToPage(AppRoutes.packages),),
        if (_isItemPricingExpanded)
          _buildDropdownItem(label: 'Discounts', onTap: () => _navigateToPage(AppRoutes.discounts),),
        if (_isItemPricingExpanded)
          _buildDropdownItem(label: 'Coupons', onTap: () => _navigateToPage(AppRoutes.coupons),),
        if (_isItemPricingExpanded)
          _buildDropdownItem(label: 'Service Categories', onTap: () => _navigateToPage(AppRoutes.serviceCategories),),
        if (_isItemPricingExpanded)
          _buildDropdownItem(label: 'Services', onTap: () => _navigateToPage(AppRoutes.services),),

        _buildMenuItemWithDropdown(
          icon: Icons.print_outlined,
          label: 'Printing',
          isExpanded: _isPrintingExpanded,
          onTap: () {
            setState(() {
              _isPrintingExpanded = !_isPrintingExpanded;
            });
          },
        ),
        if (_isPrintingExpanded)
          _buildDropdownItem(label: 'Sign Type', onTap: () => _navigateToPage(AppRoutes.sizesTypeScreen),),
        if (_isPrintingExpanded)
          _buildDropdownItem(label: 'Size', onTap: () => _navigateToPage(AppRoutes.sizesScreen)),
        if (_isPrintingExpanded)
          _buildDropdownItem(label: 'Materials', onTap: () => _navigateToPage(AppRoutes.materialsScreen)),
        if (_isPrintingExpanded)
          _buildDropdownItem(label: 'Options', onTap: () => _navigateToPage(AppRoutes.optionsScreen)),
        if (_isPrintingExpanded)
          _buildDropdownItem(label: 'Delivery Methods', onTap: () => _navigateToPage(AppRoutes.deliveryMethods)),

        //   icon: Icons.print,
        //   label: 'Printing',
        //   // onTap: () => _navigateToPage(AppRoutes.adminPrintingScreen),
        // ),
        _buildMenuItem(
          icon: Icons.warehouse_outlined,
          label: 'Manage Warehouse',
          onTap: () => _navigateToPage(AppRoutes.warehousesScreen),
        ),
        // _buildMenuItem(
        //   icon: Icons.admin_panel_settings_outlined,
        //   label: 'Make Admin',
        //   onTap: () => _navigateToPage(AppRoutes.makeAdminScreen),
        // ),
        // _buildMenuItem(
        //   icon: Icons.notifications_outlined,
        //   label: 'Announcements',
        //   onTap: () => _navigateToPage(AppRoutes.adminAnnouncementsScreen),
        // ),
        // _buildMenuItem(
        //   icon: Icons.settings_outlined,
        //   label: 'Settings',
        //   onTap: () => _navigateToPage(AppRoutes.settingsScreen),
        // ),
        _buildMenuItemWithDropdown(
          icon: Icons.settings,
          label: 'Settings',
          isExpanded: _isSettingsExpanded,
          onTap: () {
            setState(() {
              _isSettingsExpanded = !_isSettingsExpanded;
            });
          },
        ),
        if (_isSettingsExpanded)
          _buildDropdownItem(label: 'Schedule Methods', onTap: () => _navigateToPage(AppRoutes.scedulMethod),),
        if (_isSettingsExpanded)
          _buildDropdownItem(label: 'Entry Method', onTap: () => _navigateToPage(AppRoutes.entryMethod)),
        if (_isSettingsExpanded)
          _buildDropdownItem(label: 'Photographer', onTap: () => _navigateToPage(AppRoutes.photographer)),
        if (_isSettingsExpanded)
          _buildDropdownItem(label: 'Invoicing', onTap: () => _navigateToPage(AppRoutes.invoicing)),
        if (_isSettingsExpanded)
          _buildDropdownItem(label: 'Task Builder', onTap: () => _navigateToPage(AppRoutes.taskbuilder)),
        if (_isSettingsExpanded)
          _buildDropdownItem(label: 'Company Information', onTap: () => _navigateToPage(AppRoutes.companyInformation)),
        if (_isSettingsExpanded)
          _buildDropdownItem(label: 'Auto Renewal', onTap: () => _navigateToPage(AppRoutes.autoRenewal)),
        if (_isSettingsExpanded)
          _buildDropdownItem(label: 'Announcement', onTap: () => _navigateToPage(AppRoutes.announcement)),
        if (_isSettingsExpanded)
          _buildDropdownItem(label: 'Brokerage', onTap: () => _navigateToPage(AppRoutes.brokerage)),
        if (_isSettingsExpanded)
          _buildDropdownItem(label: 'Make Admin', onTap: () => _navigateToPage(AppRoutes.makeAdmin)),

        Divider(color: AppColors.grey700, thickness: 0.2, height: 1),
        _buildMenuItem(
          icon: Icons.support_agent_outlined,
          label: 'Contact Support',
          onTap: () => Get.back(),
        ),
        _buildMenuItem(
          icon: Icons.info_outlined,
          label: 'About App',
          onTap: () => Get.back(),
        ),
        _buildMenuItem(
          icon: Icons.description_outlined,
          label: 'Terms & Conditions',
          onTap: () => Get.back(),
        ),
        Divider(color: AppColors.grey700, thickness: 0.2, height: 1),
        _buildMenuItem(
          icon: Icons.logout,
          label: 'Sign Out',
          onTap: () => Get.back(),
          isSignOut: true,
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isSignOut = false,
  }) {
    final isSelected = Get.currentRoute ==
        _routeFromLabel(label);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        color: isSelected ? const Color(0xFFE1F5FF) : Colors.transparent,
        child: Row(
          children: [
            Icon(
              icon,
              size: 22.sp,
              color: isSignOut
                  ? const Color(0xFFD32F2F)
                  : isSelected
                  ? const Color(0xFF1E88E5)
                  : Colors.grey[600],
            ),
            SizedBox(width: 16.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: isSignOut
                    ? const Color(0xFFD32F2F)
                    : isSelected
                    ? const Color(0xFF1E88E5)
                    : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // active route highlight এর জন্য label থেকে route বের করা
  String _routeFromLabel(String label) {
    switch (label) {
      case 'Dashboard':
        return AppRoutes.dashboardScreen;
      case 'Invoice':
        return AppRoutes.adminInvoicesScreen;
      case 'Manage Warehouse':
        return AppRoutes.warehousesScreen;
      case 'Setting':
        return AppRoutes.settingsScreen;
      default:
        return '';
    }
  }

  Widget _buildMenuItemWithDropdown({
    required IconData icon,
    required String label,
    required bool isExpanded,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        color: isExpanded ? const Color(0xFFE1F5FF) : Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 22.sp,
                  color: isExpanded
                      ? const Color(0xFF1E88E5)
                      : Colors.grey[600],
                ),
                SizedBox(width: 16.w),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: isExpanded
                        ? const Color(0xFF1E88E5)
                        : Colors.black87,
                  ),
                ),
              ],
            ),
            Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
              color:
              isExpanded ? const Color(0xFF1E88E5) : Colors.grey[600],
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownItem({
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(
            left: 56.w, top: 10.h, bottom: 10.h, right: 16.w),
        color: const Color(0xFFF5F5F5),
        child: Row(
          children: [
            Container(
              width: 4.w,
              height: 16.h,
              decoration: BoxDecoration(
                color: const Color(0xFF1E88E5),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF757575),
              ),
            ),
          ],
        ),
      ),
    );
  }
}