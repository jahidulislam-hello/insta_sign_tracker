import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/routes/app_routes.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(AppRoutes.onboardingScreen);
    });

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColors.blue50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: height*0.3,),
            Image.asset("asset/images/logo.png", height: 100),
            SizedBox(height: height*0.2,),
            // Circular Progress Indicator
            CircularProgressIndicator(
              color:AppColors.loadingColor,
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