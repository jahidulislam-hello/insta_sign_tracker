import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/routes/app_routes.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import 'package:insta_sign_tracker/features/Authentication/presentation/controller/auth_controller.dart';
import '../../../../core/utils/widget/customeTextField/custom_text_field.dart';
import '../widget/auth_button.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
       return Scaffold(
        backgroundColor: AppColors.onboardingColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(right: 20.w,left:20.w ,bottom: 20.h,top: 50.h),
            child: Form(
              key:formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentGeometry.topLeft,
                    child:IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () => Get.back(),
                    ),
                  ),
                  // Logo
                  Image.asset(
                    'asset/images/logo.png',
                  ),
                  SizedBox(height: 50.h),

                  // Email field
                  CustomTextField(
                    controller:controller.loginEmailController,
                    hintText: 'Enter your email',
                    labelText: 'Email',
                    isEmail: true,
                    prefixIcon: const Icon(Icons.email_outlined, color: Colors.blue),
                    borderColor: Colors.grey[300],
                    hinTextColor: Colors.grey[600],
                    filColor: Colors.grey[50],
                    keyboardType: TextInputType.emailAddress,
                  ),

                  // Password field
                  CustomTextField(
                    controller:controller.loginPasswordController,
                    hintText: 'Enter your password',
                    labelText: 'Password',
                    isPassword: true,
                    prefixIcon: const Icon(Icons.lock_outline, color: Colors.blue),
                    borderColor: Colors.grey[300],
                    hinTextColor: Colors.grey[600],
                    filColor: Colors.grey[50],
                  ),

                  // Forgot password link
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                       Get.toNamed(AppRoutes.enterEmailScreen);
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30.h),

                  GetBuilder<AuthController>(builder:(controller){
                    return AuthButton(
                      buttonText: 'Log In',
                      isLoading: controller.loginIsLoading,
                      onPressed:(){
                        if(formKey.currentState!.validate()){
                          controller.loginId();
                        }
                      },
                    );
                  }),


                  SizedBox(height: 20.h),

                  // Continue with
                  Text(
                    'Or continue with',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 15.h),

                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: IconButton(
                      icon: Image.asset('asset/images/google.png',),
                      onPressed: () {
                        // Google login logic
                      },
                    ),
                  ),

                  SizedBox(height: 70.h),

                  // Don't have account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account? ',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.signup),
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}