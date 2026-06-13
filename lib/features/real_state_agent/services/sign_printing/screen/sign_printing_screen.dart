import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/routes/app_routes.dart';
import 'package:insta_sign_tracker/features/real_state_agent/services/sign_printing/presentation/sign_printing_controller.dart';

class SignPrintingScreen extends GetView<SignPrintingController> {
  const SignPrintingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Sign Printing',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCreateCustomizeButton(),
            const SizedBox(height: 20),
            _buildUploadSection(),
            const SizedBox(height: 20),
            _buildDropdown(
              label: 'Select Size',
              selectedValue: controller.selectedSize,
              items: controller.sizes,
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              label: 'Select Material',
              selectedValue: controller.selectedMaterial,
              items: controller.materials,
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              label: 'Option',
              selectedValue: controller.selectedOption,
              items: controller.options,
              hint: 'Select an Option',
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              label: 'Select Quantity',
              selectedValue: controller.selectedQuantity,
              items: controller.quantities,
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              label: 'Select Delivery Method',
              selectedValue: controller.selectedDelivery,
              items: controller.deliveryMethods,
              hint: 'Select a method',
            ),
            const SizedBox(height: 16),
            _buildNotesField(),
            const SizedBox(height: 30),
            _buildNextButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateCustomizeButton() {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF42A5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Create Customize Sign',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          SizedBox(width: 8),
          Icon(Icons.add_circle_outline, color: Colors.white, size: 20),
        ],
      ),
    );
  }

  Widget _buildUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Do you have your own design you'd like us to\nprint? Upload it here.",
          style: TextStyle(fontSize: 13, color: Colors.black87),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () {
            // TODO: file picker logic
          },
          child: Container(
            width: double.infinity,
            height: 110,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade300,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.cloud_upload_outlined,
                    size: 32, color: Color(0xFF42A5F5)),
                SizedBox(height: 8),
                Text(
                  'Upload File',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required RxString selectedValue,
    required List<String> items,
    String? hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: Colors.black87),
        ),
        const SizedBox(height: 6),
        Obx(
              () => Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedValue.value.isEmpty ? null : selectedValue.value,
                hint: Text(
                  hint ?? items.first,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: items
                    .map(
                      (item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                )
                    .toList(),
                onChanged: (val) {
                  if (val != null) selectedValue.value = val;
                },
              ),
            ),
          ),
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
          style: TextStyle(fontSize: 13, color: Colors.black87),
        ),
        const SizedBox(height: 6),
        Obx(
              () => TextFormField(
            controller: controller.notesController.value,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'e.g. Make it faster as you can.',
              hintStyle:
              const TextStyle(fontSize: 13, color: Colors.black38),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF42A5F5)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNextButton() {
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
         Get.toNamed(AppRoutes.reviewOrderScreen);
        },
        child: const Text(
          'Next',
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