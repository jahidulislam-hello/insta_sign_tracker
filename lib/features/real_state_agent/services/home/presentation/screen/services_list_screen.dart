import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/routes/app_routes.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../../../../home/presentation/widget/app_drawer_widget.dart';
import '../controller/services_list_controller.dart';


class ServicesListScreen extends GetView<ServicesListController> {
  const ServicesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      drawer:  const AppDrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== FOR SALE SIGNS SECTION =====
            _buildSectionHeader('FOR SALE SIGNS'),

            _buildServiceItem(
              icon: Icons.home_outlined,
              iconColor: AppColors.primaryBlue,
              iconBgColor: const Color(0xFFE3F2FD),
              title: 'Order New Sign Install',
              onTap: () {
                Get.toNamed(AppRoutes.signInstallationScreen);
              },
            ),

            _buildServiceItem(
              icon: Icons.print_outlined,
              iconColor: AppColors.primaryBlue,
              iconBgColor: const Color(0xFFE3F2FD),
              title: 'Order Sign Printing',
              onTap: () {
                Get.toNamed(AppRoutes.signPrintingScreen);
              },
            ),

            _buildServiceItem(
              icon: Icons.close_rounded,
              iconColor: const Color(0xFFD32F2F),
              iconBgColor: const Color(0xFFFFEBEE),
              title: 'Order Sign Removal',
              onTap: () {
                Get.toNamed(AppRoutes.signRemovalScreen);
              },
            ),

            _buildServiceItem(
              icon: Icons.compare_arrows,
              iconColor: AppColors.primaryBlue,
              iconBgColor: const Color(0xFFE3F2FD),
              title: 'Order Sign Change\nRequest',
              onTap: () {
                Get.toNamed(AppRoutes.signChangeScreen);
              },
            ),

            const SizedBox(height: 16),

            // ===== OTHER SERVICES SECTION =====
            _buildSectionHeader('OTHER SERVICES'),

            _buildServiceItem(
              icon: Icons.send_outlined,
              iconColor: AppColors.primaryBlue,
              iconBgColor: const Color(0xFFE3F2FD),
              title: 'Order For Sale\nDirectionals',
              onTap: () {
                Get.toNamed(AppRoutes.saleDirectionScreen);
              },
            ),

            _buildServiceItem(
              icon: Icons.home_outlined,
              iconColor: const Color(0xFFD32F2F),
              iconBgColor: const Color(0xFFFFEBEE),
              title: 'Order Open House\nServices',
              onTap: () {
                Get.toNamed(AppRoutes.houseServiceScreen);
              },
            ),

            _buildServiceItem(
              icon: Icons.camera_alt_outlined,
              iconColor: AppColors.primaryBlue,
              iconBgColor: const Color(0xFFE3F2FD),
              title: 'Order Media Services',
              onTap: () {
                Get.toNamed(AppRoutes.mediaServiceScreen);
              },
            ),

            _buildServiceItem(
              icon: Icons.apps_outlined,
              iconColor: AppColors.primaryBlue,
              iconBgColor: const Color(0xFFE3F2FD),
              title: 'Other Service',
              badge: 'NEW',
              onTap: () {
                Get.toNamed(AppRoutes.otherServiceScreen);
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ===================== APP BAR =====================
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: const Text(
        'Services',
        style: TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications_outlined,
            color: Colors.black87,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  // ===================== SECTION HEADER =====================
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.black,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  // ===================== SERVICE ITEM =====================
  Widget _buildServiceItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    String? badge,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),

                  if (badge != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          badge,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}