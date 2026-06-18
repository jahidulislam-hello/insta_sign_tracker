import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_sign_tracker/features/real_state_agent/services/open_home_service/presentation/controller/house_service_controller.dart';
import '../../../../../../core/utils/widget/customeTextField/custom_text_field.dart';

class HouseServiceScreen extends GetView<HouseServiceController> {
  const HouseServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: controller.currentInstallController,
                  hintText: 'Search Select Current Install',
                  labelText: 'Current Install',
                  keyboardType: TextInputType.text,
                  borderColor: Colors.grey.shade300,
                  borderRadius: 10,
                  contentPaddingHorizontal: 14.w,
                  contentPaddingVertical: 12.h,
                  filColor: Colors.white,
                  suffixIcon: Icon(
                    Icons.search,
                    size: 20,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                  controller: controller.addressController,
                  hintText: 'Lookup Address Or Intersection',
                  labelText: 'Address *',
                  keyboardType: TextInputType.text,
                  borderColor: Colors.grey.shade300,
                  borderRadius: 10,
                  contentPaddingHorizontal: 14.w,
                  contentPaddingVertical: 12.h,
                  filColor: Colors.white,
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  controller: controller.unitAptController,
                  hintText: 'e.g 145789',
                  labelText: 'Unit / Apt. Number',
                  keyboardType: TextInputType.number,
                  borderColor: Colors.grey.shade300,
                  borderRadius: 10,
                  contentPaddingHorizontal: 14.w,
                  contentPaddingVertical: 12.h,
                  filColor: Colors.white,
                ),
                SizedBox(height: 10.h),

                // ===== Due Date =====
                Text(
                  'Due Date',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.pickDueDate(context),
                  child: AbsorbPointer(
                    child: CustomTextField(
                      controller: controller.dueDateController,
                      hintText: 'MM/DD/YYYY',
                      labelText: '',
                      keyboardType: TextInputType.text,
                      borderColor: Colors.grey.shade300,
                      borderRadius: 10,
                      contentPaddingHorizontal: 14.w,
                      contentPaddingVertical: 12.h,
                      filColor: Colors.white,
                      suffixIcon: Icon(
                        Icons.calendar_today_outlined,
                        size: 20,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // ===== Order Selection =====
                Obx(
                      () => Row(
                    children: [
                      // ASAP Button
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.selectOrder('ASAP'),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: controller.selectedOrder.value == 'ASAP'
                                  ? Colors.blue
                                  : Colors.white,
                              border: Border.all(
                                color: controller.selectedOrder.value == 'ASAP'
                                    ? Colors.blue
                                    : Colors.grey.shade300,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                'ASAP',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: controller.selectedOrder.value == 'ASAP'
                                      ? Colors.white
                                      : Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      // Rush Order Button
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.selectOrder('Rush'),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: controller.selectedOrder.value == 'Rush'
                                  ? const Color(0xFFD32F2F)
                                  : Colors.white,
                              border: Border.all(
                                color: controller.selectedOrder.value == 'Rush'
                                    ? const Color(0xFFD32F2F)
                                    : Colors.grey.shade300,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.bolt,
                                  size: 16,
                                  color: controller.selectedOrder.value == 'Rush'
                                      ? Colors.white
                                      : const Color(0xFFD32F2F),
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  'Rush Order',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: controller.selectedOrder.value == 'Rush'
                                        ? Colors.white
                                        : const Color(0xFFD32F2F),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (controller.selectedOrder.value == null)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Text(
                      'Please select order type',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.red.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                SizedBox(height: 16.h),

                // ===== Start Time and End Time =====
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start Time',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => controller.pickStartTime(context),
                            child: AbsorbPointer(
                              child: CustomTextField(
                                controller: controller.startTimeController,
                                hintText: 'e.g 10:00 AM',
                                labelText: '',
                                keyboardType: TextInputType.text,
                                borderColor: Colors.grey.shade300,
                                borderRadius: 10,
                                contentPaddingHorizontal: 14.w,
                                contentPaddingVertical: 12.h,
                                filColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'End Time',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => controller.pickEndTime(context),
                            child: AbsorbPointer(
                              child: CustomTextField(
                                controller: controller.endTimeController,
                                hintText: 'e.g 10:00 AM',
                                labelText: '',
                                keyboardType: TextInputType.text,
                                borderColor: Colors.grey.shade300,
                                borderRadius: 10,
                                contentPaddingHorizontal: 14.w,
                                contentPaddingVertical: 12.h,
                                filColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // ===== Packages =====
                Text(
                  'Packages',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 8.h),
                Obx(
                      () => DropdownButtonFormField<String>(
                    value: controller.selectedPackage.value,
                    hint: Text(
                      'Select Package',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black38,
                      ),
                    ),
                    items: controller.packages
                        .map((package) => DropdownMenuItem(
                      value: package,
                      child: Text(
                        package,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ))
                        .toList(),
                    onChanged: (val) => controller.selectedPackage.value = val,
                    validator: controller.validatePackage,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 12.h,
                      ),
                      filled: true,
                      fillColor: Colors.white,
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
                SizedBox(height: 30.h),

                // ===== Next Button =====
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.goToNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
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
        'Open House Services',
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