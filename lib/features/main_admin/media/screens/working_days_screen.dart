import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../widgets/labeled_dropdown.dart';

class DayConfig {
  final String name;
  bool enabled;
  String start;
  String end;

  DayConfig({
    required this.name,
    required this.enabled,
    required this.start,
    required this.end,
  });
}

class WorkingDaysScreen extends StatefulWidget {
  const WorkingDaysScreen({super.key});

  @override
  State<WorkingDaysScreen> createState() => _WorkingDaysScreenState();
}

class _WorkingDaysScreenState extends State<WorkingDaysScreen> {
  bool _expanded = true;
  String _startSetting = 'Launch Time';
  String _endSetting = 'Get Home Time';

  final List<DayConfig> _days = [
    DayConfig(name: 'Sunday', enabled: false, start: '9:00 AM - CDT', end: '5:00 PM - CDT'),
    DayConfig(name: 'Monday', enabled: true, start: '11:00 AM - CDT', end: '6:00 PM - CDT'),
    DayConfig(name: 'Tuesday', enabled: true, start: '11:00 AM - CDT', end: '6:00 PM - CDT'),
    DayConfig(name: 'Wednesday', enabled: true, start: '11:00 AM - CDT', end: '6:00 PM - CDT'),
    DayConfig(name: 'Thursday', enabled: true, start: '11:00 AM - CDT', end: '6:00 PM - CDT'),
    DayConfig(name: 'Friday', enabled: true, start: '11:00 AM - CDT', end: '6:00 PM - CDT'),
    DayConfig(name: 'Saturday', enabled: false, start: '9:00 AM - CDT', end: '5:00 PM - CDT'),
  ];

  static final List<String> _times = _generateTimes();

  static List<String> _generateTimes() {
    final times = <String>[];
    for (int hour = 6; hour <= 21; hour++) {
      for (final minute in [0, 30]) {
        final period = hour >= 12 ? 'PM' : 'AM';
        final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
        final m = minute == 0 ? '00' : '30';
        times.add('$displayHour:$m $period - CDT');
      }
    }
    return times;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    children: [
                      const Text('Working Days & Hours', style: AppText.title),
                      const Spacer(),
                      InkWell(
                        onTap: () => setState(() => _expanded = !_expanded),
                        child: Icon(
                          _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (_expanded) ...[
                  const Divider(height: 1, color: AppColors.border),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LayoutBuilder(builder: (context, constraints) {
                          final isNarrow = constraints.maxWidth < 620;
                          final startField = LabeledDropdown(
                            label: 'Start of Day Time Setting',
                            helperText: 'Time you leave your launch location',
                            value: _startSetting,
                            items: const ['Launch Time', 'Custom Time'],
                            onChanged: (v) => setState(() => _startSetting = v!),
                          );
                          final endField = LabeledDropdown(
                            label: 'End of Day Time Setting',
                            helperText: 'Time you finish with your last appointment and arrive home',
                            value: _endSetting,
                            items: const ['Get Home Time', 'Custom Time'],
                            onChanged: (v) => setState(() => _endSetting = v!),
                          );
                          if (isNarrow) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                startField,
                                const SizedBox(height: 16),
                                endField,
                              ],
                            );
                          }
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: startField),
                              const SizedBox(width: 24),
                              Expanded(child: endField),
                            ],
                          );
                        }),
                        const SizedBox(height: 28),
                        // Column headers
                        Row(
                          children: const [
                            SizedBox(width: 140, child: Text('Working Days', style: AppText.fieldLabel)),
                            SizedBox(width: 16),
                            Expanded(child: Text('Beginning of Day', style: AppText.fieldLabel)),
                            SizedBox(width: 16),
                            Expanded(child: Text('End of Day', style: AppText.fieldLabel)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        for (final day in _days) ...[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 140,
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: day.enabled,
                                        activeColor: AppColors.blue,
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        onChanged: (v) => setState(() => day.enabled = v ?? false),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(day.name, style: AppText.body),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: LabeledDropdown(
                                    value: day.start,
                                    items: _times,
                                    onChanged: (v) => setState(() => day.start = v!),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: LabeledDropdown(
                                    value: day.end,
                                    items: _times,
                                    onChanged: (v) => setState(() => day.end = v!),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
