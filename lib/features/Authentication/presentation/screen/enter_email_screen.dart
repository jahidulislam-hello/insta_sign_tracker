import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import 'package:insta_sign_tracker/features/Authentication/presentation/controller/auth_controller.dart';
import '../../../../core/utils/widget/customeTextField/custom_text_field.dart';
import '../widget/auth_button.dart';

class EnterEmailScreen extends GetView<AuthController> {
  const EnterEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColors.onboardingColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(right: 20.w,left:20.w ,bottom: 20.h,top: 50.h),
          child: Form(
            key: formKey,
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
                SizedBox(height: 20.h),
                Text("Forgot Password",style: TextStyle(
                  fontSize: 23,fontWeight: FontWeight.w500,color: Colors.black
                ),),
                Text("Please enter your email to reset your password",),
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

                SizedBox(height: 30.h),

                GetBuilder<AuthController>(builder:(controller){
                  return AuthButton(
                    buttonText: 'Get Verification Code',
                    isLoading: controller.enterEmailIsLoading,
                    onPressed:(){
                      if(formKey.currentState!.validate()){
                        controller.enterEmailId();
                      }
                    }
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