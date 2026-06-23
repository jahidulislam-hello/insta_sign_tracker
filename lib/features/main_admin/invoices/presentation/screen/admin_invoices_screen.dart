import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import 'package:insta_sign_tracker/core/utils/widget/customeTextField/custom_text_field.dart';
import '../../../dashboard_and_user_management/presentation/widget/admin_app_drawer_widget.dart';
import '../../data/model/invoice_model.dart';
import '../controller/admin_invoices_controller.dart';

class AdminInvoicesScreen extends GetView<AdminInvoicesController> {
  const AdminInvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FA),
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.white, size: 22.sp),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(
          'Invoices',
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.white,
                  size: 24.sp,
                ),
                Positioned(
                  top: 6.h,
                  right: 0,
                  child: Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer:  AdminAppDrawerWidget(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchBar(),
          _buildTabRow(),
          _buildInvoiceCount(),
          Expanded(child: _buildInvoiceList()),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: Colors.lightBlue,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      child: CustomTextField(
        controller: controller.searchController,
        hintText: 'Search invoice or order ID...',
        prefixIcon: const Icon(Icons.search),
      ),
    );
  }

  Widget _buildTabRow() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      child: Obx(() => Row(
        children: List.generate(controller.tabs.length, (i) {
          final isSelected = controller.selectedTab.value == i;
          return GestureDetector(
            onTap: () => controller.changeTab(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.only(right: 8.w),
              padding: EdgeInsets.symmetric(
                  horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.lightBlue
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                controller.tabs[i],
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        }),
      )),
    );
  }

  Widget _buildInvoiceCount() {
    return Obx(() => Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Text(
        'Invoice (${controller.filteredInvoices.length.toString().padLeft(2, '0')})',
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    ));
  }

  Widget _buildInvoiceList() {
    return Obx(() => ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
      itemCount: controller.filteredInvoices.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) =>
          _buildInvoiceCard(context, controller.filteredInvoices[index]),
    ));
  }

  Widget _buildInvoiceCard(BuildContext context, InvoiceModel invoice) {
    Color statusBgColor;
    String statusText;
    switch (invoice.status) {
      case InvoiceStatus.paid:
        statusBgColor = Colors.lightBlue;
        statusText = 'PAID';
        break;
      case InvoiceStatus.pending:
        statusBgColor = Colors.orange;
        statusText = 'PENDING';
        break;
      case InvoiceStatus.unpaid:
        statusBgColor = Colors.red;
        statusText = 'UNPAID';
        break;
    }

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'INVOICE ${invoice.invoiceNumber}',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    invoice.title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_outlined,
                          size: 12.sp, color: Colors.grey.shade500),
                      SizedBox(width: 4.w),
                      Text(
                        invoice.date,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${invoice.amount.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 12.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: statusBgColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle,
                            size: 10.sp, color: Colors.white),
                        SizedBox(width: 3.w),
                        Text(
                          statusText,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => controller.openRefundDialog(context),
                  icon: Icon(
                    Icons.replay_outlined,
                    size: 19.sp,
                    color: AppColors.blackGreen,
                    fontWeight: FontWeight.bold,
                  ),
                  label: Text(
                    'Refund',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.blackGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFCEE5FF),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(26.r),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.file_download_outlined,
                    color: Colors.white,
                    size: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}