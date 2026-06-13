import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controller/review_order_status.dart';

class ReviewOrderScreen extends GetView<ReviewOrderStatus> {
  const ReviewOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Review Order'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== Price Breakdown Section =====
              Text(
                'Price Breakdown',
                style: TextStyle(
                  fontSize: 16.h,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  letterSpacing: 0.5,
                ),
              ),

              SizedBox(height: 16.h),

              // ===== Price Items Container =====
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.grey[200]!,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha:0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  children: [
                    // Post Install
                    _buildPriceRow(
                      label: 'Post Install',
                      price: controller.postInstallPrice,
                    ),

                    Divider(
                      height: 16.h,
                      thickness: 1,
                      color: Colors.grey[200],
                    ),

                    // Credit Card Fee
                    _buildPriceRow(
                      label: 'Credit Card Fee',
                      price: controller.creditCardFeePrice,
                    ),

                    Divider(
                      height: 16.h,
                      thickness: 1,
                      color: Colors.grey[200],
                    ),

                    // Rush Order Fee
                    _buildPriceRow(
                      label: 'Rush Order Fee',
                      price: controller.rushOrderFeePrice,
                    ),

                    Divider(
                      height: 16.h,
                      thickness: 1,
                      color: Colors.grey[200],
                    ),

                    // Others Fee
                    _buildPriceRow(
                      label: 'Others Fee',
                      price: controller.othersPrice,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // ===== Total Price Section =====
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.blue.withValues(alpha:0.3),
                    width: 1,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Price',
                      style: TextStyle(
                        fontSize: 16.h,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Obx(
                          () => Text(
                        '\$ ${controller.totalPrice.value.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18.h,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 120.h),

              // ===== Submit Order Button =====
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.submitOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    'Submit Order',
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

  // ===== Helper Widget - Price Row =====
  Widget _buildPriceRow({
    required String label,
    required RxDouble price,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.h,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          Obx(
                () => Text(
              '\$ ${price.value.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 14.h,
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