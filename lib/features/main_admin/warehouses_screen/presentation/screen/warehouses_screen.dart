import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
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
        backgroundColor: AppColors.appBarColor,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.white, size: 22.sp),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(
          'Warehouses',
          style: GoogleFonts.montserrat(
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
      color:AppColors.appBarColor,
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
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text:
                  '(${controller.warehouses.length.toString().padLeft(2, '0')})',
                  style: GoogleFonts.montserrat(
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
              style: GoogleFonts.montserrat(
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
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(width: 0.2,color: Colors.grey),
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
                color: Color(0xFFE8F2FF),
                borderRadius: BorderRadius.circular(32.r),
              ),
              child: Icon(
                Icons.store_outlined,
                color:Color(0xFF00628B),
                size: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    warehouse.name,
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    warehouse.location,
                    style: GoogleFonts.montserrat(
                      fontSize: 13.sp,
                      color: Colors.black.withValues(alpha: 0.8),
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
      padding: EdgeInsets.zero,
      color: Colors.white,
      elevation: 4,
      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      onSelected: (value) {
        if (value == 'edit') {
          controller.openEditDialog(warehouse);
        } else if (value == 'delete') {
          controller.openDeleteDialog(warehouse);
        }
      },
      itemBuilder: (_) => [
        PopupMenuItem<String>(
          value: 'edit',
          padding: EdgeInsets.zero,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 10.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.appBarColor,
              borderRadius: BorderRadius.circular(0.r),
            ),
            child: Text(
              'Edit',
              style: GoogleFonts.montserrat(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),

        PopupMenuItem<String>(
          value: 'delete',
          padding: EdgeInsets.zero,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 10.h,
            ),
            decoration: BoxDecoration(
              color: Color(0xFFFFF4E6),
              borderRadius: BorderRadius.circular(0.r),
            ),
            child: Text(
              'Delete',
              style: GoogleFonts.montserrat(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }
}