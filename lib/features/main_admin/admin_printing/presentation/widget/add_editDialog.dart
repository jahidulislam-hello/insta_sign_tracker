// add_editDialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_sign_tracker/core/utils/widget/customeTextField/custom_text_field.dart';

class AddEditDialog {
  static void show({
    required BuildContext context,
    required String title,
    required List<String> fields,
    Map<String, String>? initialValues,
    required Function(Map<String, String>) onSubmit,
  }) {
    final controllers = <String, TextEditingController>{};
    final formKey = GlobalKey<FormState>();

    for (var field in fields) {
      controllers[field] = TextEditingController(
        text: initialValues?[field] ?? '',
      );
    }

    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Center(
                      child: Text(
                        title,
                        style: GoogleFonts.montserrat(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(dialogContext),
                        child: Icon(
                          Icons.close,
                          color: Colors.blue,
                          size: 24.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                // ✅ PROTTEK FIELD AR SATH CUSTOMTEXTFIELD + LABEL
                ...fields.map((field) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      controller: controllers[field]!,
                      labelText: field,
                      hintText: field.contains('Price') || field.contains('Amount')
                          ? 'Enter price'
                          : 'Type here...',
                      keyboardType: field.contains('Price') || field.contains('Amount')
                          ? TextInputType.numberWithOptions(decimal: true)
                          : TextInputType.text,
                      borderColor: Colors.grey,
                      borderRadius: 8.r,
                      isvalidation: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter ${field.toLowerCase()}';
                        }
                        if (field.contains('Price') || field.contains('Amount')) {
                          final price = double.tryParse(value);
                          if (price == null) {
                            return 'Please enter valid price';
                          }
                          if (price <= 0) {
                            return 'Price must be greater than 0';
                          }
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12.h),
                  ],
                )).toList(),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFAE8E8),
                          elevation: 0,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          'Close',
                          style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // ✅ VALIDATION CHECK
                          if (formKey.currentState!.validate()) {
                            final values = <String, String>{};
                            controllers.forEach((key, controller) {
                              values[key] = controller.text.trim();
                            });
                            Navigator.pop(dialogContext);
                            // ✅ ONTAP CALLBACK
                            onSubmit(values);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
                          elevation: 0,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          'Add',
                          style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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