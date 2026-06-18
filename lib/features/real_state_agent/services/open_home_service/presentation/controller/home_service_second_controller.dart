import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/routes/app_routes.dart';

class HomeServiceSecondController extends GetxController {

  // ===================== PAGE 2 (Open House Services - 1) ====
  final formKey = GlobalKey<FormState>();

  // ---------- House Type ----------
  final List<String> houseTypeList = ['Single Install', 'Dual Install', 'Triple Install'];
  final RxString selectedHouseType = 'Single Install'.obs;

  void selectHouseType(String type) => selectedHouseType.value = type;

  // ---------- Text Fields ----------
  final TextEditingController leadInIntersectionController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  // ---------- Sign Placement ----------
  final List<String> signPlacementList = ['Front Yard', 'Back Yard', 'Side Yard', 'Driveway'];
  final RxString selectedSignPlacement = ''.obs;
  final RxBool signPlacementError = false.obs;

  void selectSignPlacement(String value) {
    selectedSignPlacement.value = value;
    signPlacementError.value = false;
  }

  // ---------- Open House Directional ----------
  final List<String> directionalList = ['Left Directional', 'Right Directional', 'Straight Directional'];
  final RxString selectedDirectional = ''.obs;
  final RxBool directionalError = false.obs;

  void selectDirectional(String value) {
    selectedDirectional.value = value;
    directionalError.value = false;
  }

  // ---------- Rider ----------
  final List<String> riderList = ['For Sale Rider', 'Open House Rider', 'Sold Rider'];
  final RxString selectedRider = ''.obs;
  final RxBool riderError = false.obs;

  void selectRider(String value) {
    selectedRider.value = value;
    riderError.value = false;
  }

  // ---------- Add On Service ----------
  final RxBool isShoeCoverSelected = false.obs;

  void toggleShoeCover() => isShoeCoverSelected.value = !isShoeCoverSelected.value;

  // ---------- Price Breakdown (Page 2) ----------
  final double postInstallPrice = 50.0;
  final double creditCardFee = 50.0;
  final double othersFee = 50.0;
  final double totalPrice = 250.0;

  // ---------- Validation & Submit (Page 2) ----------
  bool validateForm() {
    final isTextFieldsValid = formKey.currentState!.validate();

    signPlacementError.value = selectedSignPlacement.value.isEmpty;
    directionalError.value = selectedDirectional.value.isEmpty;
    riderError.value = selectedRider.value.isEmpty;

    final isSelectorsValid =
        !signPlacementError.value && !directionalError.value && !riderError.value;

    return isTextFieldsValid && isSelectorsValid;
  }

  void placeOrder() {
    if (!validateForm()) return;
    Get.toNamed(AppRoutes.houseServiceTherdScreen);
  }

  // ===================== PAGE 3 (Open House Services - 2) ====
  final formKeyThird = GlobalKey<FormState>();

  // ---------- House Status (Occupied / Vacant) ----------
  final RxString houseStatus = 'Occupied'.obs;

  void selectHouseStatus(String status) => houseStatus.value = status;

  // ---------- Text Fields ----------
  final TextEditingController lockboxController = TextEditingController();
  final TextEditingController gateCodeController = TextEditingController();
  final TextEditingController thirdNotesController = TextEditingController();

  // ---------- Due Date ----------
  final Rx<DateTime?> selectedDueDate = Rx<DateTime?>(DateTime(2026, 10, 12));
  final RxBool dueDateError = false.obs;

  String get formattedDueDate {
    final date = selectedDueDate.value;
    if (date == null) return '';
    return '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}';
  }

  Future<void> pickDueDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDueDate.value ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      selectedDueDate.value = picked;
      dueDateError.value = false;
    }
  }

  // ---------- ASAP / Rush Order ----------
  final RxBool isAsapSelected = true.obs;
  final RxBool isRushOrderSelected = false.obs;

  void selectAsap() {
    isAsapSelected.value = true;
    isRushOrderSelected.value = false;
  }

  void selectRushOrder() {
    isAsapSelected.value = false;
    isRushOrderSelected.value = true;
  }

  // ---------- Confirmation ----------
  final RxBool isConfirmed = false.obs;
  final RxBool confirmationError = false.obs;

  void toggleConfirmation() {
    isConfirmed.value = !isConfirmed.value;
    if (isConfirmed.value) confirmationError.value = false;
  }

  // ---------- Price Breakdown (Page 3) ----------
  final double thirdPostInstallPrice = 50.0;
  final double thirdCreditCardFee = 50.0;
  final double rushOrderFee = 50.0;
  final double thirdOthersFee = 50.0;

  double get thirdTotalPrice {
    double total = thirdPostInstallPrice + thirdCreditCardFee + thirdOthersFee;
    if (isRushOrderSelected.value) total += rushOrderFee;
    return total;
  }

  // ---------- Validation & Submit (Page 3) ----------
  bool validateThirdForm() {
    final isTextFieldsValid = formKeyThird.currentState!.validate();

    dueDateError.value = selectedDueDate.value == null;
    confirmationError.value = !isConfirmed.value;

    return isTextFieldsValid && !dueDateError.value && !confirmationError.value;
  }

  void placeThirdOrder() {
    if (!validateThirdForm()) return;

    // TODO: call API to place order
    debugPrint('Place Order (Page3) -> Status: ${houseStatus.value}, '
        'Lockbox: ${lockboxController.text}, '
        'Gate Code: ${gateCodeController.text}, '
        'Due Date: $formattedDueDate, '
        'ASAP: ${isAsapSelected.value}, Rush: ${isRushOrderSelected.value}, '
        'Notes: ${thirdNotesController.text}, '
        'Confirmed: ${isConfirmed.value}, '
        'Total: $thirdTotalPrice');
  }

  @override
  void onClose() {
    leadInIntersectionController.dispose();
    notesController.dispose();
    lockboxController.dispose();
    gateCodeController.dispose();
    thirdNotesController.dispose();
    super.onClose();
  }
}