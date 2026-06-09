import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/onboarding_controller.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView - Carousel Slider
          PageView.builder(
            controller: controller.pageController,
            physics: const AlwaysScrollableScrollPhysics(),
            onPageChanged: (index) {
              print('📄 Page changed to: $index');
              controller.currentPage.value = index;
            },
            itemCount: controller.slides.length,
            itemBuilder: (context, index) {
              final slide = controller.slides[index];
              return Column(
                children: [
                  SizedBox(height: 50.h),
                  // Top right এ Skip button - Last page এ hide করবো
                  if (index != controller.slides.length - 1)
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.all(20.w),
                        child: GestureDetector(
                          onTap: () {
                            print('🔘 Skip tapped');
                            controller.skipOnboarding();
                          },
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    SizedBox(height: 60.h), // Last page এ space দিচ্ছি

                  SizedBox(height: 10.h),

                  // Icon/Image circle
                  Container(
                    height: 100.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                        ),
                      ],
                    ),
                    child: Icon(
                      index == 0
                          ? Icons.location_on_outlined
                          : index == 1
                          ? Icons.check_circle
                          : Icons.calendar_today,
                      size: 65.sp,
                      color: Colors.blue,
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      slide.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Image
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    height: 280.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      image: DecorationImage(
                        image: AssetImage(slide.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // Description - 3 lines, black color
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      slide.description,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ),

                  SizedBox(height: 30.h),
                ],
              );
            },
          ),

          // Bottom section - Dots + Next Button
          Positioned(
            bottom: 30.h,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Dots Indicator
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      controller.slides.length,
                          (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        height: 8.h,
                        width: controller.currentPage.value == index ? 24.w : 8.w,
                        decoration: BoxDecoration(
                          color: controller.currentPage.value == index
                              ? Colors.blue
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  );
                }),

                SizedBox(height: 30.h),

                // Next Button / Start Using App Button
                Obx(() {
                  print('Obx rebuild: currentPage = ${controller.currentPage.value}');
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: controller.currentPage.value ==
                        controller.slides.length - 1
                        ? // Last screen - Start Using App button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          print('✅ Start Using App tapped');
                          controller.skipOnboarding();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Start Using App',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                        : // Other screens - Next button
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          print('➡️ Next button tapped at page ${controller.currentPage.value}');
                          controller.nextPage();
                        },
                        child: Container(
                          height: 56.h,
                          width: 56.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}