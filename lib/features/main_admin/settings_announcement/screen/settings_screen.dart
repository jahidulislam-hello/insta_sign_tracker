import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../../../../core/utils/widget/customeTextField/custom_text_field.dart';
import '../presentation/settings_controller.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== COMPANY INFORMATION =====
              _buildCompanyInformationSection(),
              const SizedBox(height: 28),

              // ===== ACCOUNT OWNER =====
              _buildAccountOwnerSection(),
              const SizedBox(height: 28),

              // ===== CURRENT SUBSCRIPTION =====
              _buildCurrentSubscriptionSection(),
              const SizedBox(height: 28),

              // ===== AVAILABLE PLANS =====
              _buildAvailablePlansSection(),
              const SizedBox(height: 20),
            ],
          ),
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
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () {},
      ),
      title: const Text(
        'Settings',
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
          onPressed: () {},
          icon: const Icon(Icons.notifications_none, color: Colors.white),
        ),
      ],
    );
  }

  // ===================== COMPANY INFORMATION SECTION =====================
  Widget _buildCompanyInformationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ===== Header =====
        const Text(
          'Company Information',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 16),

        // ===== Brand Logo =====
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color(0xFFE8F2FF).withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const Icon(
                      Icons.image_outlined,
                      color: Colors.grey,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Brand Logo',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Recommended 512×512px',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // ===== Name Field =====
        CustomTextField(
          controller: controller.nameController,
          labelText: 'Name',
          hintText: 'Architectural Utility Ltd',
          keyboardType: TextInputType.text,
          borderColor: Colors.grey.shade300,
          borderRadius: 8,
          borderHeight: 1,
          filColor: Colors.white,
          hinTextColor: Colors.black54,
          hinTextSize: 13,
          contentPaddingHorizontal: 12,
          contentPaddingVertical: 10,
          prefixIcon: Icon(
            Icons.business_outlined,
            color: Colors.grey.shade600,
            size: 20,
          ),
        ),

        // ===== Email Field =====
        CustomTextField(
          controller: controller.emailController,
          labelText: 'Email',
          hintText: 'example@gmail.com',
          keyboardType: TextInputType.emailAddress,
          borderColor: Colors.grey.shade300,
          borderRadius: 8,
          borderHeight: 1,
          filColor: Colors.white,
          hinTextColor: Colors.black54,
          hinTextSize: 13,
          contentPaddingHorizontal: 12,
          contentPaddingVertical: 10,
          isEmail: true,
        ),

        // ===== Phone Field =====
        CustomTextField(
          controller: controller.phoneController,
          labelText: 'Phone',
          hintText: '13456789',
          keyboardType: TextInputType.phone,
          borderColor: Colors.grey.shade300,
          borderRadius: 8,
          borderHeight: 1,
          filColor: Colors.white,
          hinTextColor: Colors.black54,
          hinTextSize: 13,
          contentPaddingHorizontal: 12,
          contentPaddingVertical: 10,
        ),

        // ===== Address Field =====
        CustomTextField(
          controller: controller.addressController,
          labelText: 'Address',
          hintText: '742 Evergreen Terrace, Springfield, OR 974',
          keyboardType: TextInputType.text,
          borderColor: Colors.grey.shade300,
          borderRadius: 8,
          borderHeight: 1,
          filColor: Colors.white,
          hinTextColor: Colors.black54,
          hinTextSize: 13,
          contentPaddingHorizontal: 12,
          contentPaddingVertical: 10,
          maxLine: 2,
        ),
      ],
    );
  }

  // ===================== ACCOUNT OWNER SECTION =====================
  Widget _buildAccountOwnerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ===== Header =====
        const Text(
          'Account Owner',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 16),

        // ===== Owner Card =====
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // ===== Avatar =====
              CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.primaryBlue,
                child: const Text(
                  'JD',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // ===== Name & Email =====
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Julian Draxler',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'julian@arch.com',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              // ===== Edit Button =====
              GestureDetector(
                onTap: () => controller.showEditDialog(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===================== CURRENT SUBSCRIPTION SECTION =====================
  Widget _buildCurrentSubscriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ===== Header =====
        const Text(
          'Current Subscription',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 16),

        // ===== Subscription Card =====
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF008BD8),
                Color(0xFF004E78),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== Top Row: Badge & Price =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'ACTIVE',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  const Text(
                    '\$24.00',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // ===== Plan Name =====
              const Text(
                'Insta Gold',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),

              // ===== Dates Row =====
              Row(
                children: [
                  // ===== Start Date =====
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Start Date',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.3,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Jan 15, 2024',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ===== Renewal Date =====
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Renewal Date',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.3,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Feb 12, 2024',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ===== Buttons Row =====
              Row(
                children: [
                  // ===== Cancel Button =====
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        backgroundColor:  Colors.white.withValues(alpha: 0.35),
                        side: const BorderSide(
                          color: Colors.grey,
                          width: .5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // ===== Renew Button =====
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // ✅ এই line add করো
                        controller.navigateToAllUsersScreen();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Renew Now',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===================== AVAILABLE PLANS SECTION =====================
  Widget _buildAvailablePlansSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ===== Header =====
        const Text(
          'Available Plans',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 16),

        // ===== Plans Row =====
        Row(
          children: [
            // ===== Basic Plan =====
            Expanded(
              child: _buildPlanCard(
                planName: 'Basic Plan',
                price: '\$6.00',
                period: '/month',
                features: [
                  '5,000 AI Credits',
                  'Basic Support',
                  '1 Team Member',
                ],
                buttonText: 'Get Basic',
                isActive: false,
              ),
            ),
            const SizedBox(width: 12),

            // ===== Premium Plan =====
            Expanded(
              child: _buildPlanCard(
                planName: 'Insta Premium',
                price: '\$12.',
                period: '/month',
                features: [
                  '15,000 AI Credits',
                  'Priority Support',
                  '5 Team Members',
                ],
                buttonText: 'Get Premium',
                isActive: false,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ===== Reusable Plan Card Widget =====
  Widget _buildPlanCard({
    required String planName,
    required String price,
    required String period,
    required List<String> features,
    required String buttonText,
    required bool isActive,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(
          color: isActive ? AppColors.primaryBlue : Colors.grey.shade300,
          width: isActive ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== Plan Name & Price =====
          Text(
            planName,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),

          // ===== Price =====
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: price,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                TextSpan(
                  text: period,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // ===== Features =====
          ...features.map((feature) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    size: 18,
                    color: Colors.teal,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      feature,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          const SizedBox(height: 12),

          // ===== Button =====
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}