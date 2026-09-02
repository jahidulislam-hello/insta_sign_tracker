import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';


// ---------------------------------------------------------------------------
// COLORS
// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------
// SERVICE SETUP DIALOG
// ---------------------------------------------------------------------------
class ServiceSetupDialog extends StatefulWidget {
  const ServiceSetupDialog({super.key});

  @override
  State<ServiceSetupDialog> createState() => _ServiceSetupDialogState();
}

class _ServiceSetupDialogState extends State<ServiceSetupDialog> {
  // General Info
  String icon = 'Image';
  String serviceCategory = 'Photo';
  bool addVideo = false;
  final serviceNameController = TextEditingController(text: '');
  final descriptionController = TextEditingController();
  final instructionsController = TextEditingController();

  // Service Pricing
  String paymentOption = 'Fixed';
  final priceController = TextEditingController(text: '300');

  // Onsite Duration
  int durationTab = 0; // 0 = Above Ground, 1 = Below Ground
  List<_DurationRow> durationRows = [
    _DurationRow(min: '0', max: 'Infinity', duration: '60'),
  ];

  // Photographer Payment
  bool photographerPaid = true;
  String photographerPaymentOption = 'Fixed';
  final photographerPriceController = TextEditingController(text: '50');
  bool advancedPricing = false;

  @override
  void dispose() {
    serviceNameController.dispose();
    descriptionController.dispose();
    instructionsController.dispose();
    priceController.dispose();
    photographerPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460, maxHeight: 780),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.dialogBg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 16, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Service Setup',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColors.heading,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.close, size: 18, color: AppColors.subtitle),
                    ),
                  ],
                ),
              ),
              // Scrollable body — everything from both screenshots lives here.
              Flexible(
                child: Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _generalInfoCard(),
                        const SizedBox(height: 16),
                        _servicePricingCard(),
                        const SizedBox(height: 16),
                        _onsiteDurationCard(),
                        const SizedBox(height: 16),
                        _linkedServicesCard(),
                        const SizedBox(height: 16),
                        _taskCard(),
                        const SizedBox(height: 16),
                        _photographerPaymentCard(),
                      ],
                    ),
                  ),
                ),
              ),
              // Footer (fixed, not part of scroll)
              Container(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: AppColors.divider)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.link,
                          side: const BorderSide(color: AppColors.inputBorder),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Close',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // GENERAL INFO
  // -------------------------------------------------------------------------
  Widget _generalInfoCard() {
    return _SectionCard(
      title: 'General Info',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ImageThumb(
                onEdit: () {},
                onDelete: () {},
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _LabeledDropdown(
                            label: 'Icon',
                            required: true,
                            value: icon,
                            items: const ['Image', 'Camera', 'Video'],
                            onChanged: (v) => setState(() => icon = v),
                            leadingIcon: Icons.image_outlined,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                          child: _LabeledField(
                            label: 'Service Name',
                            required: true,
                            controller: serviceNameController,
                            hint: 'e.g. 25 Premi',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _LabeledDropdown(
                      label: 'Service Category',
                      required: true,
                      value: serviceCategory,
                      items: const ['Photo', 'Video', 'Drone', 'Floor Plan'],
                      onChanged: (v) => setState(() => serviceCategory = v),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Description',
            style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.label),
          ),
          const SizedBox(height: 6),
          _MultilineField(
            controller: descriptionController,
            hint: 'Describe this service...',
            minLines: 3,
          ),
          const SizedBox(height: 4),
          const Text(
            'This description will show on the order page when the user clicks to see more information.',
            style: TextStyle(fontSize: 11, color: AppColors.required),
          ),
          const SizedBox(height: 14),
          const Text(
            'Photographer Onsite Instructions (Internal Only)',
            style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.label),
          ),
          const SizedBox(height: 6),
          _MultilineField(
            controller: instructionsController,
            hint: 'Instructions for technician/photographer...',
            minLines: 2,
            hintColor: AppColors.required,
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _MiniSwitch(
                value: addVideo,
                onChanged: (v) => setState(() => addVideo = v),
              ),
              const SizedBox(width: 10),
              const Text(
                'Add Video',
                style: TextStyle(fontSize: 13, color: AppColors.heading, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // SERVICE PRICING
  // -------------------------------------------------------------------------
  Widget _servicePricingCard() {
    return _SectionCard(
      title: 'Service Pricing',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(color: AppColors.divider, height: 1),
          const SizedBox(height: 14),
          const Text(
            'Payment Options?',
            style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.label),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _RadioOption(
                label: 'Fixed',
                selected: paymentOption == 'Fixed',
                onTap: () => setState(() => paymentOption = 'Fixed'),
              ),
              const SizedBox(width: 24),
              _RadioOption(
                label: 'Variable',
                selected: paymentOption == 'Variable',
                onTap: () => setState(() => paymentOption = 'Variable'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Price',
            style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.label),
          ),
          const SizedBox(height: 6),
          _PrefixedField(controller: priceController, prefix: '\$'),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // ONSITE DURATION
  // -------------------------------------------------------------------------
  Widget _onsiteDurationCard() {
    return _SectionCard(
      title: 'Onsite Duration',
      trailing: _ClearAllLink(onTap: () => setState(() => durationRows.clear())),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SegmentedTabs(
            selectedIndex: durationTab,
            labels: const ['Above Ground...', 'Below Ground...'],
            badgeIndex: 0,
            badgeCount: durationRows.length,
            onChanged: (i) => setState(() => durationTab = i),
          ),
          const SizedBox(height: 14),
          for (int i = 0; i < durationRows.length; i++) ...[
            _DurationRowWidget(
              row: durationRows[i],
              onDelete: () => setState(() => durationRows.removeAt(i)),
            ),
            const SizedBox(height: 10),
          ],
          GestureDetector(
            onTap: () => setState(
                  () => durationRows.add(_DurationRow(min: '', max: '', duration: '')),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add, size: 16, color: AppColors.link),
                SizedBox(width: 4),
                Text(
                  'Add Row',
                  style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.link),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // LINKED SERVICES
  // -------------------------------------------------------------------------
  Widget _linkedServicesCard() {
    return _SectionCard(
      title: 'Linked Services',
      trailing: _ClearAllLink(onTap: () {}),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Additional Services to Upsell On Order Page',
            style: TextStyle(fontSize: 11.5, color: AppColors.subtitle),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {},
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add, size: 16, color: AppColors.link),
                SizedBox(width: 4),
                Text(
                  'Add New',
                  style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.link),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // TASK
  // -------------------------------------------------------------------------
  Widget _taskCard() {
    return _SectionCard(
      title: 'Task',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select which tasks this add-on should perform',
            style: TextStyle(fontSize: 11.5, color: AppColors.subtitle),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {},
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add, size: 16, color: AppColors.link),
                SizedBox(width: 4),
                Text(
                  'Add Task',
                  style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.link),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // PHOTOGRAPHER PAYMENT
  // -------------------------------------------------------------------------
  Widget _photographerPaymentCard() {
    return _SectionCard(
      title: 'Photographer Payment',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(color: AppColors.divider, height: 1),
          const SizedBox(height: 14),
          const Text(
            'Will the photographer be paid for this service?',
            style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.label),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _RadioOption(
                label: 'Yes',
                selected: photographerPaid,
                onTap: () => setState(() => photographerPaid = true),
              ),
              const SizedBox(width: 24),
              _RadioOption(
                label: 'No',
                selected: !photographerPaid,
                onTap: () => setState(() => photographerPaid = false),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Photographer Payment Options:',
            style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.label),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _RadioOption(
                label: 'Fixed',
                selected: photographerPaymentOption == 'Fixed',
                onTap: () => setState(() => photographerPaymentOption = 'Fixed'),
              ),
              const SizedBox(width: 24),
              _RadioOption(
                label: 'Variable',
                selected: photographerPaymentOption == 'Variable',
                onTap: () => setState(() => photographerPaymentOption = 'Variable'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Price',
            style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.label),
          ),
          const SizedBox(height: 6),
          _PrefixedField(controller: photographerPriceController, prefix: '\$'),
          const SizedBox(height: 16),
          Row(
            children: [
              _MiniSwitch(
                value: advancedPricing,
                onChanged: (v) => setState(() => advancedPricing = v),
              ),
              const SizedBox(width: 10),
              const Text(
                'Advanced Pricing',
                style: TextStyle(fontSize: 13, color: AppColors.heading, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// DATA MODEL FOR DURATION ROWS
// ---------------------------------------------------------------------------
class _DurationRow {
  String min;
  String max;
  String duration;
  _DurationRow({required this.min, required this.max, required this.duration});
}

class _DurationRowWidget extends StatelessWidget {
  final _DurationRow row;
  final VoidCallback onDelete;
  const _DurationRowWidget({required this.row, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: _MiniLabeledField(label: 'Minimum Sq. Feet', initialValue: row.min, onChanged: (v) => row.min = v),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _MiniLabeledField(label: 'Maximum Sq. Feet', initialValue: row.max, onChanged: (v) => row.max = v),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _MiniLabeledField(label: 'Duration (minutes)', initialValue: row.duration, onChanged: (v) => row.duration = v),
        ),
        const SizedBox(width: 6),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: GestureDetector(
            onTap: onDelete,
            child: const Icon(Icons.delete_outline, size: 18, color: AppColors.teal),
          ),
        ),
      ],
    );
  }
}

class _MiniLabeledField extends StatelessWidget {
  final String label;
  final String initialValue;
  final ValueChanged<String> onChanged;
  const _MiniLabeledField({
    required this.label,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 10.5, color: AppColors.subtitle, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Container(
          height: 34,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: AppColors.inputBg,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.inputBorder),
          ),
          child: TextField(
            controller: TextEditingController(text: initialValue),
            onChanged: onChanged,
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
            ),
            style: const TextStyle(fontSize: 12.5, color: AppColors.heading),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// REUSABLE PIECES
// ---------------------------------------------------------------------------
class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;
  const _SectionCard({required this.title, required this.child, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.heading,
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _ClearAllLink extends StatelessWidget {
  final VoidCallback onTap;
  const _ClearAllLink({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Text(
        'Clear All',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.link),
      ),
    );
  }
}

class _ImageThumb extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const _ImageThumb({required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFF7A9E6E),
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=300',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _RoundIconButton(icon: Icons.edit, onTap: onEdit),
              const SizedBox(width: 6),
              _RoundIconButton(icon: Icons.delete_outline, onTap: onDelete),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _RoundIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 26,
        height: 26,
        decoration: const BoxDecoration(
          color: AppColors.primaryBlue,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 13, color: Colors.white),
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final bool required;
  final TextEditingController controller;
  final String hint;
  const _LabeledField({
    required this.label,
    required this.controller,
    this.required = false,
    this.hint = 'Type here...',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.label),
            ),
            if (required)
              const Text(' *', style: TextStyle(fontSize: 12, color: AppColors.required, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.inputBg,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.inputBorder),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: hint,
              hintStyle: const TextStyle(color: AppColors.placeholder, fontSize: 12.5),
            ),
            style: const TextStyle(fontSize: 12.5, color: AppColors.heading),
          ),
        ),
      ],
    );
  }
}

class _LabeledDropdown extends StatelessWidget {
  final String label;
  final bool required;
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;
  final IconData? leadingIcon;
  const _LabeledDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.required = false,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.label),
            ),
            if (required)
              const Text(' *', style: TextStyle(fontSize: 12, color: AppColors.required, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.inputBg,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.inputBorder),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.placeholder),
              style: const TextStyle(fontSize: 12.5, color: AppColors.heading),
              items: items
                  .map((e) => DropdownMenuItem(
                value: e,
                child: Row(
                  children: [
                    if (leadingIcon != null) ...[
                      Icon(leadingIcon, size: 14, color: AppColors.placeholder),
                      const SizedBox(width: 6),
                    ],
                    Text(e),
                  ],
                ),
              ))
                  .toList(),
              onChanged: (v) => onChanged(v!),
            ),
          ),
        ),
      ],
    );
  }
}

class _MultilineField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int minLines;
  final Color? hintColor;
  const _MultilineField({
    required this.controller,
    required this.hint,
    this.minLines = 3,
    this.hintColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.inputBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: TextField(
        controller: controller,
        minLines: minLines,
        maxLines: minLines + 2,
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: hintColor ?? AppColors.placeholder, fontSize: 12.5),
        ),
        style: const TextStyle(fontSize: 12.5, color: AppColors.heading),
      ),
    );
  }
}

class _PrefixedField extends StatelessWidget {
  final TextEditingController controller;
  final String prefix;
  const _PrefixedField({required this.controller, required this.prefix});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.inputBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: Row(
        children: [
          Text(prefix, style: const TextStyle(fontSize: 13, color: AppColors.subtitle, fontWeight: FontWeight.w600)),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(isDense: true, border: InputBorder.none),
              style: const TextStyle(fontSize: 13, color: AppColors.heading),
            ),
          ),
        ],
      ),
    );
  }
}

class _RadioOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _RadioOption({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? AppColors.primaryBlue : AppColors.inputBorder,
                width: 1.6,
              ),
            ),
            child: selected
                ? Center(
              child: Container(
                width: 9,
                height: 9,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryBlue,
                ),
              ),
            )
                : null,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: AppColors.heading),
          ),
        ],
      ),
    );
  }
}

class _MiniSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  const _MiniSwitch({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.white,
        activeTrackColor: AppColors.primaryBlue,
        inactiveThumbColor: Colors.white,
        inactiveTrackColor: const Color(0xFFD7DAE3),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),
    );
  }
}

class _SegmentedTabs extends StatelessWidget {
  final int selectedIndex;
  final List<String> labels;
  final int badgeIndex;
  final int badgeCount;
  final ValueChanged<int> onChanged;
  const _SegmentedTabs({
    required this.selectedIndex,
    required this.labels,
    required this.onChanged,
    this.badgeIndex = -1,
    this.badgeCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.inputBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: Row(
        children: List.generate(labels.length, (i) {
          final selected = i == selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(i),
              child: Container(
                margin: const EdgeInsets.all(3),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected ? const Color(0xFFDCEBFC) : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      child: Text(
                        labels[i],
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: selected ? AppColors.link : AppColors.heading,
                        ),
                      ),
                    ),
                    if (i == badgeIndex && badgeCount > 0)
                      Positioned(
                        top: -6,
                        right: 8,
                        child: Container(
                          width: 16,
                          height: 16,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryBlue,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '$badgeCount',
                            style: const TextStyle(fontSize: 9.5, color: Colors.white, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}