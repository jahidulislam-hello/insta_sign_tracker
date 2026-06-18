import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_sign_tracker/features/real_state_agent/services/sign_installation/presentation/controller/sign_installation_controller.dart';
import '../../../../../../core/utils/widget/customeTextField/custom_text_field.dart';

class SignInstallation2ndScreen extends GetView<SignInstallationController> {
  const SignInstallation2ndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Sign Installation'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== Upload Image Section =====
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Upload Image',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: () {
                        controller.pickImage();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 100.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[50],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_outlined,
                              size: 35,
                              color: Colors.blue,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Upload Image',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ===== Confirm Address Dropdown =====
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'I confirm that the address is accurate',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Obx(
                          () => DropdownButtonFormField<String>(
                        initialValue:
                        controller.confirmAddress.value.isEmpty
                            ? 'Yes'
                            : controller.confirmAddress.value,
                        items: const ['Yes', 'No']
                            .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(fontSize: 13.sp),
                          ),
                        ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.confirmAddress.value = value;
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 12.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                              color: Colors.grey[300]!,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                              color: Colors.grey[300]!,
                              width: 1,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ===== Agent Lockbox =====
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Agent Lockbox',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: controller.locationController,
                      hintText: 'Assign Lockbox',
                      labelText: '',
                      borderColor: Colors.grey[300]!,
                    ),
                  ],
                ),
              ),

              // ===== Site Warning =====
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Site Warning',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Obx(
                          () => CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        value: controller.undergroundSprinkler.value,
                        onChanged: (value) {
                          controller.undergroundSprinkler.value =
                              value ?? false;
                        },
                        title: Text(
                          'Underground sprinkler system',
                          style: TextStyle(fontSize: 13.sp),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                    Obx(
                          () => CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        value: controller.undergroundUtility.value,
                        onChanged: (value) {
                          controller.undergroundUtility.value = value ?? false;
                        },
                        title: Text(
                          'Underground utility system',
                          style: TextStyle(fontSize: 13.sp),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                    Obx(
                          () => CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        value: controller.invisibleDogFence.value,
                        onChanged: (value) {
                          controller.invisibleDogFence.value = value ?? false;
                        },
                        title: Text(
                          'Invisible dog fence',
                          style: TextStyle(fontSize: 13.sp),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                  ],
                ),
              ),

              // ===== Add-on Services =====
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add-on Services',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Obx(
                          () => CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        value: controller.addBrochureBox.value,
                        onChanged: (value) {
                          controller.addBrochureBox.value = value ?? false;
                        },
                        title: Text(
                          'Add brochure box',
                          style: TextStyle(fontSize: 13.sp),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                    Obx(
                          () => CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        value: controller.shoeCovers.value,
                        onChanged: (value) {
                          controller.shoeCovers.value = value ?? false;
                        },
                        title: Text(
                          'Shoe Covers',
                          style: TextStyle(fontSize: 13.sp),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                  ],
                ),
              ),

              // ===== Riser Buttons =====
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Column(
                  children: [
                    // Add top riser - Light Blue
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          controller.addTopRiser();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF52B5F7),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.add_circle,
                            color: Colors.white, size: 20),
                        label: Text(
                          'Add top riser',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10.h),

                    // Add main panel - Green
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          controller.addMainPanel();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF27AE60),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.add_circle,
                            color: Colors.white, size: 20),
                        label: Text(
                          'Add main panel',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10.h),

                    // Add bottom riser - Dark Blue
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          controller.addBottomRiser();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E5BA8),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.add_circle,
                            color: Colors.white, size: 20),
                        label: Text(
                          'Add Bottom rider',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ===== Price Breakdown =====
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey[200]!,
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price Breakdown',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      // Post Install
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Post Install',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            '\$8.00',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      // Credit Card Fee
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Credit Card Fee',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            '\$15.00',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                        height: 1,
                      ),
                      SizedBox(height: 12.h),
                      // Total Price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Price',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '\$200.00',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.blue,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // ===== Place Order Button =====
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: controller.placeOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF52B5F7),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.arrow_forward, color: Colors.white),
                  label: Text(
                    'Place Order',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}