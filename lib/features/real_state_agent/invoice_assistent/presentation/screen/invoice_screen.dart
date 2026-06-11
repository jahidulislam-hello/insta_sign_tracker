import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import 'package:insta_sign_tracker/core/utils/widget/customeTextField/custom_text_field.dart';
import '../../../home/presentation/widget/app_drawer_widget.dart';
import '../controller/invoice_controller.dart';

class InvoiceScreen extends GetView<InvoiceController> {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingColor,
      appBar: _buildAppBar(),
      drawer:const AppDrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== SEARCH SECTION =====
            _buildSearchSection(),

            // ===== FILTER TABS =====
            _buildFilterTabs(),

            // ===== INVOICE LIST =====
            _buildInvoiceList(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ===================== AppBar =====================
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primaryBlue,
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: const Text(
        'Invoice',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none, color: Colors.white),
        ),
      ],
    );
  }

  // ===================== SEARCH SECTION =====================
  Widget _buildSearchSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryBlue,
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: CustomTextField(
        controller: controller.invoiceSearch,
        hintText: "Search invoice or order ID....",
        prefixIcon: const Icon(Icons.search),
      ),
    );
  }

  // ===================== FILTER TABS =====================
  Widget _buildFilterTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Row(
        children: [
          _buildFilterTab(label: 'All Items'),
          const SizedBox(width: 10),
          _buildFilterTab(label: 'Paid'),
          const SizedBox(width: 10),
          _buildFilterTab(label: 'Pending'),
          const SizedBox(width: 10),
          _buildFilterTab(label: 'Unpaid'),
        ],
      ),
    );
  }

// ===== FILTER TAB ITEM =====
  Widget _buildFilterTab({required String label}) {
    return Obx(
          () => GestureDetector(
        onTap: () => controller.selectFilter(label),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: controller.selectedFilter.value == label
                ? AppColors.primaryBlue
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: controller.selectedFilter.value == label
                  ? AppColors.primaryBlue
                  : Colors.grey[300]!,
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: controller.selectedFilter.value == label
                  ? Colors.white
                  : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  // ===================== INVOICE LIST =====================
  Widget _buildInvoiceList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Obx(
            () {
          final filteredInvoices = controller.getFilteredInvoices();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Invoice (${filteredInvoices.length.toString().padLeft(2, '0')})',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 16),

              // Invoice Cards
              ...List.generate(
                filteredInvoices.length,
                    (index) {
                  final invoice = filteredInvoices[index];
                  return Column(
                    children: [
                      _buildInvoiceCard(
                        invoiceNumber: invoice['number']!,
                        orderId: invoice['orderId']!,
                        date: invoice['date']!,
                        amount: invoice['amount']!,
                        status: invoice['status']!,
                      ),
                      if (index < filteredInvoices.length - 1)
                        const SizedBox(height: 12),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  // ===== INVOICE CARD =====
  Widget _buildInvoiceCard({
    required String invoiceNumber,
    required String orderId,
    required String date,
    required String amount,
    required String status,
  }) {
    // Color based on status
    Color getStatusColor(String status) {
      switch (status.toUpperCase()) {
        case 'PAID':
          return AppColors.primaryBlue;
        case 'PENDING':
          return const Color(0xFFFFA500);
        case 'UNPAID':
          return const Color(0xFF4CAF50);
        default:
          return AppColors.primaryBlue;
      }
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'INVOICE NUMBER',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[500],
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '#$invoiceNumber',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              // Status Badge - Dynamic Color
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: getStatusColor(status),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      status,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Order ID and Date Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order ID',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[500],
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    orderId,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Date',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[500],
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Amount and Arrow
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Colors.grey[400],
              ),
            ],
          ),
        ],
      ),
    );
  }

}