// admin_printing_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import 'package:insta_sign_tracker/core/utils/widget/customeTextField/custom_text_field.dart';
import '../../../dashboard_and_user_management/presentation/widget/admin_app_drawer_widget.dart';
import '../controller/admin_printing_controller.dart';
import '../widget/sign_type_widget.dart';
import '../widget/size_widget.dart';
import '../widget/materials_widget.dart';
import '../widget/options_widget.dart';
import '../widget/delivery_methods_widget.dart';

class AdminPrintingScreen extends GetView<AdminPrintingController> {
  const AdminPrintingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F4FA),
        drawer: AdminAppDrawerWidget(),
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
            'Printing',
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
            SizedBox(height: 10.h,),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                children: [
                  SignTypesWidget(),
                  SizeWidget(),
                  MaterialsWidget(),
                  OptionsWidget(),
                  DeliveryMethodsWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: AppColors.appBarColor,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
      child:CustomTextField(
          controller: controller.searchController,
        prefixIcon: Icon(Icons.search),
        hintText: "Search here...",
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: const Color(0xFFF0F4FA),
      child: TabBar(
        isScrollable: true,
        labelPadding: EdgeInsets.symmetric(horizontal: 8.w),
        indicatorColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        onTap: (index) => controller.currentTabIndex.value = index,
        tabs: [
          _buildTab('Sign Types'),
          _buildTab('Size'),
          _buildTab('Materials'),
          _buildTab('Options'),
          _buildTab('Delivery Methods'),
        ],
      ),
    );
  }

  Widget _buildTab(String label) {
    return Obx(() {
      bool isSelected = false;
      if (label == 'Sign Types') isSelected = controller.currentTabIndex.value == 0;
      if (label == 'Size') isSelected = controller.currentTabIndex.value == 1;
      if (label == 'Materials') isSelected = controller.currentTabIndex.value == 2;
      if (label == 'Options') isSelected = controller.currentTabIndex.value == 3;
      if (label == 'Delivery Methods') isSelected = controller.currentTabIndex.value == 4;

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.selectedTabColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? AppColors.selectedTabColor : Colors.grey.shade300,
            width: 0.5,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    });
  }
}