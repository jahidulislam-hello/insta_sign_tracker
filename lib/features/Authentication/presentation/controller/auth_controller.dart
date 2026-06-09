import 'package:get/get.dart';

class AuthController extends GetxController {
  // Selected role store করার জন্য
  var selectedRole = Rxn<String>();

  // Role select হলে update করবে
  void setSelectedRole(String role) {
    selectedRole.value = role;
    print('Selected Role: $role');
  }

  // Sign up এ যাওয়ার সময় role pass করা
  String getSelectedRole() {
    return selectedRole.value ?? '';
  }
}