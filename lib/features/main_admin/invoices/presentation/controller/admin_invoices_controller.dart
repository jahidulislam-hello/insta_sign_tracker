import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/model/invoice_model.dart';
import '../widget/refund_dialog.dart';

enum RefundType { full, partial }

class AdminInvoicesController extends GetxController {
  final selectedTab = 0.obs;
  final refundType = RefundType.full.obs;
  final searchController = TextEditingController();
  final refundReasonController = TextEditingController();
  final refundAmountController = TextEditingController(text: '\$145.00');

  final tabs = ['All Items', 'Paid', 'Pending', 'Unpaid'];

  final allInvoices = <InvoiceModel>[
    InvoiceModel(invoiceNumber: '#7511', title: 'Sign install', date: '22/01/2026', amount: 200, status: InvoiceStatus.paid),
    InvoiceModel(invoiceNumber: '#7512', title: 'Sign install', date: '22/01/2026', amount: 200, status: InvoiceStatus.paid),
    InvoiceModel(invoiceNumber: '#7513', title: 'Sign install', date: '22/01/2026', amount: 150, status: InvoiceStatus.pending),
    InvoiceModel(invoiceNumber: '#7514', title: 'Sign install', date: '22/01/2026', amount: 180, status: InvoiceStatus.unpaid),
    InvoiceModel(invoiceNumber: '#7515', title: 'Sign install', date: '22/01/2026', amount: 200, status: InvoiceStatus.paid),
    InvoiceModel(invoiceNumber: '#7516', title: 'Sign install', date: '22/01/2026', amount: 120, status: InvoiceStatus.pending),
  ];

  List<InvoiceModel> get filteredInvoices {
    switch (selectedTab.value) {
      case 1:
        return allInvoices.where((e) => e.status == InvoiceStatus.paid).toList();
      case 2:
        return allInvoices.where((e) => e.status == InvoiceStatus.pending).toList();
      case 3:
        return allInvoices.where((e) => e.status == InvoiceStatus.unpaid).toList();
      default:
        return allInvoices;
    }
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void switchRefundType(RefundType type) {
    refundType.value = type;
    if (type == RefundType.full) {
      refundAmountController.clear();
    }
  }

  void openRefundDialog(BuildContext context) {
    refundType.value = RefundType.full;
    refundReasonController.clear();
    refundAmountController.text = '\$145.00';
    Get.dialog(const RefundDialog());
  }

  void confirmRefund() {
    Get.back();
    Get.snackbar('Success', 'Refund submitted');
  }

  @override
  void onClose() {
    searchController.dispose();
    refundReasonController.dispose();
    refundAmountController.dispose();
    super.onClose();
  }
}