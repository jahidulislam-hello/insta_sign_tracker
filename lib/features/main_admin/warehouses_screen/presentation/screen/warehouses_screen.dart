import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../dashboard_and_user_management/presentation/widget/admin_app_drawer_widget.dart';
import '../../data/model/warehouse_model.dart';
import '../controller/warehouses_controller.dart';
import '../../../../../core/utils/widget/customeTextField/custom_text_field.dart';

class WarehousesScreen extends GetView<WarehousesController> {
  const WarehousesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FA),
      drawer:  AdminAppDrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.white, size: 22.sp),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(
          'Warehouses',
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.white,
                  size: 24.sp,
                ),
                Positioned(
                  top: 6.h,
                  right: 0,
                  child: Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildTotalRow(),
          Expanded(child: _buildWarehouseList()),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: Colors.lightBlue,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      child: CustomTextField(
        controller: TextEditingController(),
        hintText: 'Search warehouses...',
        prefixIcon: const Icon(Icons.search),
        filColor: Colors.white,
        isvalidation: false,
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
                  '(${controller.warehouses.length.toString().padLeft(2, '0')})',
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
            onPressed: controller.openAddDialog,
            label: Text(
              '+ Add Warehouse',
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

  Widget _buildWarehouseList() {
    return Obx(() => ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
      itemCount: controller.warehouses.length,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (context, index) =>
          _buildWarehouseCard(controller.warehouses[index]),
    ));
  }

  Widget _buildWarehouseCard(WarehouseModel warehouse) {
    return GestureDetector(
      onTap: () => controller.openDetailsPage(warehouse),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
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
                color: Colors.lightBlue.withValues(alpha: 0.12),
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
                    warehouse.name,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    warehouse.location,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            _buildPopupMenu(warehouse),
          ],
        ),
      ),
    );
  }

  Widget _buildPopupMenu(WarehouseModel warehouse) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, color: Colors.grey.shade600, size: 22.sp),
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      onSelected: (value) {
        if (value == 'edit') {
          controller.openEditDialog(warehouse);
        } else if (value == 'delete') {
          controller.openDeleteDialog(warehouse);
        }
      },
      itemBuilder: (_) => [
        PopupMenuItem(
          value: 'edit',
          child: Text(
            'Edit',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.lightBlue,
            ),
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Text(
            'Delete',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}