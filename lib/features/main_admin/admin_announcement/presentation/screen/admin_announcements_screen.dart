// admin_announcements_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../../../dashboard_and_user_management/presentation/widget/admin_app_drawer_widget.dart';
import '../../data/model/announcement_model.dart';
import '../controller/admin_announcements_controller.dart';

class AdminAnnouncementsScreen extends GetView<AdminAnnouncementsController> {
  const AdminAnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          'Announcements',
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
          _buildSubHeader(),
          Divider(
            color: Colors.grey.withValues(alpha: 0.7),
            thickness: 0.8,
            height: 1,
          ),
          Expanded(child: _buildBody()),
        ],
      ),
      bottomNavigationBar: _buildBottomCreateButton(),
    );
  }

  Widget _buildSubHeader() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 16,
        left: 20.w,
        right: 20.w,
        bottom: 10.h,
      ),
      child: Text(
        'Send Updates And Important Notices To All\nUsers Under Your Company.',
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          fontSize: 14.sp,
          color: Colors.black.withValues(alpha: 0.9),
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Obx(() {
      if (controller.announcements.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.campaign_outlined,
                size: 60.sp,
                color: Colors.grey.shade300,
              ),
              SizedBox(height: 12.h),
              Text(
                'No announcements yet',
                style: GoogleFonts.montserrat(
                  fontSize: 15.sp,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
        );
      }

      final grouped = controller.groupedAnnouncements;
      final keys = grouped.keys.toList();

      final List<Widget> allItems = [];

      for (int groupIndex = 0; groupIndex < keys.length; groupIndex++) {
        final dateKey = keys[groupIndex];
        final items = grouped[dateKey]!;
        final isFirst = groupIndex == 0;

        if (groupIndex > 0) {
          allItems.add(SizedBox(height: 14.h));
        }

        allItems.add(
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Text(
              isFirst ? 'Recent Announcements' : dateKey,
              style: GoogleFonts.montserrat(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        );

        for (int i = 0; i < items.length; i++) {
          final isLast = i == items.length - 1;
          allItems.add(
            Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 10.h),
              child: _buildAnnouncementCard(items[i]),
            ),
          );
        }
      }

      return ListView(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        children: allItems,
      );
    });
  }

  Widget _buildAnnouncementCard(AnnouncementModel announcement) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFCEE5FF),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.campaign,
                  color: const Color(0xFF00628B),
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      announcement.title,
                      style: GoogleFonts.montserrat(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      announcement.message,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        fontSize: 13.sp,
                        color: Colors.black,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(height: 20.h, color: Colors.grey, thickness: 0.5),
          Row(
            children: [
              GestureDetector(
                onTap: () => controller.openDeleteDialog(announcement),
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.red.shade300,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 16.w),
              GestureDetector(
                onTap: () => controller.openEditDialog(announcement),
                child: Icon(
                  Icons.mode_edit_outline_rounded,
                  color: Colors.lightBlue,
                  size: 22.sp,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Icon(Icons.send, color: Colors.lightBlue, size: 18.sp),
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

  Widget _buildBottomCreateButton() {
    return Container(
      color: const Color(0xFFF0F4FA),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: ElevatedButton(
        onPressed: controller.openAddDialog,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightBlue,
          elevation: 0,
          minimumSize: Size(double.infinity, 50.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          '+ Create Announcement',
          style: GoogleFonts.montserrat(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}