import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import 'package:insta_sign_tracker/features/real_state_agent/home/presentation/controller/home_controller.dart';
import 'package:logger/logger.dart';
import '../widget/app_drawer_widget.dart';
import '../widget/chosse_service_type_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingColor,
      appBar: _buildAppBar(),
      drawer: const AppDrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== ANNOUNCEMENT SECTION =====
            _buildAnnouncementSection(),

            // ===== DASHBOARD OVERVIEW SECTION =====
            _buildDashboardOverviewSection(),

            // ===== CHOOSE SERVICE TYPE SECTION =====
            _buildChooseServiceTypeSection(),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // ===================== AppBar =====================
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primaryBlue,
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: const Text(
        'Instapost',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          onPressed: () {
            // Blank onTap - API integration এর জন্য রেখেছি
          },
          icon: const Icon(Icons.notifications_none, color: Colors.white),
        ),
      ],
    );
  }

  // ===================== ANNOUNCEMENT SECTION =====================
  Widget _buildAnnouncementSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              AppColors.white,
              const Color(0xFFE0F7FA),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Badge =====
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'ANNOUNCEMENT',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ===== Title =====
            const Text(
              'Instapost Holiday Hours!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 10),

            // ===== Description =====
             Text(
              'Please note that the office will be closed on December 24 and 25. Also, the office will be closed on December 25 and January 1 2025 for the holidays',
              style: TextStyle(
                fontSize: 13,
                color:Colors.black.withValues(alpha: 0.9),
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),

            // ===== Wish Message =====
            Text(
              'Wishing you and your loved ones a joyful holiday season!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 14),

            // ===== Image =====
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage(
                    'asset/images/real_state_agent/home/holiday.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha:0.4),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===================== DASHBOARD OVERVIEW SECTION =====================
  Widget _buildDashboardOverviewSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== Header =====
          const Text(
            'Dashboard Overview',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 14),

          // ===== Cards Row 1 (2 columns) =====
          Row(
            children: [
              // Pending Orders Card
              Expanded(
                child: _buildDashboardCard(
                  icon: Icons.location_on_outlined,
                  iconColor: AppColors.coralRed,
                  backgroundColor: AppColors.lightBlueBg,
                  number: '100',
                  label: 'Pending Orders',
                ),
              ),
              const SizedBox(width: 12),

              // Total Agents Card
              Expanded(
                child: _buildDashboardCard(
                  icon: Icons.location_on_outlined,
                  iconColor: AppColors.coralRed,
                  backgroundColor: AppColors.lightOrangeBg,
                  number: '45',
                  label: 'Total Agents',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // ===== Card Row 2 (Full width) =====
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.lightPinkBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFEBEBEB),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.warning_amber,
                    color: AppColors.orange,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '100',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Low Stock Inventory',
                        style: TextStyle(
                          fontSize: 14,
                          color:Color(0xFF007A5E),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===== Reusable Dashboard Card Widget =====
  Widget _buildDashboardCard({
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
    required String number,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFEBEBEB),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CircleAvatar(
             radius:22,
             backgroundColor: Colors.white,
             child: Icon(icon, color: iconColor, size: 28),
           ),
          const SizedBox(height: 12),
          Text(
            number,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF007A5E),
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  // ===================== CHOOSE SERVICE TYPE SECTION =====================
  Widget _buildChooseServiceTypeSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ChooseServiceTypeWidget(
        serviceItems: controller.serviceItems,
        onServiceSelected: (serviceType) {
          // Blank onTap - API integration এর জন্য রেখেছি
          // presentation.onServiceSelected(serviceType);
          Logger().i('Service selected: $serviceType');
        },
      ),
    );
  }

  // ===================== BOTTOM NAVIGATION BAR =====================
  // ===================== BOTTOM NAVIGATION BAR =====================
  // ===================== BOTTOM NAVIGATION BAR (CUSTOM) =====================
  Widget _buildBottomNavigationBar() {
    return Padding(
      padding: const EdgeInsets.all(19.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(34),
          border: Border.all(color: Colors.lightBlueAccent),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(34),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                // ===== HOME =====
                Expanded(
                  child: _buildCustomBottomNavItem(
                    icon: Icons.home_outlined,
                    label: 'Home',
                    isSelected: true,
                  ),
                ),
                // ===== ORDER =====
                Expanded(
                  child: _buildCustomBottomNavItem(
                    icon: Icons.shopping_bag_outlined,
                    label: 'Order',
                    isSelected: false,
                  ),
                ),
                // ===== INVENTORY =====
                Expanded(
                  child: _buildCustomBottomNavItem(
                    icon: Icons.inventory_2_outlined,
                    label: 'Inventory',
                    isSelected: false,
                  ),
                ),
                // ===== PROFILE =====
                Expanded(
                  child: _buildCustomBottomNavItem(
                    icon: Icons.person_outline_outlined,
                    label: 'Profile',
                    isSelected: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// ===== CUSTOM NAV ITEM =====
// ===== CUSTOM NAV ITEM =====
  Widget _buildCustomBottomNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
  })
  {
    return GestureDetector(
      onTap: () {
        // Later navigation implement করবো
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32,
            color: isSelected ? const Color(0xFF4CAF50) : const Color(0xFF616161),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              // ===== SELECTED: GREEN, UNSELECTED: DARK GREY =====
              color: isSelected ? const Color(0xFF4CAF50) : const Color(0xFF616161),
            ),
          ),
        ],
      ),
    );
  }
}