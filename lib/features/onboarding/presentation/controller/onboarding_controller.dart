import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/routes/app_routes.dart';

class OnboardingController extends GetxController {
  late PageController pageController;
  var currentPage = 0.obs;

  final List<OnboardingData> slides = [
    OnboardingData(
      image: 'asset/images/onboarding/man.png',
      title: 'Navigate to Any Job Site',
      description: 'Get turn-by-turn directions to every installation location. GPS-powered routing keeps you on track.',
    ),
    OnboardingData(
      image: 'asset/images/onboarding/blackMan.png',
      title: 'Complete Jobs Faster',
      description: 'Check off tasks, capture photos, and submit reports directly from the field. No more paperwork.',
    ),
    OnboardingData(
      image: 'asset/images/onboarding/sky.png',
      title: 'Manage Your Schedule',
      description: 'View all assignments, track completed work, and sync with your calendar. Stay organized on every job.',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
    print('OnboardingController initialized');
  }

  void nextPage() {
    print('Next button tapped. Current page: ${currentPage.value}');

    if (currentPage.value < slides.length - 1) {
      print('Moving to next page...');
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      print('Last page - navigating to home');
      skipOnboarding();
    }
  }

  void skipOnboarding() {
    print('Skip pressed - going to home');
    Get.offNamed(AppRoutes.selectRole); // আপনার home route দিন
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class OnboardingData {
  final String image;
  final String title;
  final String description;

  OnboardingData({
    required this.image,
    required this.title,
    required this.description,
  });
}