import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_sign_tracker/features/real_state_agent/services/sign_installation/presentation/controller/sign_installation_controller.dart';
import '../../../../../../core/utils/widget/customeTextField/custom_text_field.dart';

class SignInstallationScreen extends GetView<SignInstallationController> {
  const SignInstallationScreen({super.key});

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
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Address
                CustomTextField(
                  controller: controller.addressController,
                  hintText: 'Lookup address',
                  labelText: 'Address',
                  borderColor: Colors.black,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter address';
                    }
                    return null;
                  },
                ),

                // Agent Name
                CustomTextField(
                  controller: controller.agentNameController,
                  hintText: 'Full name of the agent',
                  labelText: 'Agent Name',
                  borderColor: Colors.black,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter agent name';
                    }
                    return null;
                  },
                ),

                // Unit/Apt Number এবং Listing ID
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: controller.unitAptController,
                        hintText: '12081',
                        labelText: 'Unit/Apt Number',
                        keyboardType: TextInputType.number,
                        borderColor: Colors.black,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: CustomTextField(
                        controller: controller.listingIdController,
                        hintText: '123456',
                        labelText: 'Listing ID',
                        keyboardType: TextInputType.number,
                        borderColor: Colors.black,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                // Due Date - Date Picker
                CustomTextField(
                  controller: controller.dueDateController,
                  hintText: 'DD/MM/YYYY',
                  labelText: 'Due Date',
                  readOnly: true,
                  onTap: () {
                    controller.selectDate(context);
                  },
                  suffixIcon: const Icon(Icons.calendar_today_outlined),
                  borderColor: Colors.black,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select due date';
                    }
                    return null;
                  },
                ),

                // Order (ASAP / Rush Order)
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order',
                        style: TextStyle(
                          fontSize: 14.h,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(9),
                        child: Row(
                          children: [
                            Expanded(
                              child: Obx(
                                    () => ElevatedButton(
                                  onPressed: () {
                                    controller.selectedOrder.value = 'asap';
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                    controller.selectedOrder.value == 'asap'
                                        ? Colors.blue
                                        : Colors.grey[200],
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'ASAP',
                                    style: TextStyle(
                                      color:
                                      controller.selectedOrder.value ==
                                          'asap'
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Obx(
                                    () => OutlinedButton(
                                  onPressed: () {
                                    controller.selectedOrder.value = 'rush';
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: controller.selectedOrder.value ==
                                          'rush'
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                    padding:
                                    EdgeInsets.symmetric(vertical: 10.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'Rush Order',
                                    style: TextStyle(
                                      color: controller.selectedOrder.value ==
                                          'rush'
                                          ? Colors.red
                                          : Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Occupant (First Name এবং Last Name)
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: controller.firstNameController,
                        hintText: 'First Name',
                        labelText: 'Occupant',
                        borderColor: Colors.black,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: CustomTextField(
                        controller: controller.lastNameController,
                        hintText: 'Last Name',
                        labelText: '',
                        borderColor: Colors.black,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                // Select Post Type Dropdown ✅ FIXED
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Post Type',
                        style: TextStyle(
                          fontSize: 14.h,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Obx(
                            () => DropdownButtonFormField<String>(
                          initialValue: controller.selectedPostType.value.isEmpty
                              ? null
                              : controller.selectedPostType.value,
                          items: controller.postTypes
                              .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          ))
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              controller.selectedPostType.value = value;
                              controller.formKey.currentState?.validate();
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            hintText: 'Select Post',
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
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide:
                              const BorderSide(color: Colors.blue),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select post type';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Notes
                CustomTextField(
                  controller: controller.notesController,
                  hintText: 'Carefully install the sign',
                  labelText: 'Notes',
                  maxLine: 1,
                  borderColor: Colors.black,
                ),

                // Property Type Dropdown ✅ FIXED
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Property Type',
                        style: TextStyle(
                          fontSize: 14.h,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Obx(
                            () => DropdownButtonFormField<String>(
                          initialValue: controller
                              .selectedPropertyType.value.isEmpty
                              ? null
                              : controller.selectedPropertyType.value,
                          items: controller.propertyTypes
                              .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          ))
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              controller.selectedPropertyType.value = value;
                              controller.formKey.currentState?.validate();
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            hintText: 'Select Property',
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
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide:
                              const BorderSide(color: Colors.blue),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select property type';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Where should the sign be placed? Dropdown ✅ FIXED
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Where should the sign be placed?',
                        style: TextStyle(
                          fontSize: 14.h,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Obx(
                            () => DropdownButtonFormField<String>(
                          initialValue: controller
                              .selectedSignPlacement.value.isEmpty
                              ? null
                              : controller.selectedSignPlacement.value,
                          items: controller.signPlacements
                              .map((placement) => DropdownMenuItem(
                            value: placement,
                            child: Text(
                              placement,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              controller.selectedSignPlacement.value = value;
                              controller.formKey.currentState?.validate();
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            hintText: 'Install the sign infront of the house',
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
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide:
                              const BorderSide(color: Colors.blue),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select placement';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Please Select Gate Code
                CustomTextField(
                  controller: controller.gateCodeController,
                  hintText: 'Placeholder Gate Code',
                  labelText: 'Please Select Gate Code (If Applicable)',
                  borderColor: Colors.black,
                ),

                SizedBox(height: 20.h),

                // Next Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.goToNextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'Next',
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
      ),
    );
  }
}