import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import 'package:insta_sign_tracker/features/Authentication/presentation/controller/auth_controller.dart';
import '../../../../core/utils/widget/customeTextField/custom_text_field.dart';
import '../widget/auth_button.dart';

class ResetPassScreen extends GetView<AuthController> {
  const ResetPassScreen({super.key});

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
                SizedBox(height: 150.h),

                CustomTextField(
                  controller:controller.resetPassPasswordController,
                  hintText: 'password',
                  isPassword: true,
                  prefixIcon: const Icon(Icons.lock_outline, color: Colors.blue),
                  borderColor: Colors.grey[300],
                  hinTextColor: Colors.grey[600],
                  filColor: Colors.grey[50],
                ),

                CustomTextField(
                  controller:controller.resetPassConfirmPasswordController,
                  hintText: 'conform password',
                  isPassword: true,
                  prefixIcon: const Icon(Icons.lock_outline, color: Colors.blue),
                  borderColor: Colors.grey[300],
                  hinTextColor: Colors.grey[600],
                  filColor: Colors.grey[50],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != controller.resetPassConfirmPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),


                SizedBox(height: 30.h),

                GetBuilder<AuthController>(builder:(controller){
                  return AuthButton(
                    buttonText: 'Reset',
                    isLoading: controller.loginIsLoading,
                    onPressed:(){
                      if(formKey.currentState!.validate()){
                        controller.resetPass();
                      }
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}