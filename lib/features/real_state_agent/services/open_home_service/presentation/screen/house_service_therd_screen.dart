import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import 'package:insta_sign_tracker/features/real_state_agent/services/open_home_service/presentation/controller/home_service_second_controller.dart';

import '../../../../../../core/utils/widget/customeTextField/custom_text_field.dart';

class HouseServiceTherdScreen extends GetView<HomeServiceSecondController> {
  const HouseServiceTherdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20.sp),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Open House Services',
          style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),
      body: Form(
        key: controller.formKeyThird,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMainCard(context),
              SizedBox(height: 16.h),
              Text(
                'Review Order',
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700, color: Colors.black),
              ),
              SizedBox(height: 10.h),
              _buildPriceBreakdownCard(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildPlaceOrderButton(),
    );
  }

  Widget _buildMainCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label('House is'),
          SizedBox(height: 8.h),
          _buildHouseStatusSelector(),
          SizedBox(height: 16.h),

          _label('Lockbox'),
          CustomTextField(
            controller: controller.lockboxController,
            hintText: 'Assign Lockbox',
            hinTextSize: 13,
            borderColor: Colors.grey.shade300,
          ),

          _label('Please provide gate code (if applicable)'),
          CustomTextField(
            controller: controller.gateCodeController,
            hintText: 'Place gate code here',
            hinTextSize: 13,
            isvalidation: false,
            borderColor: Colors.grey.shade300,
          ),

          _label('Due Date'),
          SizedBox(height: 8.h),
          _buildDueDateField(context),
          SizedBox(height: 16.h),

          _buildAsapRushRow(),
          SizedBox(height: 16.h),

          _label('Notes'),
          CustomTextField(
            controller: controller.thirdNotesController,
            hintText: 'Type notes here',
            hinTextSize: 13,
            maxLine: 3,
            isvalidation: false,
            borderColor: Colors.grey.shade300,
          ),
          SizedBox(height: 4.h),

          Text('Confirmation',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black)),
          SizedBox(height: 8.h),
          _buildConfirmationCheckbox(),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(text, style: TextStyle(fontSize: 13.sp, color: Colors.black, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildHouseStatusSelector() {
    return Obx(() {
      final options = ['Occupied', 'Vacant'];
      return Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: options.map((status) {
            final isSelected = controller.houseStatus.value == status;
            return Expanded(
              child: GestureDetector(
                onTap: () => controller.selectHouseStatus(status),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    status,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 12.sp,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    });
  }

  Widget _buildDueDateField(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => controller.pickDueDate(context),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: controller.dueDateError.value ? Colors.red : Colors.grey.shade300,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.selectedDueDate.value == null ? 'Select Date' : controller.formattedDueDate,
                    style: TextStyle(fontSize: 13.sp, color: Colors.black, fontWeight: FontWeight.w400),
                  ),
                  Icon(Icons.calendar_today_outlined, color: Colors.grey, size: 18.sp),
                ],
              ),
            ),
          ),
          if (controller.dueDateError.value)
            Padding(
              padding: EdgeInsets.only(top: 6.h, left: 4.w),
              child: Text('Please select due date', style: TextStyle(color: Colors.red, fontSize: 11.sp)),
            ),
        ],
      );
    });
  }

  Widget _buildAsapRushRow() {
    return Obx(() {
      return Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: controller.selectAsap,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: controller.isAsapSelected.value ? AppColors.primaryBlue : Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: controller.isAsapSelected.value ? AppColors.primaryBlue : Colors.grey.shade300,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'ASAP',
                  style: TextStyle(
                    color: controller.isAsapSelected.value ? Colors.white : Colors.black87,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: GestureDetector(
              onTap: controller.selectRushOrder,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: Colors.red, width: 1),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.bolt, color: Colors.red, size: 14.sp),
                    SizedBox(width: 4.w),
                    Text(
                      'Rush Order',
                      style: TextStyle(color: Colors.red, fontSize: 13.sp, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildConfirmationCheckbox() {
    return Obx(() {
      final isChecked = controller.isConfirmed.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: controller.toggleConfirmation,
            child: Row(
              children: [
                Container(
                  width: 18.w,
                  height: 18.w,
                  decoration: BoxDecoration(
                    color: isChecked ? AppColors.primaryBlue : Colors.white,
                    border: Border.all(
                      color: controller.confirmationError.value
                          ? Colors.red
                          : (isChecked ? AppColors.primaryBlue : Colors.grey.shade400),
                    ),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: isChecked ? Icon(Icons.check, size: 13.sp, color: Colors.white) : null,
                ),
                SizedBox(width: 8.w),
                Text('Property is vacant & authorized',
                    style: TextStyle(fontSize: 12.sp, color: Colors.black54)),
              ],
            ),
          ),
          if (controller.confirmationError.value)
            Padding(
              padding: EdgeInsets.only(top: 6.h, left: 26.w),
              child: Text('Please confirm before placing order',
                  style: TextStyle(color: Colors.red, fontSize: 11.sp)),
            ),
        ],
      );
    });
  }

  Widget _buildPriceBreakdownCard() {
    return Obx(() {
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price Breakdown',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black)),
            SizedBox(height: 12.h),
            _priceRow('Post Install', controller.thirdPostInstallPrice),
            SizedBox(height: 8.h),
            _priceRow('Credit Card Fee', controller.thirdCreditCardFee),
            if (controller.isRushOrderSelected.value) ...[
              SizedBox(height: 8.h),
              _priceRow('Rush Order Fee', controller.rushOrderFee),
            ],
            SizedBox(height: 8.h),
            _priceRow('Others Fee', controller.thirdOthersFee),
            SizedBox(height: 12.h),
            Divider(color: Colors.grey.shade300),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Price',
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, color: Colors.black)),
                Text(
                  '\$${controller.thirdTotalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _priceRow(String title, double price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 13.sp, color: Colors.black54)),
        Text('\$${price.toStringAsFixed(2)}', style: TextStyle(fontSize: 13.sp, color: Colors.black54)),
      ],
    );
  }

  Widget _buildPlaceOrderButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
      child: SizedBox(
        width: double.infinity,
        height: 48.h,
        child: ElevatedButton(
          onPressed: controller.placeThirdOrder,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
            elevation: 0,
          ),
          child: Text(
            'Place Order',
            style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}