import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_sign_tracker/features/real_state_agent/services/sales_direction/presentation/controller/check_out_controller.dart';
import '../../../../../../core/utils/widget/customeTextField/custom_text_field.dart';

class AddCardScreen extends GetView<CheckOutController> {
  const AddCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Form(
        key: controller.addCardFormKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),

                // ===== Card Number =====
                CustomTextField(
                  controller: controller.cardNumberController,
                  hintText: '6243 1234 5678 9421',
                  labelText: 'Card Number',
                  keyboardType: TextInputType.number,
                  borderColor: Colors.grey.shade300,
                  borderRadius: 10,
                  contentPaddingHorizontal: 14.w,
                  contentPaddingVertical: 12.h,
                  filColor: Colors.grey.shade50,
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 32.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              'VISA',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Container(
                          width: 32.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              'MC',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                // ===== Expire Date and CVC =====
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: controller.expireDateController,
                        hintText: 'DD-MM-YY',
                        labelText: 'Expire Date',
                        keyboardType: TextInputType.text,
                        borderColor: Colors.grey.shade300,
                        borderRadius: 10,
                        contentPaddingHorizontal: 14.w,
                        contentPaddingVertical: 12.h,
                        filColor: Colors.grey.shade50,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomTextField(
                        controller: controller.cvcController,
                        hintText: 'CVC',
                        labelText: 'CVC',
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        borderColor: Colors.grey.shade300,
                        borderRadius: 10,
                        contentPaddingHorizontal: 14.w,
                        contentPaddingVertical: 12.h,
                        filColor: Colors.grey.shade50,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                // ===== Country Dropdown =====
                Text(
                  'Country',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                Obx(
                      () => DropdownButtonFormField<String>(
                    value: controller.selectedCountry.value,
                    hint: Text(
                      'Select a country',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black38,
                      ),
                    ),
                    items: controller.countries
                        .map((country) => DropdownMenuItem(
                      value: country,
                      child: Text(
                        country,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ))
                        .toList(),
                    onChanged: (val) => controller.selectedCountry.value = val,
                    validator: controller.validateCountry,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 12.h,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        BorderSide(color: Colors.blue, width: 1.5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red.shade400,
                          width: 1.5,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red.shade400,
                          width: 1.5,
                        ),
                      ),
                    ),
                    dropdownColor: Colors.white,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black54,
                      size: 20.sp,
                    ),
                  ),
                ),
                SizedBox(height: 40.h),

                // ===== Go to My Card Button =====
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.addCard,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Go To My Card',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===== App Bar =====
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
        onPressed: () => Get.back(),
      ),
      title: const Text(
        'Add Card',
        style: TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
    );
  }
}
