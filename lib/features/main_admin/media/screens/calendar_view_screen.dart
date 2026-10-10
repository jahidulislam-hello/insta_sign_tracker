import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../widgets/dashed_box.dart';
import 'working_days_screen.dart';

class CalendarAppointment {
  final String hour; // e.g. '8am'
  final String photographer;
  CalendarAppointment({required this.hour, required this.photographer});
}

class CalendarViewScreen extends StatefulWidget {
  const CalendarViewScreen({super.key});

  @override
  State<CalendarViewScreen> createState() => _CalendarViewScreenState();
}

class _CalendarViewScreenState extends State<CalendarViewScreen> {
  DateTime _date = DateTime(2026, 6, 9);
  String _photographerFilter = 'All Photographers';

  final List<String> _hours = const [
    '8am', '9am', '10am', '11am', '12pm', '1pm', '2pm', '3pm', '4pm', '5pm'
  ];

  final List<CalendarAppointment> _appointments = [
    CalendarAppointment(hour: '8am', photographer: 'Trey Kelly'),
  ];

  static const List<String> _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  String get _formattedDate =>
      '${_months[_date.month - 1]} ${_date.day.toString().padLeft(2, '0')}, ${_date.year}';

  void _shiftDate(int days) {
    setState(() => _date = _date.add(Duration(days: days)));
  }

  void _goToWorkingDays() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const WorkingDaysScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Calendar View', style: AppText.title),
              const SizedBox(height: 16),
              _toolbar(),
              const SizedBox(height: 12),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: ListView.builder(
                    itemCount: _hours.length,
                    itemBuilder: (context, index) => _hourRow(index),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _toolbar() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: [
        _bordered(
          width: 190,
          child: Row(
            children: [
              Expanded(
                child: Text(_photographerFilter,
                    style: const TextStyle(fontSize: 13, color: AppColors.blueLink)),
              ),
              const Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.textMuted),
            ],
          ),
          onTap: () => setState(() => _photographerFilter = _photographerFilter == 'All Photographers'
              ? 'Trey Kelly'
              : 'All Photographers'),
        ),
        _iconButton(icon: Icons.chevron_left, onTap: () => _shiftDate(-1)),
        _bordered(
          width: 140,
          child: Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 15, color: AppColors.textMuted),
              const SizedBox(width: 8),
              Text(_formattedDate, style: const TextStyle(fontSize: 13, color: AppColors.textPrimary)),
            ],
          ),
        ),
        _iconButton(icon: Icons.chevron_right, onTap: () => _shiftDate(1)),
        const Spacer(),
        _iconButton(
          icon: Icons.refresh,
          borderColor: AppColors.blue,
          iconColor: AppColors.blue,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Refreshed'), duration: Duration(seconds: 1)),
            );
          },
        ),
        _outlinedTextButton('Today', onTap: () => setState(() => _date = DateTime(2026, 6, 9))),
        _outlinedTextButton('Reserve Time', onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Reserve Time — coming soon'), duration: Duration(seconds: 1)),
          );
        }),
        _outlinedTextButton('Settings', onTap: _goToWorkingDays),
      ],
    );
  }

  Widget _bordered({required double width, required Widget child, VoidCallback? onTap}) {
    final content = Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(6),
      ),
      child: child,
    );
    if (onTap == null) return content;
    return InkWell(borderRadius: BorderRadius.circular(6), onTap: onTap, child: content);
  }

  Widget _iconButton({
    required IconData icon,
    required VoidCallback onTap,
    Color borderColor = AppColors.border,
    Color iconColor = AppColors.textSecondary,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 38,
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 18, color: iconColor),
      ),
    );
  }

  Widget _outlinedTextButton(String label, {required VoidCallback onTap}) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.blue,
        side: const BorderSide(color: AppColors.blue),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }

  Widget _hourRow(int index) {
    final hour = _hours[index];
    final shaded = index % 2 == 0;
    final appts = _appointments.where((a) => a.hour == hour).toList();

    return Container(
      height: 66,
      color: shaded ? const Color(0xFFF7F8FA) : Colors.white,
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 64,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, left: 12),
                    child: Text(hour,
                        style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary)),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, right: 12),
                    child: Wrap(
                      spacing: 8,
                      children: [
                        for (final a in appts) _appointmentChip(a.photographer),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: DashedLine(),
          ),
        ],
      ),
    );
  }

  Widget _appointmentChip(String name) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$name — appointment details'), duration: const Duration(seconds: 1)),
        );
      },
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.settings, size: 13, color: AppColors.blue),
            const SizedBox(width: 6),
            Text(name, style: const TextStyle(fontSize: 12.5, color: AppColors.blueLink)),
          ],
        ),
      ),
    );
  }
}
