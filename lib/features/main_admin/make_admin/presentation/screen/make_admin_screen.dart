// make_admin_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../../../dashboard_and_user_management/presentation/widget/admin_app_drawer_widget.dart';
import '../../data/model/make_admin_model.dart';
import '../controller/make_admin_controller.dart';

class MakeAdminScreen extends GetView<MakeAdminController> {
  const MakeAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FA),
      drawer: AdminAppDrawerWidget(),
      appBar: AppBar(
        backgroundColor:AppColors.appBarColor,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.white, size: 22.sp),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(
          'All Admin',
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
          Expanded(child: _buildAdminList()),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: AppColors.appBarColor,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      child: TextField(
        style: TextStyle(fontSize: 14.sp),
        decoration: InputDecoration(
          hintText: 'Search by order ID or address...',
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14.sp),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
          EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none,
          ),
        ),
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
                  text: 'All Admin ',
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text:
                  '(${controller.admins.length.toString().padLeft(2, '0')})',
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue,
                  ),
                ),
              ],
            ),
          )),
          ElevatedButton(
            onPressed: controller.openAddDialog,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            child: Text(
              '+ Add Admin',
              style: GoogleFonts.montserrat(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdminList() {
    return Obx(() {
      if (controller.admins.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.admin_panel_settings_outlined,
                  size: 60.sp, color: Colors.grey.shade300),
              SizedBox(height: 12.h),
              Text(
                'No admins yet',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
        );
      }
      return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
        itemCount: controller.admins.length,
        separatorBuilder: (_, __) => SizedBox(height: 10.h),
        itemBuilder: (context, index) =>
            _buildAdminCard(controller.admins[index]),
      );
    });
  }

  Widget _buildAdminCard(MakeAdminModel admin) {
    return Container(
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
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage:NetworkImage("https://www.shutterstock.com/shutterstock/videos/1009381796/thumb/2.jpg?ip=x480"),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      admin.name,
                      style: GoogleFonts.montserrat(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      admin.email,
                      style: GoogleFonts.montserrat(
                        fontSize: 13.sp,
                        color: Colors.black.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6.w,
                      height: 6.w,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Active',
                      style: GoogleFonts.montserrat(
                        fontSize: 12.sp,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(height: 20.h, color: Colors.grey,thickness: 0.5,),
          Row(
            children: [
              GestureDetector(
                onTap: () => controller.openDeleteDialog(admin),
                child: Icon(Icons.delete_outline,
                    color: Colors.red.shade300, size: 22.sp),
              ),
              SizedBox(width: 16.w),
              GestureDetector(
                onTap: () => controller.openEditDialog(admin),
                child: Icon(Icons.mode_edit_outline_rounded,
                    color: Colors.lightBlue, size: 22.sp),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Icon(Icons.send,
                        color: Colors.lightBlue, size: 18.sp),
                    SizedBox(width: 4.w),
                    Text(
                      'View Details',
                      style: GoogleFonts.montserrat(
                        fontSize: 13.sp,
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}