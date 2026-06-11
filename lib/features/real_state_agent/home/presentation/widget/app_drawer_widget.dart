import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/routes/app_routes.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';

import 'app_dialog_widget.dart';

class AppDrawerWidget extends StatelessWidget {
  const AppDrawerWidget({super.key});

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
              const SizedBox(height: 24),
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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: const Color(0xFFE8E8E8),
                backgroundImage:
                const AssetImage("asset/images/onboarding/blackMan.png"),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.profileScreen);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Albert Flamingo',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.edit, size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 13,
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
          icon: Icons.home_outlined,
          label: 'Services',
          route: AppRoutes.servicesListScreen,
          onTap: () => _navigateToPage(AppRoutes.servicesListScreen),
        ),
        _buildMenuItem(
          icon: Icons.receipt_outlined,
          label: 'Invoices',
          route: AppRoutes.invoiceScreen,
          onTap: () => _navigateToPage(AppRoutes.invoiceScreen),
        ),
        _buildMenuItem(
          icon: Icons.smart_toy_outlined,
          label: 'Assistant',
          route: AppRoutes.assistantManagementScreen,
          onTap: () => _navigateToPage(AppRoutes.assistantManagementScreen),
        ),
        _buildMenuItem(
          icon: Icons.school_outlined,
          label: 'Academy',
          route: AppRoutes.academyScreen,
          onTap: () => _navigateToPage(AppRoutes.academyScreen),
        ),
        _buildMenuItem(
          icon: Icons.description_outlined,
          label: 'Terms & Pricing',
          route: AppRoutes.termsPricingScreen,
          onTap: () => _navigateToPage(AppRoutes.termsPricingScreen),
        ),
        Divider(
          color: AppColors.grey700,
          thickness: 0.2,
        ),
        _buildMenuItem(
          icon: Icons.password_outlined,
          label: 'Change Password',
          route: null,
          onTap: () {
            Get.back(); // Close drawer first
            AppDialogsWidget.showChangePasswordDialog();
          },
        ),
        _buildMenuItem(
          icon: Icons.support_agent_outlined,
          label: 'Contact Support',
          route: null,
          onTap: () {},
        ),
        _buildMenuItem(
          icon: Icons.info_outlined,
          label: 'About App',
          route: null,
          onTap: () {},
        ),
        _buildMenuItem(
          icon: Icons.document_scanner_outlined,
          label: 'Terms & Conditions',
          route: null,
          onTap: () {},
        ),
        Divider(
          color: AppColors.grey700,
          thickness: 0.2,
        ),
        _buildMenuItem(
          icon: Icons.logout,
          label: 'Sign Out',
          route: null,
          onTap: () {
            Get.back(); // Close drawer first
            AppDialogsWidget.showLogoutDialog();
          },
          isSignOut: true,
        ),
      ],
    );
  }

  // ===== SIMPLE NAVIGATION FUNCTION =====
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

  // ===== REUSABLE MENU ITEM =====
  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required String? route,
    required VoidCallback onTap,
    bool isSignOut = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon,
                size: 22,
                color: isSignOut ? const Color(0xFFD32F2F) : Colors.grey[600]),
            const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isSignOut ? const Color(0xFFD32F2F) : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}