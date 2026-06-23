import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/widget/customeTextField/custom_text_field.dart';
import '../../data/model/warehouse_model.dart';
import '../controller/warehouses_controller.dart';

class AddWarehouseDialog extends GetView<WarehousesController> {
  final WarehouseModel? editWarehouse;

  const AddWarehouseDialog({super.key, this.editWarehouse});

  bool get isEdit => editWarehouse != null;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 20.h),
            _buildNameField(),
            _buildLocationField(),
            SizedBox(height: 8.h),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          isEdit ? 'Edit Warehouse' : 'Add Warehouse',
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.close, color: Colors.white, size: 18.sp),
          ),
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return CustomTextField(
      controller: controller.nameController,
      labelText: 'Name',
      hintText: 'Type here...',
      borderColor: Colors.grey.shade300,
      filColor: Colors.white,
      hinTextColor: Colors.black,
      isvalidation: false,
    );
  }

  Widget _buildLocationField() {
    return CustomTextField(
      controller: controller.locationController,
      labelText: 'Location',
      hintText: 'Type here...',
      borderColor: Colors.grey.shade300,
      filColor: Colors.white,
      hinTextColor: Colors.black,
      isvalidation: false,
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFE5E5),
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r)),
            ),
            child: Text('Close',
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: ElevatedButton(
            onPressed: isEdit
                ? () => controller.editWarehouse(editWarehouse!)
                : controller.addWarehouse,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r)),
            ),
            child: Text(isEdit ? 'Update' : 'Add',
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
        ),
      ],
    );
  }
}

class DeleteWarehouseDialog extends StatelessWidget {
  final String name;
  final VoidCallback onDelete;

  const DeleteWarehouseDialog({
    super.key,
    required this.name,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.delete_outline_rounded,
                  color: Colors.red, size: 30.sp),
            ),
            SizedBox(height: 16.h),
            Text('Delete',
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            SizedBox(height: 8.h),
            Text(
              'Are you sure you want to delete "$name"? This action cannot be undone.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13.sp, color: Colors.grey.shade600, height: 1.5),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade100,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: Text('Cancel',
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onDelete,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: Text('Delete',
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AssignStaffDialog extends GetView<WarehousesController> {
  const AssignStaffDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 20.h),
            _buildDropdown(),
            SizedBox(height: 20.h),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Assign Staff',
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.close, color: Colors.white, size: 18.sp),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Staff',
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black),
        ),
        SizedBox(height: 8.h),
        Obx(() => Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<StaffModel>(
              isExpanded: true,
              hint: Text('Select',
                  style: TextStyle(
                      fontSize: 14.sp, color: Colors.grey.shade500)),
              value: controller.selectedStaff.value,
              icon: Icon(Icons.keyboard_arrow_down,
                  color: Colors.grey.shade600),
              items: controller.staffList
                  .map((staff) => DropdownMenuItem<StaffModel>(
                value: staff,
                child: Text(staff.name,
                    style: TextStyle(
                        fontSize: 14.sp, color: Colors.black)),
              ))
                  .toList(),
              onChanged: (val) => controller.selectedStaff.value = val,
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFE5E5),
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r)),
            ),
            child: Text('Close',
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: ElevatedButton(
            onPressed: controller.assignStaff,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r)),
            ),
            child: Text('Assign',
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
        ),
      ],
    );
  }
}