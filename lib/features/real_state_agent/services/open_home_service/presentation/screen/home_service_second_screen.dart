import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import 'package:insta_sign_tracker/features/real_state_agent/services/open_home_service/presentation/controller/home_service_second_controller.dart';

import '../../../../../../core/utils/widget/customeTextField/custom_text_field.dart';

class HomeServiceSecondScreen extends GetView<HomeServiceSecondController> {
  const HomeServiceSecondScreen({super.key});

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
        key: controller.formKey,
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
          _buildHouseTypeSelector(),
          SizedBox(height: 16.h),

          _label('Sign Placement'),
          SizedBox(height: 8.h),
          _buildSelectorField(
            context: context,
            value: controller.selectedSignPlacement,
            hasError: controller.signPlacementError,
            placeholder: 'Search to Select',
            trailingIcon: Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 22.sp),
            errorText: 'Please select sign placement',
            onTap: () => _showSelectionBottomSheet(
              context,
              'Select Sign Placement',
              controller.signPlacementList,
              controller.selectSignPlacement,
            ),
          ),
          SizedBox(height: 16.h),

          _label('Lead in Intersection'),
          CustomTextField(
            controller: controller.leadInIntersectionController,
            hintText: 'When would you like us to being placing sign',
            hinTextSize: 13,
            borderColor: Colors.grey.shade300,
          ),

          _label('Notes'),
          CustomTextField(
            controller: controller.notesController,
            hintText: 'Type notes here',
            hinTextSize: 13,
            maxLine: 3,
            isvalidation: false,
            borderColor: Colors.grey.shade300,
          ),
          SizedBox(height: 4.h),

          _label('Select Open House Directional'),
          SizedBox(height: 8.h),
          _buildSelectorField(
            context: context,
            value: controller.selectedDirectional,
            hasError: controller.directionalError,
            placeholder: 'Select',
            trailingIcon: Icon(Icons.arrow_forward, color: Colors.grey, size: 16.sp),
            errorText: 'Please select open house directional',
            onTap: () => _showSelectionBottomSheet(
              context,
              'Select Open House Directional',
              controller.directionalList,
              controller.selectDirectional,
            ),
          ),
          SizedBox(height: 16.h),

          _label('Select Rider'),
          SizedBox(height: 8.h),
          _buildSelectorField(
            context: context,
            value: controller.selectedRider,
            hasError: controller.riderError,
            placeholder: 'Select',
            trailingIcon: Icon(Icons.arrow_forward, color: Colors.grey, size: 16.sp),
            errorText: 'Please select rider',
            onTap: () => _showSelectionBottomSheet(
              context,
              'Select Rider',
              controller.riderList,
              controller.selectRider,
            ),
          ),
          SizedBox(height: 16.h),

          Text('Add On Service',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black)),
          SizedBox(height: 8.h),
          _buildShoeCoverCheckbox(),
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

  Widget _buildHouseTypeSelector() {
    return Obx(() {
      return Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: controller.houseTypeList.map((type) {
            final isSelected = controller.selectedHouseType.value == type;
            return Expanded(
              child: GestureDetector(
                onTap: () => controller.selectHouseType(type),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryBlue : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    type,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black54,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
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

  Widget _buildSelectorField({
    required BuildContext context,
    required RxString value,
    required RxBool hasError,
    required String placeholder,
    required Widget trailingIcon,
    required String errorText,
    required VoidCallback onTap,
  }) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: hasError.value ? Colors.red : Colors.grey.shade300,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value.value.isEmpty ? placeholder : value.value,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: value.value.isEmpty ? Colors.black54 : Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  trailingIcon,
                ],
              ),
            ),
          ),
          if (hasError.value)
            Padding(
              padding: EdgeInsets.only(top: 6.h, left: 4.w),
              child: Text(errorText, style: TextStyle(color: Colors.red, fontSize: 11.sp)),
            ),
        ],
      );
    });
  }

  Widget _buildShoeCoverCheckbox() {
    return Obx(() {
      final isSelected = controller.isShoeCoverSelected.value;
      return GestureDetector(
        onTap: controller.toggleShoeCover,
        child: Row(
          children: [
            Container(
              width: 18.w,
              height: 18.w,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryBlue : Colors.white,
                border: Border.all(color: isSelected ? AppColors.primaryBlue : Colors.grey.shade400),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: isSelected ? Icon(Icons.check, size: 13.sp, color: Colors.white) : null,
            ),
            SizedBox(width: 8.w),
            Text('Shoe Cover', style: TextStyle(fontSize: 12.sp, color: Colors.black54)),
          ],
        ),
      );
    });
  }

  Widget _buildPriceBreakdownCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Price Breakdown', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black)),
          SizedBox(height: 12.h),
          _priceRow('Post Install', controller.postInstallPrice),
          SizedBox(height: 8.h),
          _priceRow('Credit Card Fee', controller.creditCardFee),
          SizedBox(height: 8.h),
          _priceRow('Others Fee', controller.othersFee),
          SizedBox(height: 12.h),
          Divider(color: Colors.grey.shade300),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Price', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, color: Colors.black)),
              Text(
                '\$${controller.totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
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
          onPressed: controller.placeOrder,
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

  void _showSelectionBottomSheet(
      BuildContext context, String title, List<String> items, ValueChanged<String> onSelect) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16.r))),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Text(title, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600)),
              ),
              const Divider(height: 1),
              ...items.map((item) {
                return ListTile(
                  title: Text(item, style: TextStyle(fontSize: 13.sp)),
                  onTap: () {
                    onSelect(item);
                    Navigator.pop(context);
                  },
                );
              }),
              SizedBox(height: 8.h),
            ],
          ),
        );
      },
    );
  }
}