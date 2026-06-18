import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';

import '../../../../core/utils/widget/customeTextField/custom_text_field.dart';

class AddAutoRenewDialog extends StatefulWidget {
  final VoidCallback onAdd;

  const AddAutoRenewDialog({
    super.key,
    required this.onAdd,
  });

  @override
  State<AddAutoRenewDialog> createState() => _AddAutoRenewDialogState();
}

class _AddAutoRenewDialogState extends State<AddAutoRenewDialog> {
  // ===== Controllers =====
  late TextEditingController daysController;
  late TextEditingController priceController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    daysController = TextEditingController();
    priceController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Header =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add Auto Renew',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ===== Form =====
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // ===== Select Days Field =====
                  CustomTextField(
                    controller: daysController,
                    labelText: 'Select Days',
                    hintText: 'Enter days',
                    keyboardType: TextInputType.number,
                    borderColor: Colors.grey.shade300,
                    borderRadius: 8,
                    borderHeight: 1,
                    filColor: Colors.white,
                    hinTextColor: Colors.black54,
                    hinTextSize: 13,
                    contentPaddingHorizontal: 12,
                    contentPaddingVertical: 10,
                    prefixIcon: Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey.shade600,
                      size: 18,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter days';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),

                  // ===== Price Field =====
                  CustomTextField(
                    controller: priceController,
                    labelText: 'Price',
                    hintText: 'Enter price',
                    keyboardType: TextInputType.number,
                    borderColor: Colors.grey.shade300,
                    borderRadius: 8,
                    borderHeight: 1,
                    filColor: Colors.white,
                    hinTextColor: Colors.black54,
                    hinTextSize: 13,
                    contentPaddingHorizontal: 12,
                    contentPaddingVertical: 10,
                    prefixIcon: Icon(
                      Icons.attach_money_outlined,
                      color: Colors.grey.shade600,
                      size: 18,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter price';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid price';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ===== Buttons =====
            Row(
              children: [
                // ===== Close Button =====
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: AppColors.primaryBlue,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Close',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // ===== Add Button =====
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // TODO: API call করবো
                        print('Days: ${daysController.text}');
                        print('Price: ${priceController.text}');

                        Get.back();
                        Get.snackbar(
                          'Success',
                          'Auto Renew plan added successfully',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 2),
                        );
                        widget.onAdd();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    daysController.dispose();
    priceController.dispose();
    super.dispose();
  }
}