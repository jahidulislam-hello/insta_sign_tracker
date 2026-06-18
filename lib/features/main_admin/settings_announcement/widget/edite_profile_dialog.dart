import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../../../../core/utils/widget/customeTextField/custom_text_field.dart';

class EditProfileDialog extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final VoidCallback onSave;

  const EditProfileDialog({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.onSave,
  });

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  // ===== Form Key =====
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: 320,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Header Section =====
            Row(
              children: [
                // ===== Avatar =====
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.primaryBlue,
                  child: const Text(
                    'JD',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // ===== Name & Email =====
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Julian Draxler',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'julian@arch.com',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),

                // ===== Done Badge =====
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.teal.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '✓ Saved',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ===== Divider =====
            Container(
              height: 1,
              color: Colors.grey.shade200,
            ),
            const SizedBox(height: 20),

            // ===== Form Section =====
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // ===== Name Field =====
                  CustomTextField(
                    controller: widget.nameController,
                    hintText: 'Enter your name',
                    labelText: 'Type here (Name)',
                    keyboardType: TextInputType.text,
                    borderColor: Colors.grey.shade300,
                    borderRadius: 8,
                    borderHeight: 1,
                    filColor: Colors.white,
                    hinTextColor: Colors.black87,
                    hinTextSize: 12,
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                  ),

                  // ===== Email Field =====
                  CustomTextField(
                    controller: widget.emailController,
                    hintText: 'Enter your email',
                    labelText: 'Type here (email)',
                    keyboardType: TextInputType.emailAddress,
                    borderColor: Colors.grey.shade300,
                    borderRadius: 8,
                    borderHeight: 1,
                    filColor: Colors.white,
                    hinTextColor: Colors.black87,
                    hinTextSize: 12,
                    isEmail: true,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ===== Cancel & Save Buttons (Bottom) =====
            Row(
              children: [
                // ===== Cancel Button =====
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // ===== Save Button =====
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // ===== Validate form =====
                      if (_formKey.currentState!.validate()) {
                        // ===== Call the callback =====
                        widget.onSave();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Save',
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
}