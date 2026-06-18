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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== USER PROFILE SECTION =====
              _buildProfileSection(),
              SizedBox(height: 24.h),
              // ===== MENU ITEMS =====
              _buildMenuItems(context),
            ],
          ),
        ),
      ),
    );
  }

  // ===== PROFILE SECTION =====
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
                backgroundImage: const AssetImage("asset/images/onboarding/blackMan.png"),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.profileScreen);
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
                          Icon(Icons.edit, size: 14.sp, color: Colors.grey[600]),
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

  // ===== MENU ITEMS =====
  Widget _buildMenuItems(BuildContext context) {
    return Column(
      children: [
        _buildMenuItem(
          icon: Icons.dashboard_outlined,
          label: 'Dashboard',
          route: AppRoutes.homeScreen,
          onTap: () => _navigateToPage(AppRoutes.dashboardScreen),
        ),
        // USER MANAGEMENT WITH DROPDOWN
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
        // DROPDOWN ITEMS - Show when expanded
        if (_isUserManagementExpanded)
          _buildDropdownItem(
            label: 'Agents',
            onTap: (){
             // _navigateToDropdownPage('agents');
            },
          ),
        if (_isUserManagementExpanded)
          _buildDropdownItem(
            label: 'Assistants',
            onTap: (){
              // _navigateToDropdownPage('agents');
            },
          ),
        if (_isUserManagementExpanded)
          _buildDropdownItem(
            label: 'Field Technicians',
            onTap: (){
              // _navigateToDropdownPage('agents');
            },
          ),
        if (_isUserManagementExpanded)
          _buildDropdownItem(
            label: 'Office Manager',
            onTap: (){
              // _navigateToDropdownPage('agents');
            },
          ),
        if (_isUserManagementExpanded)
          _buildDropdownItem(
            label: 'Warehouse Managers',
            onTap: (){
              // _navigateToDropdownPage('agents');
            },
          ),
        if (_isUserManagementExpanded)
          _buildDropdownItem(
            label: 'Approvals',
            onTap: (){
              // _navigateToDropdownPage('agents');
            },
          ),
        _buildMenuItem(
          icon: Icons.receipt_outlined,
          label: 'Invoice',
          route: null,
          onTap: (){},
        ),
        _buildMenuItem(
          icon: Icons.inventory_2_outlined,
          label: 'Inventory',
          route: null,
          onTap: (){},
        ),
        _buildMenuItem(
          icon: Icons.route_outlined,
          label: 'Routing',
          route: null,
          onTap: (){},
        ),
        _buildMenuItem(
          icon: Icons.local_offer_outlined,
          label: 'Items & Pricing',
          route: null,
          onTap: (){},
        ),
        _buildMenuItem(
          icon: Icons.warehouse_outlined,
          label: 'Manage Warehouse',
          route: null,
          onTap: (){},
        ),
        _buildMenuItem(
          icon: Icons.admin_panel_settings_outlined,
          label: 'Make Admin',
          route: null,
          onTap: (){},
        ),
        _buildMenuItem(
          icon: Icons.notifications_outlined,
          label: 'Announcements',
          route: null,
          onTap: (){},
        ),
        _buildMenuItem(
          icon: Icons.settings_outlined,
          label: 'Setting',
          route: null,
          onTap: (){
            Get.toNamed(AppRoutes.settingsScreen);
          },
        ),
        Divider(
          color: AppColors.grey700,
          thickness: 0.2,
          height: 1,
        ),
        _buildMenuItem(
          icon: Icons.support_agent_outlined,
          label: 'Contact Support',
          route: null,
          onTap: () {
            Get.back();
          },
        ),
        _buildMenuItem(
          icon: Icons.info_outlined,
          label: 'About App',
          route: null,
          onTap: () {
            Get.back();
          },
        ),
        _buildMenuItem(
          icon: Icons.description_outlined,
          label: 'Terms & Conditions',
          route: null,
          onTap: () {
            Get.back();
          },
        ),
        Divider(
          color: AppColors.grey700,
          thickness: 0.2,
          height: 1,
        ),
        _buildMenuItem(
          icon: Icons.logout,
          label: 'Sign Out',
          route: null,
          onTap: () {
            Get.back();
          },
          isSignOut: true,
        ),
      ],
    );
  }

  // ===== NAVIGATION FUNCTION =====
  void _navigateToPage(String route) {
    Get.back();
    if (Get.currentRoute == route) {
      return;
    }
    Get.offNamedUntil(
      route,
      ModalRoute.withName(AppRoutes.homeScreen),
    );
  }

  // ===== DROPDOWN NAVIGATION =====
  void _navigateToDropdownPage(String page) {
    Get.back();
    // Map pages to routes - update according to your routes
    Map<String, String> pageRoutes = {
      'agents': '/agents', // Update with actual route
      'assistants': '/assistants',
      'field_technicians': '/field_technicians',
      'office_manager': '/office_manager',
      'warehouse_managers': '/warehouse_managers',
      'approvals': '/approvals',
    };

    String? route = pageRoutes[page];
    if (route != null) {
      Get.toNamed(route);
    }
  }

  // ===== REGULAR MENU ITEM =====
  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required String? route,
    required VoidCallback onTap,
    bool isSignOut = false,
    bool isSelected = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        color: isSelected ? Color(0xFFE1F5FF) : Colors.transparent,
        child: Row(
          children: [
            Icon(
              icon,
              size: 22.sp,
              color: isSignOut
                  ? Color(0xFFD32F2F)
                  : isSelected
                  ? Color(0xFF1E88E5)
                  : Colors.grey[600],
            ),
            SizedBox(width: 16.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: isSignOut
                    ? Color(0xFFD32F2F)
                    : isSelected
                    ? Color(0xFF1E88E5)
                    : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== MENU ITEM WITH DROPDOWN (User Management) =====
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
        color: isExpanded ? Color(0xFFE1F5FF) : Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 22.sp,
                  color: isExpanded ? Color(0xFF1E88E5) : Colors.grey[600],
                ),
                SizedBox(width: 16.w),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: isExpanded ? Color(0xFF1E88E5) : Colors.black87,
                  ),
                ),
              ],
            ),
            Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
              color: isExpanded ? Color(0xFF1E88E5) : Colors.grey[600],
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }

  // ===== DROPDOWN ITEM =====
  Widget _buildDropdownItem({
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 56.w, top: 10.h, bottom: 10.h, right: 16.w),
        color: Color(0xFFF5F5F5),
        child: Row(
          children: [
            Container(
              width: 4.w,
              height: 16.h,
              decoration: BoxDecoration(
                color: Color(0xFF1E88E5),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF757575),
              ),
            ),
          ],
        ),
      ),
    );
  }
}