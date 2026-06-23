import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../../../../../core/utils/widget/customeTextField/custom_text_field.dart';
import '../controller/admin_invoices_controller.dart';

class RefundDialog extends GetView<AdminInvoicesController> {
  const RefundDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor:AppColors.onboardingColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 16.h),
            _buildTabBar(),
            SizedBox(height: 14.h),
            Obx(() => controller.refundType.value == RefundType.partial
                ? _buildAmountField()
                : const SizedBox.shrink()),
            _buildReasonField(),
            SizedBox(height: 12.h),
            _buildSummary(),
            SizedBox(height: 16.h),
            _buildConfirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Refund Order #8001',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.close, size: 20.sp, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Obx(() {
      final isFullSelected = controller.refundType.value == RefundType.full;

      return Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.all(3.w),
        child: Row(
          children: [
            Expanded(
              child: _buildTab(
                'Full Refund',
                isFullSelected,
                    () => controller.switchRefundType(RefundType.full),
              ),
            ),

            SizedBox(width: 8.w),

            Expanded(
              child: _buildTab(
                'Partial Refund',
                !isFullSelected,
                    () => controller.switchRefundType(RefundType.partial),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildTab(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF2196F3)
              : Colors.white,
          borderRadius: BorderRadius.circular(6.r),
          boxShadow: [], // ✅ shadow completely removed
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.black, // ✅ unselected black
          ),
        ),
      ),
    );
  }

  Widget _buildAmountField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: CustomTextField(
        controller: controller.refundAmountController,
        labelText: 'Refund Amount',
        hintText: '\$145.00',
        keyboardType: TextInputType.number,
        borderColor: Colors.grey.shade300,
        filColor: Colors.white,
        isvalidation: false,
      ),
    );
  }

  Widget _buildReasonField() {
    return CustomTextField(
      controller: controller.refundReasonController,
      labelText: 'Refund Reason',
      hintText: 'Write refund reason',
      maxLine: 3,
      borderColor: Colors.grey.shade300,
      hinTextColor: Colors.black54,
      filColor: Colors.white,
      isvalidation: false,
    );
  }

  Widget _buildSummary() {
    return Obx(() {
      final isPartial = controller.refundType.value == RefundType.partial;
      return Column(
        children: [
          _buildSummaryRow('Refund Type', isPartial ? 'Partial' : 'Full'),
          SizedBox(height: 6.h),
          _buildSummaryRow(
            'Refund Amount',
            isPartial
                ? controller.refundAmountController.text
                : '\$145.00',
          ),
        ],
      );
    });
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: controller.confirmRefund,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2196F3),
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 13.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: Text(
          'Confirm Refund',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}