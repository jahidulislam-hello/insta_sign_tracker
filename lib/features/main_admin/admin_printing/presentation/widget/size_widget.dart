// size_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../controller/admin_printing_controller.dart';
import '../widget/add_editDialog.dart';
import '../widget/delete_dialog.dart';

class SizeWidget extends GetView<AdminPrintingController> {
  const SizeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeaderRow(context),
        Expanded(child: _buildList(context)),
      ],
    );
  }

  Widget _buildHeaderRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() => RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Size ',
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: '(${controller.sizes.length.toString().padLeft(2, '0')})',
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue,
                  ),
                ),
              ],
            ),
          )),
          ElevatedButton.icon(
            onPressed: () => _showAddDialog(context),
            label: Text(
              '+ Add Size',
              style: GoogleFonts.montserrat(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return Obx(() => ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
      itemCount: controller.sizes.length,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (context, index) => _buildCard(context, index),
    ));
  }

  Widget _buildCard(BuildContext context, int index) {
    final item = controller.sizes[index];
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(width: 0.2, color: Colors.grey),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F2FF),
                borderRadius: BorderRadius.circular(32.r),
              ),
              child: Icon(
                Icons.open_with,
                color: const Color(0xFF00628B),
                size: 24.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.size,
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    style: GoogleFonts.montserrat(
                      fontSize: 13.sp,
                      color: Colors.black.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            _buildPopupMenu(context, index),
          ],
        ),
      ),
    );
  }

  Widget _buildPopupMenu(BuildContext context, int index) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, color: Colors.grey.shade600, size: 22.sp),
      padding: EdgeInsets.zero,
      color: Colors.white,
      elevation: 4,
      onSelected: (value) {
        if (value == 'edit') {
          _showEditDialog(context, index);
        } else if (value == 'delete') {
          _showDeleteDialog(context, index);
        }
      },
      itemBuilder: (_) => [
        PopupMenuItem<String>(
          value: 'edit',
          padding: EdgeInsets.zero,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.appBarColor,
              borderRadius: BorderRadius.circular(0.r),
            ),
            child: Text(
              'Edit',
              style: GoogleFonts.montserrat(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: 'delete',
          padding: EdgeInsets.zero,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Color(0xFFFFF4E6),
              borderRadius: BorderRadius.circular(0.r),
            ),
            child: Text(
              'Delete',
              style: GoogleFonts.montserrat(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showAddDialog(BuildContext context) {
    AddEditDialog.show(
      context: context,
      title: 'Add Size',
      fields: const ['Size', 'Charge Amount'],
      onSubmit: (values) {
        if (values['Size']!.isNotEmpty && values['Charge Amount']!.isNotEmpty) {
          controller.addSize(
            values['Size']!,
            double.parse(values['Charge Amount']!),
          );
        }
      },
    );
  }

  void _showEditDialog(BuildContext context, int index) {
    final item = controller.sizes[index];
    AddEditDialog.show(
      context: context,
      title: 'Edit Size',
      fields: const ['Size', 'Charge Amount'],
      initialValues: {
        'Size': item.size,
        'Charge Amount': item.price.toString(),
      },
      onSubmit: (values) {
        if (values['Size']!.isNotEmpty && values['Charge Amount']!.isNotEmpty) {
          controller.editSize(
            index,
            values['Size']!,
            double.parse(values['Charge Amount']!),
          );
        }
      },
    );
  }

  void _showDeleteDialog(BuildContext context, int index) {
    DeleteDialog.show(
      context: context,
      onConfirm: () {
        controller.deleteSize(index);
      },
    );
  }
}