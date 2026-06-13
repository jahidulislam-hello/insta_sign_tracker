import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/utils/widget/customeTextField/custom_text_field.dart';
import '../controller/removal_change_controller.dart';

class SignRemovalScreen extends GetView<RemovalChangeController> {
  const SignRemovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Sign Removal',
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
                borderColor: Colors.black.withValues(alpha: 0.45),
                controller: controller.selectSign),
            const SizedBox(height: 16),
            _buildDueDateField(context),
            const SizedBox(height: 16),
            _buildDropdown(
              label: 'Did the new homeowner leave the post installed?',
              selectedValue: controller.selectedPostInstalled,
              items: controller.yesNoOptions,
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              label: 'Do we need to pickup the lockbox?',
              selectedValue: controller.selectedPickupLockbox,
              items: controller.yesNoOptions,
            ),
            const SizedBox(height: 16),
            _buildNotesField(),
            const SizedBox(height: 40),
            _buildBottomButtons(),
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

  Widget _buildDropdown({
    required String label,
    required RxString selectedValue,
    required List<String> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        Obx(
              () => Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedValue.value.isEmpty ? null : selectedValue.value,
                hint: const Text(
                  'Select',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: items
                    .map(
                      (item) => DropdownMenuItem(
                    value: item,
                    child: Text(item, style: const TextStyle(fontSize: 14)),
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

  Widget _buildBottomButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: BorderSide(color: Colors.grey.shade400),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF42A5F5),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            onPressed: () {
              // TODO: Remove logic
            },
            child: const Text(
              'Remove',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}