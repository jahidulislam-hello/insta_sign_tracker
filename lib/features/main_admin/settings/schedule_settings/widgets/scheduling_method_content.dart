import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import 'shared_controls.dart';

enum SchedulingMode { manual, automatic }

enum ArrivalWindow { exact, twoHour }

class SchedulingMethodContent extends StatefulWidget {
  const SchedulingMethodContent({super.key});

  @override
  State<SchedulingMethodContent> createState() => _SchedulingMethodContentState();
}

class _SchedulingMethodContentState extends State<SchedulingMethodContent> {
  SchedulingMode _mode = SchedulingMode.manual;
  ArrivalWindow _arrival = ArrivalWindow.twoHour;
  bool _autoCancellation = false;
  String _autoCancelTime = '10:00 PM';

  static const _times = [
    '6:00 PM', '7:00 PM', '8:00 PM', '9:00 PM', '10:00 PM', '11:00 PM', '12:00 AM',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableOptionTile(
          selected: _mode == SchedulingMode.manual,
          onTap: () => setState(() => _mode = SchedulingMode.manual),
          title: 'Manual',
          description:
              'You use the Basic Manual Scheduler to schedule appointments based on the two date preferences the client gives in the order.',
        ),
        const SizedBox(height: 10),
        SelectableOptionTile(
          selected: _mode == SchedulingMode.automatic,
          onTap: () => setState(() => _mode = SchedulingMode.automatic),
          title: 'Automatic Scheduling',
          description: "Users can see photographer's availability and select an appointment slot",
        ),
        const SizedBox(height: 20),
        const Text('APPOINTMENT TIME', style: AppText.sectionLabel),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SelectableOptionTile(
                dense: true,
                selected: _arrival == ArrivalWindow.exact,
                onTap: () => setState(() => _arrival = ArrivalWindow.exact),
                leadingIcon: Icons.schedule_outlined,
                title: 'Exact Arrival Time',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SelectableOptionTile(
                dense: true,
                selected: _arrival == ArrivalWindow.twoHour,
                onTap: () => setState(() => _arrival = ArrivalWindow.twoHour),
                leadingIcon: Icons.hourglass_empty,
                title: '2 Hour Arrival Window',
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: AppColors.panelFill, borderRadius: BorderRadius.circular(8)),
          child: ToggleRow(
            title: 'Auto Cancellation of Appointment',
            description: 'Toggle automatic cancellation of non-confirmed appointments.',
            value: _autoCancellation,
            onChanged: (v) => setState(() => _autoCancellation = v),
          ),
        ),
        const SizedBox(height: 16),
        Opacity(
          opacity: _autoCancellation ? 1 : 0.45,
          child: IgnorePointer(
            ignoring: !_autoCancellation,
            child: LabeledDropdown(
              label: 'TIME NON-CONFIRMED JOBS WILL AUTO CANCEL',
              value: _autoCancelTime,
              items: _times,
              onChanged: (v) => setState(() => _autoCancelTime = v!),
            ),
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
