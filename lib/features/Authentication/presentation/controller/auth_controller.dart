import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/routes/app_routes.dart';
import 'package:logger/logger.dart';

class AuthController extends GetxController {
  //Selected role
  var selectedRole = Rxn<String>();
  void setSelectedRole(String role) {
    selectedRole.value = role;
    Logger().i('Selected Role: $role');
  }
  String getSelectedRole() {
    return selectedRole.value ?? '';
  }

  //SignUpScreen
  final singUpNameController = TextEditingController();
  final singUpPhoneController = TextEditingController();
  final singUpEmailController = TextEditingController();
  final singUpPasswordController = TextEditingController();
  final singUpConfirmPasswordController = TextEditingController();
  bool isLoading = false;

  Future<void> singUpId() async {
    isLoading = true;
    update();

    try {
      Logger().i("sing up successfully.");
      Get.offAllNamed(AppRoutes.dashboardScreen);
    } catch (e) {
      Logger().i("sing up fail.");
    } finally {
      isLoading = false;
      update();
    }
  }

  void signUpDispose() {
    singUpNameController.dispose();
    singUpPhoneController.dispose();
    singUpEmailController.dispose();
    singUpPasswordController.dispose();
    singUpConfirmPasswordController.dispose();
  }

  //loginScreen
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  bool loginIsLoading = false;

  Future<void> loginId() async {
    loginIsLoading = true;
    update();

    try {
      Logger().i("login successfully.");
      Get.offAllNamed(AppRoutes.dashboardScreen);
    } catch (e) {
      Logger().i("login fail.");
    } finally {
      loginIsLoading = false;
      update();
    }
  }

  void loginDispos() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
  }

  //Enter email
  bool enterEmailIsLoading = false;

  Future<void> enterEmailId() async {
    enterEmailIsLoading = true;
    update();
    try {
      Get.toNamed(AppRoutes.otpVerifyScreen);
      Logger().i("EnterEmailIsLoading successfully.");
    } catch (e) {
      Logger().i("EnterEmailIsLoading fail.");
    } finally {
      enterEmailIsLoading = false;
      update();
    }
  }

  //otp_verify
  final otpController = TextEditingController();
  bool verifyOtpIsLoading = false;
  bool resentOtpIsLoading = false;
  var resendCountdown = 60.obs;

  @override
  void onInit() {
    super.onInit();
    _startResendTimer();
  }

  void _startResendTimer() {
    resendCountdown.value = 60;
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (resendCountdown.value > 0) {
        resendCountdown.value--;
        return true;
      }
      return false;
    });
  }

  Future<void> verifyOtp() async {
    verifyOtpIsLoading = true;
    update();

    try {
      Logger().i("verifyOtpIsLoading successfully.");
      Get.toNamed(AppRoutes.resetPassScreen);
    } catch (e) {
      Logger().i("verifyOtpIsLoading fail.");
    } finally {
      verifyOtpIsLoading = false;
      update();
    }
  }

  Future<void> resentOtp() async {
    resentOtpIsLoading = true;
    update();

    try {
      _startResendTimer();
      Logger().i("resentOtpIsLoading successfully.");
    } catch (e) {
      Logger().i("resentOtpIsLoading fail.");
    } finally {
      resentOtpIsLoading = false;
      update();
    }
  }

  //reset pass
  final resetPassPasswordController = TextEditingController();
  final resetPassConfirmPasswordController = TextEditingController();
  bool resetPassIsLoading = false;

  Future<void> resetPass() async {
    resetPassIsLoading = true;
    update();

    try {
      Logger().i("resetPassIsLoading successfully.");
    } catch (e) {
      Logger().i("resetPassIsLoading fail.");
    } finally {
      resetPassIsLoading = false;
      update();
    }
  }

}