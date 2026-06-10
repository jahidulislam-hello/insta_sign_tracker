import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/routes/app_routes.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import 'package:insta_sign_tracker/features/Authentication/presentation/controller/auth_controller.dart';
import '../../../../core/utils/widget/customeTextField/custom_text_field.dart';
import '../widget/auth_button.dart';

class SignUpScreen extends GetView<AuthController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
      return Scaffold(
        backgroundColor: AppColors.onboardingColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(right: 20.w,left:20.w ,bottom: 20.h,top: 50.h),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentGeometry.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () => Get.back(),
                    ),
                  ),
                  // Logo
                  Image.asset(
                    'asset/images/logo.png',
                  ),

                   SizedBox(height: 30.h),

                  // Name field
                  CustomTextField(
                    controller: controller.singUpNameController,
                    hintText: 'Enter your name',
                    labelText: 'Name',
                    prefixIcon: const Icon(Icons.person_outline, color: Colors.blue),
                    borderColor: Colors.grey[300],
                    hinTextColor: Colors.grey[600],
                    filColor: Colors.grey[50],
                    keyboardType: TextInputType.name,
                  ),

                  // Phone field
                  CustomTextField(
                    controller:controller.singUpPhoneController,
                    hintText: 'Enter your phone number',
                    labelText: 'Phone Number',
                    prefixIcon: const Icon(Icons.phone_outlined, color: Colors.blue),
                    borderColor: Colors.grey[300],
                    hinTextColor: Colors.grey[600],
                    filColor: Colors.grey[50],
                    keyboardType: TextInputType.phone,
                  ),

                  // Email field
                  CustomTextField(
                    controller:controller.singUpEmailController,
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
                    controller:controller.singUpPasswordController,
                    hintText: 'Enter your password',
                    labelText: 'Password',
                    isPassword: true,
                    prefixIcon: const Icon(Icons.lock_outline, color: Colors.blue),
                    borderColor: Colors.grey[300],
                    hinTextColor: Colors.grey[600],
                    filColor: Colors.grey[50],
                  ),

                  // Confirm Password field
                  CustomTextField(
                    controller:controller.singUpConfirmPasswordController,
                    hintText: 'Confirm your password',
                    labelText: 'Confirm Password',
                    isPassword: true,
                    prefixIcon: const Icon(Icons.lock_outline, color: Colors.blue),
                    borderColor: Colors.grey[300],
                    hinTextColor: Colors.grey[600],
                    filColor: Colors.grey[50],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != controller.singUpPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 30.h),

                  // Sign Up button
                  GetBuilder<AuthController>(builder: (controller){
                    return AuthButton(
                      buttonText: 'Sign Up',
                      isLoading: controller.isLoading,
                      onPressed:(){
                        if(formkey.currentState!.validate()){
                          controller.singUpId();
                        }
                      },
                    );
                  }),
                  SizedBox(height: 10.h),
                  Text(
                    'Or continue with',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 10.h),

                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(30.r),
                      color: Colors.white
                    ),
                    child: IconButton(
                      icon: Image.asset('asset/images/google.png'),
                      onPressed: () {
                        // Google sign up logic
                      },
                    ),
                  ),

                  SizedBox(height: 10.h),

                  // Already have account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.offNamed(AppRoutes.login),
                        child: Text(
                          'Log In',
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