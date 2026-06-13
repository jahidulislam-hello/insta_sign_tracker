import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controller/other_service_controller.dart';
import '../../../../../../core/utils/widget/customeTextField/custom_text_field.dart';

class OtherServiceScreen extends GetView<OtherServiceController> {
  const OtherServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Other Services'),
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
                // ===== Tab Section =====
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.all(4.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Obx(
                              () => GestureDetector(
                            onTap: () {
                              controller.selectedTab.value = 0;
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              decoration: BoxDecoration(
                                color: controller.selectedTab.value == 0
                                    ? Colors.grey[300]
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Center(
                                child: Text(
                                  'Current Install',
                                  style: TextStyle(
                                    fontSize: 13.h,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Obx(
                              () => GestureDetector(
                            onTap: () {
                              controller.selectedTab.value = 1;
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              decoration: BoxDecoration(
                                color: controller.selectedTab.value == 1
                                    ? Colors.blue
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Center(
                                child: Text(
                                  'New Service',
                                  style: TextStyle(
                                    fontSize: 13.h,
                                    fontWeight: FontWeight.w600,
                                    color: controller.selectedTab.value == 1
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                // ===== Sign Install Search =====
                CustomTextField(
                  controller: controller.signInstallController,
                  hintText: 'Search Select Current Install',
                  labelText: 'Sign Install',
                  borderColor: Colors.black,
                  suffixIcon: Icon(Icons.search, size: 20),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select sign install';
                    }
                    return null;
                  },
                ),

                // ===== Due Date =====
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

                // ===== Order (ASAP / Rush Order) =====
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

                // ===== Notes =====
                CustomTextField(
                  controller: controller.notesController,
                  hintText: 'Type notes here',
                  labelText: 'Notes',
                  maxLine: 2,
                  borderColor: Colors.black,
                ),

                // ===== Upload Image =====
                // ImageUploadWidget(
                //   label: 'Upload Image',
                //   hintText: 'Upload Image',
                //   allowMultiple: false,
                // ),

                // ===== Select Services =====
                Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Services',
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
                          value:
                          controller.undergroundSprinkler.value,
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
                          value: controller.restrictedGatedAccess1.value,
                          onChanged: (value) {
                            controller.restrictedGatedAccess1.value =
                                value ?? false;
                          },
                          title: Text(
                            'Restricted/gated access',
                            style: TextStyle(fontSize: 13.h),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Obx(
                            () => CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          value: controller.invisibleDogFence1.value,
                          onChanged: (value) {
                            controller.invisibleDogFence1.value =
                                value ?? false;
                          },
                          title: Text(
                            'Invisible dog fence',
                            style: TextStyle(fontSize: 13.h),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Obx(
                            () => CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          value: controller.undergroundWaterSystem.value,
                          onChanged: (value) {
                            controller.undergroundWaterSystem.value =
                                value ?? false;
                          },
                          title: Text(
                            'Underground water system',
                            style: TextStyle(fontSize: 13.h),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Obx(
                            () => CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          value: controller.restrictedGatedAccess2.value,
                          onChanged: (value) {
                            controller.restrictedGatedAccess2.value =
                                value ?? false;
                          },
                          title: Text(
                            'Restricted/gated access',
                            style: TextStyle(fontSize: 13.h),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Obx(
                            () => CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          value: controller.invisibleDogFence2.value,
                          onChanged: (value) {
                            controller.invisibleDogFence2.value =
                                value ?? false;
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

                // ===== Review Order Section =====
                Text(
                  'Review Order',
                  style: TextStyle(
                    fontSize: 16.h,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    letterSpacing: 0.5,
                  ),
                ),

                SizedBox(height: 12.h),

                // Price Breakdown
                Text(
                  'Price Breakdown',
                  style: TextStyle(
                    fontSize: 14.h,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 8.h),

                // Price items
                _buildPriceRow(
                  label: 'Post Install',
                  price: controller.postInstallPrice,
                ),

                Divider(
                  height: 12.h,
                  thickness: 1,
                  color: Colors.grey[200],
                ),

                _buildPriceRow(
                  label: 'Credit Card Fee',
                  price: controller.creditCardFeePrice,
                ),

                Divider(
                  height: 12.h,
                  thickness: 1,
                  color: Colors.grey[200],
                ),

                _buildPriceRow(
                  label: 'Others Fee',
                  price: controller.othersPrice,
                ),

                SizedBox(height: 16.h),

                // Total Price
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: Colors.blue.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Price',
                        style: TextStyle(
                          fontSize: 14.h,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Obx(
                            () => Text(
                          '\$ ${controller.totalPrice.value.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16.h,
                            fontWeight: FontWeight.w700,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                // Place Order Button
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
                      elevation: 4,
                    ),
                    child: Text(
                      'Place Order',
                      style: TextStyle(
                        fontSize: 16.h,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
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

  // Helper widget - Price row
  Widget _buildPriceRow({
    required String label,
    required RxDouble price,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13.h,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          Obx(
                () => Text(
              '\$ ${price.value.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 13.h,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}