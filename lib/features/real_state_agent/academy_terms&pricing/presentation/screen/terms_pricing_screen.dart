import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import 'package:insta_sign_tracker/features/real_state_agent/home/presentation/widget/app_drawer_widget.dart';
import '../controller/academy_controller.dart';

class TermsPricingScreen extends GetView<AcademyController> {
  const TermsPricingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingColor,
      appBar: _buildAppBar(),
      drawer: const AppDrawerWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== TITLE =====
              _buildTitle(),

              const SizedBox(height: 24),

              // ===== DESCRIPTION =====
              _buildDescription(),

              const SizedBox(height: 24),

              // ===== PAYMENT SCHEDULE =====
              _buildPaymentSchedule(),

              const SizedBox(height: 16),

              // ===== REVISIONS =====
              _buildRevisions(),

              const SizedBox(height: 24),

              // ===== INFO BOX =====
              _buildInfoBox(),

              const SizedBox(height: 24),

              // ===== SAVE BUTTON =====
              _buildSaveButton(),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
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
        'Terms & Pricing',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none, color: Colors.white),
        ),
      ],
    );
  }

  // ===================== TITLE =====
  Widget _buildTitle() {
    return const Text(
      'Standard Service Agreement',
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Color(0xFF0D47A1),
        letterSpacing: 0.3,
      ),
    );
  }

  // ===================== DESCRIPTION =====
  Widget _buildDescription() {
    return Text(
      'Pricing is calculated based on the total square footage of the project area and the complexity of the architectural requirements. Our baseline rate for residential consultation starts at \$150/hr.',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.grey[700],
        height: 1.6,
        letterSpacing: 0.2,
      ),
    );
  }

  // ===================== PAYMENT SCHEDULE =====
  Widget _buildPaymentSchedule() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '1. Payment Schedule: ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[800],
                ),
              ),
              TextSpan(
                text:
                '50% deposit required upfront for all projects over \$2,500. Final balance is due upon delivery of technical drawings.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===================== REVISIONS =====
  Widget _buildRevisions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '2. Revisions: ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[800],
                ),
              ),
              TextSpan(
                text:
                'Two rounds of major revisions are included in the standard package. Additional revisions will be billed at the hourly rate.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===================== INFO BOX =====
  Widget _buildInfoBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primaryBlue,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.info,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          // Text
          Expanded(
            child: Text(
              'Updates to these terms will be applied to all future client proposals and invoices automatically.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===================== SAVE BUTTON =====
  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Later implement save functionality
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            const SnackBar(
              content: Text('Changes saved successfully'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Save Changes',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}