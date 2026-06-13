import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/utils/widget/customeTextField/custom_text_field.dart';
import '../controller/removal_change_controller.dart';

class SignChangeScreen extends GetView<RemovalChangeController> {
  const SignChangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Sign Change',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
                labelText: "Select Sign",
                hintText: "Select Current Install",
                suffixIcon: Icon(Icons.search),
                controller: controller.selectSignChange),
            const SizedBox(height: 16),
            _buildDueDateField(context),
            const SizedBox(height: 16),
            _buildNotesField(),
            const SizedBox(height: 24),
            _buildReviewOrder(),
            const SizedBox(height: 40),
            _buildPlaceOrderButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }


  Widget _buildDueDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Due Date',
          style: TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        CustomTextField(
          controller: controller.dueDateController,
          hintText: 'MM/DD/YYYY',
          isvalidation: false,
          borderColor: Colors.grey.shade300,
          filColor: Colors.white,
          readOnly: true,
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2100),
            );
            if (picked != null) {
              controller.dueDateController.text =
              '${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}';
            }
          },
        ),
      ],
    );
  }

  Widget _buildNotesField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Notes',
          style: TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        CustomTextField(
          controller: controller.notesController,
          hintText: 'Type notes here',
          isvalidation: false,
          borderColor: Colors.grey.shade300,
          filColor: Colors.white,
          maxLine: 4,
          contentPaddingVertical: 14,
        ),
      ],
    );
  }

  Widget _buildReviewOrder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Review Order',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Price Breakdown',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              _buildPriceRow('Post Install', 50.00),
              const SizedBox(height: 10),
              _buildPriceRow('Credit Card Fee', 50.00),
              const SizedBox(height: 10),
              _buildPriceRow('Others Fee', 50.00),
              const SizedBox(height: 16),
              const Divider(color: Colors.grey, thickness: 0.4),
              const SizedBox(height: 12),
              _buildTotalRow('Total Price', 250.00),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow(String label, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black54,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          '\$ ${amount.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black54,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildTotalRow(String label, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '\$ ${amount.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceOrderButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF42A5F5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: () {
          // TODO: Place Order logic
        },
        child: const Text(
          'Place Order',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}