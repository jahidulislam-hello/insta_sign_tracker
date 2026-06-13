import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controller/media_controller.dart';

class MediaPlaceOrderScreen extends GetView<MediaController> {
  const MediaPlaceOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Media Services'),
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
              // ImageUploadWidget(
              //   label: 'Upload Image',
              //   hintText: 'Upload Image',
              // ),

              // ===== Photography Package =====
              Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Photography Package',
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
                            .selectedPhotographyPackage.value.isEmpty
                            ? null
                            : controller.selectedPhotographyPackage.value,
                        items: controller.photographyPackages
                            .map((package) => DropdownMenuItem(
                          value: package,
                          child: Text(package),
                        ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.selectedPhotographyPackage.value =
                                value;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Select Package',
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
                      ),
                    ),
                  ],
                ),
              ),

              // ===== Videography Package =====
              Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Videography Package',
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
                            .selectedVideographyPackage.value.isEmpty
                            ? null
                            : controller.selectedVideographyPackage.value,
                        items: controller.videographyPackages
                            .map((package) => DropdownMenuItem(
                          value: package,
                          child: Text(package),
                        ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.selectedVideographyPackage.value =
                                value;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Select Package',
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
                      ),
                    ),
                  ],
                ),
              ),

              // ===== Media Package =====
              Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Media Package',
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
                            .selectedMediaPackage.value.isEmpty
                            ? null
                            : controller.selectedMediaPackage.value,
                        items: controller.mediaPackages
                            .map((package) => DropdownMenuItem(
                          value: package,
                          child: Text(package),
                        ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.selectedMediaPackage.value = value;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Select Package',
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
                      ),
                    ),
                  ],
                ),
              ),

              // ===== Add-On Services =====
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add On Services',
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
                        value: controller.showroomChecked.value,
                        onChanged: (value) {
                          controller.showroomChecked.value = value ?? false;
                        },
                        title: Text(
                          'Show Room',
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
                    color: Colors.blue.withValues(alpha:0.3),
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