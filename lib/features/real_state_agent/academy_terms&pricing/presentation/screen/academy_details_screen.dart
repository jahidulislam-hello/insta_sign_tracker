import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../../data/course_model.dart';
import '../controller/academy_controller.dart';

class AcademyDetailsScreen extends GetView<AcademyController> {
  const AcademyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Obx(
            () {
          final course = controller.getSelectedCourse();
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ===== VIDEO SECTION =====
                _buildVideoSection(course),

                // ===== CONTENT SECTION =====
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    course.fullDescription ?? '',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ===================== AppBar =====================
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Get.back(),
      ),
      title: const Text(
        'Topic-1: Base Layouts',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  // ===================== VIDEO SECTION =====================
  Widget _buildVideoSection(CourseModel course) {
    return Container(
      height: 300,
      width: double.infinity,
      color: Colors.grey[300],
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Video Thumbnail
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey[400],
            child: const Icon(
              Icons.play_circle_filled,
              size: 80,
              color: Colors.white,
            ),
          ),

          // Play Button
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.9),
            ),
            child: const Icon(
              Icons.play_arrow,
              size: 50,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}