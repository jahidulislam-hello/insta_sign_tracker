import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../controller/sale_direction_controller.dart';

class SaleDirectionScreen extends GetView<SaleDirectionController> {
  const SaleDirectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Install
            _buildLabel('Current Install', required: true),
            _buildSearchField(),
            const SizedBox(height: 20),

            // Property Information
            _buildSectionHeader('Property Information'),
            _buildLabel('STREET ADDRESS'),
            _buildInputField(
              hint: 'Start typing address...',
              prefixIcon: Icons.location_on_outlined,
              onChanged: (val) => controller.streetAddress.value = val,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('UNIT / APT'),
                      _buildInputField(
                        hint: 'e.g. 2549',
                        onChanged: (val) => controller.unitApt.value = val,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('DUE DATE'),
                      GestureDetector(
                        onTap: () => controller.pickDueDate(context),
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: controller.dueDateController,
                            decoration: _inputDecoration(hint: 'mm/dd/yyyy'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Order
            _buildLabel('Order'),
            Obx(() => Row(
              children: [
                _buildOrderButton(
                  label: 'ASAP',
                  isSelected: controller.selectedOrder.value == 'ASAP',
                  onTap: () => controller.selectOrder('ASAP'),
                ),
                const SizedBox(width: 10),
                _buildOrderButton(
                  label: 'Rush Order',
                  isSelected: controller.selectedOrder.value == 'Rush',
                  onTap: () => controller.selectOrder('Rush'),
                  isRush: true,
                ),
              ],
            )),
            const SizedBox(height: 20),

            // Packages
            _buildLabel('Packages'),
            Obx(() => _buildDropdown(
              value: controller.selectedPackage.value,
              items: controller.packageOptions,
              hint: 'Basic Package',
              onChanged: (val) => controller.selectedPackage.value = val,
            )),
            const SizedBox(height: 20),

            // Sign Placement
            _buildSectionHeader('Sign Placement'),
            Obx(() => _buildDropdown(
              value: controller.selectedSignPlacement.value,
              items: controller.signPlacementOptions,
              hint: "I'll choose",
              onChanged: (val) =>
              controller.selectedSignPlacement.value = val,
            )),
            const SizedBox(height: 12),

            // Lead-In Intersection
            _buildLabel('Lead-In Intersection'),
            _buildTextArea(
              hint: 'Where would you like us to begin placing sign',
              onChanged: (val) => controller.leadInIntersection.value = val,
            ),
            const SizedBox(height: 12),

            // Note
            _buildLabel('Note'),
            _buildTextArea(
              hint: 'Type here...',
              onChanged: (val) => controller.note.value = val,
            ),
            const SizedBox(height: 12),

            // Select a For Sale Directional
            _buildLabel('Select a For Sale Directional'),
            Obx(() => _buildDropdown(
              value: controller.selectedDirectional.value,
              items: controller.directionalOptions,
              hint: 'Select a Directional',
              onChanged: (val) =>
              controller.selectedDirectional.value = val,
            )),
            const SizedBox(height: 24),

            // ADD-ONS
            _buildSectionHeader('ADD-ONS'),
            Obx(() => _buildAddonItem(
              title: 'Shoe Covers',
              subtitle: 'Pack of 10 at listing',
              price: '+\$8.00',
              isChecked: controller.isShoeCoverSelected.value,
              onChanged: controller.toggleShoeCover,
            )),
            Obx(() => _buildAddonItem(
              title: 'Flyer Box Refill',
              subtitle: 'Check & refill brochures',
              price: '+\$15.00',
              isChecked: controller.isFlyerBoxSelected.value,
              onChanged: controller.toggleFlyerBox,
            )),
            const SizedBox(height: 20),

            // Price Breakdown
            _buildSectionHeader('Price Breakdown'),
            Obx(() => Column(
              children: [
                _buildPriceRow('Post Install',
                    '\$${controller.shoeCoverPrice.toStringAsFixed(2)}'),
                _buildPriceRow('Credit Card Fee',
                    '\$${controller.creditCardFee.toStringAsFixed(2)}'),
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Price',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '\$${controller.totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ],
                ),
              ],
            )),
            const SizedBox(height: 24),

            // Place Order Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: controller.placeOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                icon: const Text(
                  'Place Order',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                label: const Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ===================== APP BAR =====================
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
        onPressed: () => Get.back(),
      ),
      title: const Text(
        'Sale Directionals',
        style: TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
    );
  }

  // ===================== SECTION HEADER =====================
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.black,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  // ===================== LABEL =====================
  Widget _buildLabel(String text, {bool required = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
              letterSpacing: 0.5,
            ),
          ),
          if (required)
            const Text(
              ' *',
              style: TextStyle(color: Color(0xFFD32F2F), fontSize: 13),
            ),
        ],
      ),
    );
  }

  // ===================== INPUT DECORATION =====================
  InputDecoration _inputDecoration({String hint = ''}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black38, fontSize: 15),
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      filled: true,
      fillColor: Colors.grey.shade50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.primaryBlue, width: 1.5),
      ),
    );
  }

  // ===================== SEARCH FIELD =====================
  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextField(
        onChanged: (val) => controller.currentInstall.value = val,
        decoration: _inputDecoration(hint: 'Search Current Install').copyWith(
          suffixIcon:
          const Icon(Icons.search, color: Colors.black54, size: 22),
        ),
      ),
    );
  }

  // ===================== INPUT FIELD =====================
  Widget _buildInputField({
    required String hint,
    IconData? prefixIcon,
    Function(String)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        onChanged: onChanged,
        style: const TextStyle(fontSize: 15),
        decoration: _inputDecoration(hint: hint).copyWith(
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: Colors.black38, size: 20)
              : null,
        ),
      ),
    );
  }

  // ===================== TEXTAREA =====================
  Widget _buildTextArea({
    required String hint,
    Function(String)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        maxLines: 3,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 15),
        decoration: _inputDecoration(hint: hint),
      ),
    );
  }

  // ===================== DROPDOWN =====================
  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required String hint,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: value,
        hint: Text(
          hint,
          style: const TextStyle(color: Colors.black38, fontSize: 15),
        ),
        items: items
            .map((e) => DropdownMenuItem(
          value: e,
          child: Text(e, style: const TextStyle(fontSize: 15)),
        ))
            .toList(),
        onChanged: onChanged,
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
        decoration: _inputDecoration(),
        dropdownColor: Colors.white,
        style: const TextStyle(fontSize: 15, color: Colors.black87),
      ),
    );
  }

  // ===================== ORDER BUTTON =====================
  Widget _buildOrderButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    bool isRush = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
        const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isRush
              ? Colors.white
              : (isSelected ? AppColors.primaryBlue : Colors.grey.shade50),
          border: Border.all(
            color: isRush
                ? const Color(0xFFD32F2F)
                : (isSelected
                ? AppColors.primaryBlue
                : Colors.grey.shade200),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isRush) ...[
              const Icon(Icons.bolt,
                  size: 18, color: Color(0xFFD32F2F)),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isRush
                    ? const Color(0xFFD32F2F)
                    : (isSelected ? Colors.white : Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===================== ADDON ITEM =====================
  Widget _buildAddonItem({
    required String title,
    required String subtitle,
    required String price,
    required bool isChecked,
    required Function(bool?) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => onChanged(!isChecked),
            child: Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isChecked ? AppColors.primaryBlue : Colors.white,
                border: Border.all(
                  color: isChecked
                      ? AppColors.primaryBlue
                      : Colors.grey.shade400,
                  width: 1.5,
                ),
              ),
              child: isChecked
                  ? const Icon(Icons.check,
                  size: 15, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // ===================== PRICE ROW =====================
  Widget _buildPriceRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 15, color: Colors.black54),
          ),
          Text(
            value,
            style: const TextStyle(
                fontSize: 15, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}