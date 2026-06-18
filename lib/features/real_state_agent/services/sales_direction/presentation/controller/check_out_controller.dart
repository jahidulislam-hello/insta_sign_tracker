import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/routes/app_routes.dart';

class CheckOutController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final addCardFormKey = GlobalKey<FormState>();

  // Add Card Fields
  final cardNumberController = TextEditingController();
  final expireDateController = TextEditingController();
  final cvcController = TextEditingController();
  final countryController = TextEditingController();
  final selectedCountry = RxnString();

  // Payment Cards
  final cards = <PaymentCard>[
    PaymentCard(
      cardNumber: '8970',
      expiryDate: '12/26',
      cardType: 'VISA',
    ),
    PaymentCard(
      cardNumber: '8970',
      expiryDate: '12/26',
      cardType: 'VISA',
    ),
    PaymentCard(
      cardNumber: '8970',
      expiryDate: '12/26',
      cardType: 'VISA',
    ),
  ].obs;

  // Coupon
  final couponController = TextEditingController();
  final appliedCoupon = ''.obs;
  final discountAmount = 0.0.obs;
  final couponError = ''.obs;

  // Order Summary
  final directionalPackagePrice = 1199.00;
  final premiumAddOnsPrice = 50.00;
  final subtotal = 1249.00;
  double get totalAmount => subtotal - discountAmount.value;

  // Countries list
  final countries = [
    'United States',
    'Canada',
    'United Kingdom',
    'Australia',
    'India',
    'Bangladesh',
  ];

  // Validation Methods
  String? validateCardNumber(String? val) {
    if (val == null || val.isEmpty) {
      return 'Card number is required';
    }
    if (val.replaceAll(' ', '').length < 13 || val.replaceAll(' ', '').length > 19) {
      return 'Invalid card number';
    }
    return null;
  }

  String? validateExpireDate(String? val) {
    if (val == null || val.isEmpty) {
      return 'Expiry date is required';
    }
    return null;
  }

  String? validateCVC(String? val) {
    if (val == null || val.isEmpty) {
      return 'CVC is required';
    }
    if (val.length != 3 && val.length != 4) {
      return 'Invalid CVC';
    }
    return null;
  }

  String? validateCountry(String? val) {
    if (val == null || val.isEmpty) {
      return 'Please select a country';
    }
    return null;
  }

  String? validateCoupon(String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter a coupon code';
    }
    return null;
  }

  // Date Picker
  Future<void> pickExpireDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year, now.month + 1),
      firstDate: now,
      lastDate: DateTime(now.year + 20),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // Format as MM-YY
      final month = picked.month.toString().padLeft(2, '0');
      final year = picked.year.toString().substring(2);
      expireDateController.text = '$month-$year';
    }
  }

  // Add Card
  void addCard() {
    if (addCardFormKey.currentState!.validate()) {
      final lastFourDigits = cardNumberController.text
          .replaceAll(' ', '')
          .substring(cardNumberController.text.replaceAll(' ', '').length - 4);

      final newCard = PaymentCard(
        cardNumber: lastFourDigits,
        expiryDate: expireDateController.text,
        cardType: 'VISA',
      );

      cards.add(newCard);

      // Clear form
      cardNumberController.clear();
      expireDateController.clear();
      cvcController.clear();
      selectedCountry.value = null;

      // Show success dialog
      _showSuccessDialog();
    }
  }

  // Success Dialog - CheckOutScreen এ return করবে
  void _showSuccessDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close Button - CheckOut Screen এ navigate করবে
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Get.back(); // Dialog close করবে
                    Get.back(); // AddCardScreen close করবে
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    child: const Icon(
                      Icons.close,
                      size: 24,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Success Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.check,
                    size: 48,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Success Message
              const Text(
                'Card added successfully',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Great! Your payment method is ready to use.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // Go to Wallet Button - CheckOut Screen এ navigate করবে
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back(); // Dialog close করবে
                    Get.back(); // AddCardScreen close করবে
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Go to wallet',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  // Apply Coupon
  void applyCoupon() {
    couponError.value = '';

    if (formKey.currentState!.validate()) {
      final code = couponController.text.trim();

      if (code.toUpperCase() == 'SAVE10') {
        appliedCoupon.value = code;
        discountAmount.value = (subtotal * 0.10);
        couponController.clear();
      } else {
        couponError.value = 'Invalid coupon code';
      }
    }
  }

  // Delete Card
  void deleteCard(int index) {
    cards.removeAt(index);
  }

  // Confirm Order
  void confirmOrder() {
    if (formKey.currentState!.validate()) {
      print('Order confirmed!');
    }
  }

  // Hold Order
  void holdOrder() {
    print('Order held');
  }

  @override
  void onClose() {
    cardNumberController.dispose();
    expireDateController.dispose();
    cvcController.dispose();
    countryController.dispose();
    couponController.dispose();
    super.onClose();
  }
}

// Card Model
class PaymentCard {
  final String cardNumber;
  final String expiryDate;
  final String cardType;

  PaymentCard({
    required this.cardNumber,
    required this.expiryDate,
    required this.cardType,
  });
}