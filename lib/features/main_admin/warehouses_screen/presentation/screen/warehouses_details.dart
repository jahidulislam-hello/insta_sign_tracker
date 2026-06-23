import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../data/model/warehouse_model.dart';
import '../controller/warehouses_controller.dart';

class WarehousesDetails extends GetView<WarehousesController> {
  final WarehouseModel warehouse;

  const WarehousesDetails({super.key, required this.warehouse});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios,
              color: Colors.black, size: 20.sp),
        ),
        title: Text(
          warehouse.name,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildTotalRow(),
          Expanded(child: _buildStaffList()),
        ],
      ),
    );
  }

  Widget _buildTotalRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() => RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Total ',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text:
                  '(${controller.staffList.length.toString().padLeft(2, '0')})',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue,
                  ),
                ),
              ],
            ),
          )),
          ElevatedButton.icon(
            onPressed: controller.openAssignStaffDialog,
            icon: Icon(Icons.add, color: Colors.white, size: 18.sp),
            label: Text(
              '+ Assign Staff',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              elevation: 0,
              padding:
              EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffList() {
    return Obx(() => ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
      itemCount: controller.staffList.length,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (context, index) =>
          _buildStaffCard(controller.staffList[index]),
    ));
  }

  Widget _buildStaffCard(StaffModel staff) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: Colors.lightBlue.withValues(alpha:0.12),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.store_outlined,
              color: Colors.lightBlue,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  staff.name,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  staff.role,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => controller.removeStaff(staff),
            child: Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.delete_outline_rounded,
                color: Colors.red,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}