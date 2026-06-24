// make_admin_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/utils/widget/customeTextField/custom_text_field.dart';
import '../controller/make_admin_controller.dart';

class MakeAdminWidget extends StatelessWidget {
  const MakeAdminWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MakeAdminController>();

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.h),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Obx(() => Text(
                      controller.isEditing.value
                          ? 'Edit Admin'
                          : 'Add Admin',
                      style: GoogleFonts.montserrat(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )),
                  ),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    controller: controller.nameController,
                    hintText: 'Name',
                    labelText: 'Name',
                    isvalidation: false,
                    filColor: Colors.white,
                    borderColor: Colors.blue.shade200,
                  ),
                  CustomTextField(
                    controller: controller.emailController,
                    hintText: 'Email',
                    labelText: 'Email',
                    isvalidation: false,
                    filColor: Colors.white,
                    borderColor: Colors.blue.shade200,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  CustomTextField(
                    controller: controller.passwordController,
                    hintText: 'Password',
                    labelText: 'Password',
                    isvalidation: false,
                    isPassword: true,
                    filColor: Colors.white,
                    borderColor: Colors.blue.shade200,
                  ),
                  _buildLabel('User type'),
                  SizedBox(height: 6.h),
                  _buildReadonlyField('Admin'),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Access Permission',
                        style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          'Custom',
                          style: GoogleFonts.montserrat(
                            fontSize: 12.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Obx(() => _buildPermissionTile(
                    icon: Icons.account_balance_wallet_outlined,
                    label: 'Financial',
                    value: controller.financialAccess.value,
                    onChanged: (v) => controller.financialAccess.value = v,
                  )),
                  SizedBox(height: 8.h),
                  Obx(() => _buildPermissionTile(
                    icon: Icons.group_outlined,
                    label: 'User Management',
                    value: controller.userManagementAccess.value,
                    onChanged: (v) =>
                    controller.userManagementAccess.value = v,
                  )),
                  SizedBox(height: 8.h),
                  Obx(() => _buildPermissionTile(
                    icon: Icons.shopping_cart_outlined,
                    label: 'Order Management',
                    value: controller.orderManagementAccess.value,
                    onChanged: (v) =>
                    controller.orderManagementAccess.value = v,
                  )),
                  SizedBox(height: 8.h),
                  Obx(() => _buildPermissionTile(
                    icon: Icons.inventory_2_outlined,
                    label: 'Inventory Management',
                    value: controller.inventoryManagementAccess.value,
                    onChanged: (v) =>
                    controller.inventoryManagementAccess.value = v,
                  )),
                  SizedBox(height: 8.h),
                  Obx(() => _buildPermissionTile(
                    icon: Icons.price_change_outlined,
                    label: 'Items & Pricing',
                    value: controller.itemsAndPricingAccess.value,
                    onChanged: (v) =>
                    controller.itemsAndPricingAccess.value = v,
                  )),
                  SizedBox(height: 8.h),
                  Obx(() => _buildPermissionTile(
                    icon: Icons.warehouse_outlined,
                    label: 'Manage Warehouse',
                    value: controller.manageWarehouseAccess.value,
                    onChanged: (v) =>
                    controller.manageWarehouseAccess.value = v,
                  )),
                  SizedBox(height: 8.h),
                  Obx(() => _buildPermissionTile(
                    icon: Icons.campaign_outlined,
                    label: 'Announcement',
                    value: controller.announcementAccess.value,
                    onChanged: (v) =>
                    controller.announcementAccess.value = v,
                  )),
                  SizedBox(height: 8.h),
                  Obx(() => _buildPermissionTile(
                    icon: Icons.settings_outlined,
                    label: 'Settings',
                    value: controller.settingsAccess.value,
                    onChanged: (v) => controller.settingsAccess.value = v,
                  )),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Get.back(),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            side: BorderSide(color: Colors.red.shade200),
                            backgroundColor: Colors.red.shade50,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            'Close',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: controller.submitDialog,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            backgroundColor: Colors.lightBlue,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Obx(() => Text(
                            controller.isEditing.value
                                ? 'Save Changes'
                                : 'Add',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -14,
            right: -14,
            child: GestureDetector(
              onTap: () {
                _clearControllerFields(controller);
                Get.back();
              },
              child: Container(
                width: 30.w,
                height: 30.w,
                decoration: const BoxDecoration(
                  color: Colors.lightBlue,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: Colors.white, size: 16.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _clearControllerFields(MakeAdminController controller) {
    controller.nameController.clear();
    controller.emailController.clear();
    controller.passwordController.clear();
    controller.financialAccess.value = false;
    controller.userManagementAccess.value = false;
    controller.orderManagementAccess.value = false;
    controller.inventoryManagementAccess.value = false;
    controller.itemsAndPricingAccess.value = false;
    controller.manageWarehouseAccess.value = false;
    controller.announcementAccess.value = false;
    controller.settingsAccess.value = false;
    controller.editingAdmin = null;
    controller.isEditing.value = false;
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.h,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }

  Widget _buildReadonlyField(String value) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.shade200),
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
      ),
      child: Text(
        value,
        style: TextStyle(fontSize: 12.sp, color: Colors.black),
      ),
    );
  }

  Widget _buildPermissionTile({
    required IconData icon,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.lightBlue, size: 20.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.lightBlue,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.lightBlue,
          ),
        ],
      ),
    );
  }
}