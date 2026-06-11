import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoiceController extends GetxController {
  // Selected filter
  RxString selectedFilter = 'All Items'.obs;

  // Search presentation
  TextEditingController invoiceSearch = TextEditingController();

  // Invoice list data
  late List<Map<String, String>> allInvoices;

  @override
  void onInit() {
    super.onInit();
    _initializeInvoices();
  }

  void _initializeInvoices() {
    allInvoices = [
      {
        'number': '7511',
        'orderId': 'ORD-9920',
        'date': '22/01/2026',
        'amount': '\$1,240.00',
        'status': 'PAID'
      },
      {
        'number': '7512',
        'orderId': 'ORD-9921',
        'date': '21/01/2026',
        'amount': '\$890.00',
        'status': 'PENDING'
      },
      {
        'number': '7513',
        'orderId': 'ORD-9922',
        'date': '20/01/2026',
        'amount': '\$2,100.00',
        'status': 'UNPAID'
      },
      {
        'number': '7514',
        'orderId': 'ORD-9923',
        'date': '19/01/2026',
        'amount': '\$1,550.00',
        'status': 'PAID'
      },
      {
        'number': '7515',
        'orderId': 'ORD-9924',
        'date': '18/01/2026',
        'amount': '\$750.00',
        'status': 'PENDING'
      },
    ];
  }

  void selectFilter(String filter) {
    selectedFilter.value = filter;
  }

  List<Map<String, String>> getFilteredInvoices() {
    if (selectedFilter.value == 'All Items') {
      return allInvoices;
    }
    return allInvoices
        .where((invoice) => invoice['status'] == selectedFilter.value.toUpperCase())
        .toList();
  }
}