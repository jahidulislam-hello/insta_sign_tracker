import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import 'shared_controls.dart';

class SchedulingSettingContent extends StatefulWidget {
  const SchedulingSettingContent({super.key});

  @override
  State<SchedulingSettingContent> createState() => _SchedulingSettingContentState();
}

class _SchedulingSettingContentState extends State<SchedulingSettingContent> {
  String _bufferTime = '24 hours';
  bool _orderCompletionTextEnabled = false;
  bool _showTrackingButton = true;
  late final TextEditingController _completionTextController;

  static const _bufferOptions = ['12 hours', '24 hours', '48 hours', '72 hours'];
  static const int _maxChars = 200;

  @override
  void initState() {
    super.initState();
    _completionTextController = TextEditingController(
      text:
          'Thanks for submitting your order. You can expect an email with additional details shortly. In the meantime you can press on the button below to keep track of the state of your order',
    );
    _completionTextController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _completionTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final charCount = _completionTextController.text.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabeledDropdown(
          label: 'Cancellation Buffer Time',
          value: _bufferTime,
          items: _bufferOptions,
          onChanged: (v) => setState(() => _bufferTime = v!),
        ),
        const SizedBox(height: 10),
        const Text(
          'Amount of time prior to an appointment a client is able to cancel from the online confirmation page. Online cancellation/reschedules will be disabled within this window and all appointment changes will have to be completed by an admin.',
          style: AppText.body,
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Transform.scale(
              scale: 0.9,
              child: Checkbox(
                value: _orderCompletionTextEnabled,
                activeColor: AppColors.blue,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (v) => setState(() => _orderCompletionTextEnabled = v ?? false),
              ),
            ),
            const SizedBox(width: 4),
            const Text('Order Completion Text', style: AppText.fieldLabel),
            const Spacer(),
            Text('$charCount / $_maxChars', style: AppText.cardSubtitle),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _completionTextController,
          maxLines: 4,
          maxLength: _maxChars,
          buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
          style: const TextStyle(fontSize: 13, color: AppColors.blue),
          decoration: boxedInputDecoration(),
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: AppColors.panelFill, borderRadius: BorderRadius.circular(8)),
          child: ToggleRow(
            title: 'Show tracking page button',
            description: 'Display a tracking button below completion text for real-time schedule updates.',
            value: _showTrackingButton,
            onChanged: (v) => setState(() => _showTrackingButton = v),
          ),
        ),
        const SizedBox(height: 18),
        const Divider(height: 1, color: AppColors.border),
        const SizedBox(height: 18),
        SaveChangesButton(onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Changes saved'), duration: Duration(seconds: 1)),
          );
        }),
      ],
    );
  }
}
