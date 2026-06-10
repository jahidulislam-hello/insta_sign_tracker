import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import 'package:insta_sign_tracker/features/Authentication/presentation/controller/auth_controller.dart';

class OtpVerifyScreen extends GetView<AuthController> {
  const OtpVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(right: 20.w,left:20.w ,bottom: 20.h,top: 50.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Back button
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => Get.back(),
                ),
              ),

              // Logo
              Image.asset(
                'asset/images/logo.png',
                height: 100.h,
              ),

              SizedBox(height: 40.h),

              // Title
              Text(
                "Enter verification Code",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: 12.h),

              // Subtitle
              Text(
                "Please enter the 6-digit verification\ncode sent to your email",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),

              SizedBox(height: 50.h),

              // Pinput
              Pinput(
                length: 6,
                controller: controller.otpController,

                defaultPinTheme: PinTheme(
                  width: 50.w,
                  height: 50.h,
                  textStyle: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),

                focusedPinTheme: PinTheme(
                  width: 50.w,
                  height: 50.h,
                  textStyle: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),

                submittedPinTheme: PinTheme(
                  width: 50.w,
                  height: 50.h,
                  textStyle: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.blue.withValues(alpha: 0.1),
                  ),
                ),

                onCompleted: (pin) {
                  print('OTP completed: $pin');
                  Future.delayed(const Duration(milliseconds: 300), () {
                    controller.verifyOtp();
                  });
                },
                onChanged: (value) {
                  print('OTP changed: $value');
                },

                showCursor: true,
              ),

              SizedBox(height: 40.h),

              // Resend Code - ছবির মতো একই row এ
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.resendCountdown.value > 0
                          ? 'You can request a new code in ${controller.resendCountdown.value}s'
                          : 'Didn\'t receive the code?',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.resendCountdown.value > 0
                          ? null
                          : controller.resentOtp,
                      child: Text(
                        'Resend Code',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: controller.resendCountdown.value > 0
                              ? Colors.grey[400]
                              : Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                );
              }),

              SizedBox(height: 40.h),

              // Verify Button
              GetBuilder<AuthController>(
                builder: (ctrl) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                      ctrl.verifyOtpIsLoading ? null : ctrl.verifyOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        disabledBackgroundColor: Colors.grey[300],
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: ctrl.verifyOtpIsLoading
                          ? SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                          strokeWidth: 2,
                        ),
                      )
                          : Text(
                        'Verify',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}