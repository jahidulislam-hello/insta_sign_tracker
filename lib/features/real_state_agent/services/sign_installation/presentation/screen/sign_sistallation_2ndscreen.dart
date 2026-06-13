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
                        fontSize: 14.h,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: () {
                        // Image pick করার জন্য
                        Get.snackbar(
                          'Image',
                          'Image picker will open here',
                          duration: const Duration(seconds: 1),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 100.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[50],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_outlined,
                              size: 40,
                              color: Colors.blue,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Uploaded Image',
                              style: TextStyle(
                                fontSize: 14.h,
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

              // ===== Confirm Address =====
              Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Confirm that the address is accurate',
                      style: TextStyle(
                        fontSize: 14.h,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Obx(
                          () => DropdownButtonFormField<String>(
                        initialValue:
                        controller.confirmAddress.value.isEmpty
                            ? null
                            : controller.confirmAddress.value,
                        items: const ['Yes', 'No']
                            .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.confirmAddress.value = value;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Select',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide:
                            const BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide:
                            const BorderSide(color: Colors.grey),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ===== Location =====
              CustomTextField(
                controller: controller.locationController,
                hintText: 'Assign Lockbox',
                labelText: 'Location',
                borderColor: Colors.black,
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
                        fontSize: 14.h,
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
                          style: TextStyle(fontSize: 13.h),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
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
                          style: TextStyle(fontSize: 13.h),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
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
                          style: TextStyle(fontSize: 13.h),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
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
                        fontSize: 14.h,
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
                          style: TextStyle(fontSize: 13.h),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
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
                          'Shoe covers',
                          style: TextStyle(fontSize: 13.h),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                  ],
                ),
              ),

              // ===== Custom Choice Sign Installation =====
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Custom Choice Sign Installation',
                      style: TextStyle(
                        fontSize: 14.h,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Get.snackbar(
                            'Info',
                            'Add custom choice',
                            duration: const Duration(seconds: 1),
                          );
                        },
                        icon: const Icon(Icons.add, color: Colors.white),
                        iconSize: 20,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ),

              // ===== Material Type =====
              Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Material Type',
                      style: TextStyle(
                        fontSize: 14.h,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Obx(
                          () => DropdownButtonFormField<String>(
                        initialValue: controller.selectedMaterial.value.isEmpty
                            ? null
                            : controller.selectedMaterial.value,
                        items: controller.materialTypes
                            .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.selectedMaterial.value = value;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Select Material',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide:
                            const BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide:
                            const BorderSide(color: Colors.grey),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ===== Choose Size =====
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose Size',
                      style: TextStyle(
                        fontSize: 14.h,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Obx(
                          () => DropdownButtonFormField<String>(
                        initialValue: controller.selectedSize.value.isEmpty
                            ? null
                            : controller.selectedSize.value,
                        items: controller.sizeTypes
                            .map((size) => DropdownMenuItem(
                          value: size,
                          child: Text(size),
                        ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.selectedSize.value = value;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Choose Size',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide:
                            const BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide:
                            const BorderSide(color: Colors.grey),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ===== Riser Buttons =====
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Add top riser
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 8.h),
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Get.snackbar(
                            'Info',
                            'Top riser added',
                            duration: const Duration(seconds: 1),
                          );
                        },
                        icon: const Icon(Icons.add, color: Colors.blue),
                        label: Text(
                          'Add top riser',
                          style: TextStyle(
                            fontSize: 13.h,
                            color: Colors.blue,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.blue),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                      ),
                    ),

                    // Add main panel
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 8.h),
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Get.snackbar(
                            'Info',
                            'Main panel added',
                            duration: const Duration(seconds: 1),
                          );
                        },
                        icon: const Icon(Icons.add, color: Colors.blue),
                        label: Text(
                          'Add main panel',
                          style: TextStyle(
                            fontSize: 13.h,
                            color: Colors.blue,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.blue),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                      ),
                    ),

                    // Add bottom riser
                    Container(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Get.snackbar(
                            'Info',
                            'Bottom riser added',
                            duration: const Duration(seconds: 1),
                          );
                        },
                        icon: const Icon(Icons.add, color: Colors.blue),
                        label: Text(
                          'Add bottom riser',
                          style: TextStyle(
                            fontSize: 13.h,
                            color: Colors.blue,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.blue),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // ===== Place Order Button =====
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.placeOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    'Place Order',
                    style: TextStyle(
                      fontSize: 16.h,
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