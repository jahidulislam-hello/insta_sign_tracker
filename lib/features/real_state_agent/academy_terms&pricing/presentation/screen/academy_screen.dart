import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import 'package:insta_sign_tracker/core/utils/widget/customeTextField/custom_text_field.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../home/presentation/widget/app_drawer_widget.dart';
import '../../data/course_model.dart';
import '../controller/academy_controller.dart';

class AcademyScreen extends GetView<AcademyController> {
  const AcademyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingColor,
      appBar: _buildAppBar(),
      drawer:const AppDrawerWidget(),
      body: Column(
        children: [
          // ===== SEARCH SECTION =====
          _buildSearchSection(),
          // ===== COURSES LIST =====
          Expanded(
            child: _buildCoursesList(),
          ),
        ],
      ),
    );
  }

  // ===================== AppBar =====================
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primaryBlue,
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: const Text(
        'Academy',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none, color: Colors.white),
        ),
      ],
    );
  }

  // ===================== SEARCH SECTION =====================
  Widget _buildSearchSection() {
    return Container(
      padding: EdgeInsets.symmetric(vertical:12,horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: CustomTextField(
          controller: controller.academyController,
        prefixIcon: Icon(Icons.search),
        hintText: "Search for topics....",
      ),
    );
  }

  // ===================== COURSES LIST =====================
  Widget _buildCoursesList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'Featured Courses (${controller.courses.length})',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),

            // Course Cards
            ...List.generate(
              controller.courses.length,
                  (index) => Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: _buildCourseCard(
                  course: controller.courses[index],
                  index: index,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ===== COURSE CARD =====
  Widget _buildCourseCard({required CourseModel course, required int index}) {
    bool isPending = course.status == 'Pending';

    return GestureDetector(
        onTap: isPending ? null : () {
          controller.selectCourse(index);
          Get.toNamed(AppRoutes.academyDetailsScreen);
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade100,
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      course.title,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  _buildStatusBadge(course.status),
                ],
              ),
              const SizedBox(height: 10),

              // Description
              Text(
                course.description,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withValues(alpha: 0.9),
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 14),

              // Start Learning Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  // ===== DISABLE IF PENDING =====
                  onPressed: isPending
                      ? null
                      : () {
                    controller.selectCourse(index);
                    Get.toNamed(AppRoutes.academyDetailsScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    // ===== COLOR BASED ON STATUS =====
                    backgroundColor:
                    isPending ? Colors.grey[400] : AppColors.primaryBlue,
                    disabledBackgroundColor: Colors.grey[400],
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Start Learning →',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isPending ? Colors.grey[600] : Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

  // ===== STATUS BADGE =====
  Widget _buildStatusBadge(String status) {
    Color badgeColor;
    switch (status) {
      case 'Active':
        badgeColor = AppColors.primaryBlue;
        break;
      case 'Pending':
        badgeColor = Colors.grey[400]!;
        break;
      case 'New':
        badgeColor = const Color(0xFFD32F2F);
        break;
      default:
        badgeColor = Colors.grey[400]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}