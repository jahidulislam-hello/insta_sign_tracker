import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/routes/app_routes.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // ✅ initState এ Future.delayed() রাখছি (একবারই execute হবে)
    _navigateToOnboarding();
  }

  void _navigateToOnboarding() {
    Future.delayed(
      const Duration(seconds: 3),
          () {
        // ✅ Check করছি context mounted আছে কিনা (memory leak avoid)
        if (mounted) {
          Get.offAllNamed(AppRoutes.onboardingScreen);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColors.blue50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.3),

            Image.asset(
              "asset/images/logo.png",
              height: 100,
            ),

            SizedBox(height: height * 0.2),

            // Circular Progress Indicator
            CircularProgressIndicator(
              color: AppColors.loadingColor,
              backgroundColor: AppColors.grey400,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.loadingColor),
              strokeWidth: 8,
            ),
          ],
        ),
      ),
    );
  }
}