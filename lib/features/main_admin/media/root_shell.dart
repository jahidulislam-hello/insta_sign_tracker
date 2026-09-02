import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import 'screens/working_days_screen.dart';
import 'screens/calendar_view_screen.dart';
import 'screens/media_delivery_screen.dart';
import 'screens/task_manager_screen.dart';

class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _index = 2; // start on Media Delivery, matching the reference flow

  static const _destinations = [
    _NavItem('Working Days', Icons.schedule_outlined),
    _NavItem('Calendar', Icons.calendar_month_outlined),
    _NavItem('Media Delivery', Icons.photo_camera_back_outlined),
    _NavItem('Task Manager', Icons.checklist_outlined),
  ];

  static const List<Widget> _screens = [
    WorkingDaysScreen(),
    CalendarViewScreen(),
    MediaDeliveryScreen(),
    TaskManagerScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;
          if (isWide) {
            return Row(
              children: [
                _railNav(),
                const VerticalDivider(width: 1, color: AppColors.border),
                Expanded(
                  child: IndexedStack(index: _index, children: _screens),
                ),
              ],
            );
          }
          return Column(
            children: [
              Expanded(child: IndexedStack(index: _index, children: _screens)),
              _bottomNav(),
            ],
          );
        },
      ),
    );
  }

  Widget _railNav() {
    return NavigationRail(
      backgroundColor: AppColors.cardBackground,
      selectedIndex: _index,
      onDestinationSelected: (i) => setState(() => _index = i),
      labelType: NavigationRailLabelType.all,
      useIndicator: true,
      indicatorColor: AppColors.blueLight,
      selectedIconTheme: const IconThemeData(color: AppColors.blue),
      selectedLabelTextStyle: const TextStyle(color: AppColors.blue, fontSize: 11, fontWeight: FontWeight.w600),
      unselectedIconTheme: const IconThemeData(color: AppColors.textSecondary),
      unselectedLabelTextStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 11),
      destinations: [
        for (final d in _destinations)
          NavigationRailDestination(
            icon: Icon(d.icon),
            selectedIcon: Icon(d.icon),
            label: Text(d.label),
          ),
      ],
    );
  }

  Widget _bottomNav() {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.cardBackground,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              for (int i = 0; i < _destinations.length; i++)
                Expanded(
                  child: InkWell(
                    onTap: () => setState(() => _index = i),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _destinations[i].icon,
                          size: 20,
                          color: _index == i ? AppColors.blue : AppColors.textSecondary,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _destinations[i].label,
                          style: TextStyle(
                            fontSize: 10,
                            color: _index == i ? AppColors.blue : AppColors.textSecondary,
                            fontWeight: _index == i ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  const _NavItem(this.label, this.icon);
}
