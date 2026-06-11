import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/course_model.dart';

class AcademyController extends GetxController {
  RxInt selectedCourseIndex = 0.obs;
  late List<CourseModel> courses;
  final academyController =TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _initializeCourses();
  }

  void _initializeCourses() {
    courses = [
      CourseModel(
        id: '1',
        title: 'Topic-1: Base Layouts',
        description: 'Master the fundamentals of architectural signage positioning',
        status: 'Active',
        videoThumbnail: 'asset/images/real_state_agent/academy/video_1.png',
        fullDescription:
        'Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting.\n\nLorem ipsum is simply dummy text of the printing and typesetting industry. Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
      ),
      CourseModel(
        id: '2',
        title: 'Order-2: OSHA Protocols',
        description: 'Master the fundamentals of architectural signage positioning',
        status: 'Pending',
        videoThumbnail: 'asset/images/real_state_agent/academy/video_2.png',
        fullDescription:
        'OSHA Protocol course content with detailed information about workplace safety and signage requirements.',
      ),
      CourseModel(
        id: '3',
        title: 'Brand Identity 101',
        description: 'Master the fundamentals of architectural signage positioning',
        status: 'New',
        videoThumbnail: 'asset/images/real_state_agent/academy/video_3.png',
        fullDescription:
        'Learn about brand identity, logo design, and visual consistency in this comprehensive course.',
      ),
    ];
  }

  void selectCourse(int index) {
    selectedCourseIndex.value = index;
  }

  CourseModel getSelectedCourse() {
    return courses[selectedCourseIndex.value];
  }
}