import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../presentation/settings_controller.dart';
import '../widget/add_auto_renew_dialog.dart';

class AllUserSettingScreen extends GetView<SettingsController> {
  const AllUserSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Search & Filter Section =====
            _buildSearchSection(),

            // ===== Auto Renew Section =====
            _buildAutoRenewSection(),
          ],
        ),
      ),
    );
  }

  // ===================== APP BAR =====================
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primaryBlue,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () {
          Get.back();
        },
      ),
      title: const Text(
        'All Users',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Stack(
            children: [
              const Icon(Icons.notifications_none, color: Colors.white),
              // ===== Notification Badge =====
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===================== SEARCH SECTION =====================
  Widget _buildSearchSection() {
    return Container(
      color: AppColors.primaryBlue,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      child: Row(
        children: [
          // ===== Search Field =====
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search by order ID or address...',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // ===== Filter Button =====
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.tune_outlined,
              color: Colors.grey.shade700,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  // ===================== AUTO RENEW SECTION =====================
  Widget _buildAutoRenewSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== Header Row =====
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ===== Title with Count =====
              const Text(
                'Auto Renew ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                  letterSpacing: 0.3,
                ),
              ),
              Text(
                '(08)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),
              const Spacer(),

              // ===== Add New Button =====
              GestureDetector(
                onTap: () => _showAddAutoRenewDialog(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, color: Colors.white, size: 18),
                      SizedBox(width: 6),
                      Text(
                        'Add New',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ===== Plans List =====
          ..._buildPlansList(),
        ],
      ),
    );
  }

  // ===== Build Plans List =====
  List<Widget> _buildPlansList() {
    final plans = [
      {
        'title': '90 Days Plan',
        'price': '\$120',
        'status': 'Active',
        'isActive': true,
      },
      {
        'title': '90 Days Plan',
        'price': '\$120',
        'status': 'Inactive',
        'isActive': false,
      },
      {
        'title': '90 Days Plan',
        'price': '\$120',
        'status': 'Active',
        'isActive': true,
      },
    ];

    return plans.map((plan) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: _buildPlanCard(
          title: plan['title'] as String,
          price: plan['price'] as String,
          status: plan['status'] as String,
          isActive: plan['isActive'] as bool,
        ),
      );
    }).toList();
  }

  // ===== Plan Card Widget =====
  Widget _buildPlanCard({
    required String title,
    required String price,
    required String status,
    required bool isActive,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // ===== Top Row =====
          Row(
            children: [
              // ===== Plan Icon =====
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.settings_outlined,
                  color: Colors.grey.shade600,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),

              // ===== Title & Price =====
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              // ===== Status Badge =====
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? Colors.green.withValues(alpha: 0.1)
                      : Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: isActive ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // ===== Bottom Row (Icons & Toggle) =====
          Row(
            children: [
              // ===== Delete Icon =====
              GestureDetector(
                onTap: () {
                  Get.snackbar(
                    'Deleted',
                    'Plan deleted successfully',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.orange,
                    colorText: Colors.white,
                  );
                },
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.red.shade400,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),

              // ===== Edit Icon =====
              GestureDetector(
                onTap: () {
                  Get.snackbar(
                    'Edit',
                    'Opening plan for editing',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.blue,
                    colorText: Colors.white,
                  );
                },
                child: Icon(
                  Icons.edit_outlined,
                  color: Colors.blue.shade400,
                  size: 20,
                ),
              ),
              const Spacer(),

              // ===== Toggle Switch =====
              Switch(
                value: isActive,
                onChanged: (value) {
                  Get.snackbar(
                    'Status Changed',
                    value ? 'Plan activated' : 'Plan deactivated',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor:
                    value ? Colors.green : Colors.orange,
                    colorText: Colors.white,
                  );
                },
                activeColor: AppColors.primaryBlue,
                inactiveThumbColor: Colors.grey.shade400,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===== Show Add Auto Renew Dialog =====
  void _showAddAutoRenewDialog() {
    Get.dialog(
      AddAutoRenewDialog(
        onAdd: () {
          // Dialog এ Add button press হলে refresh করতে পারো
          print('Plan added, refresh list...');
        },
      ),
      barrierDismissible: true,
    );
  }
}