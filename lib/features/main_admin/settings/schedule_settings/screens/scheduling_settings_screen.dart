import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../widgets/expandable_settings_card.dart';
import '../widgets/scheduling_method_content.dart';
import '../widgets/scheduling_setting_content.dart';
import '../widgets/reason_list_editor.dart';
import '../widgets/agent_appointment_invite_content.dart';

class SchedulingSettingsScreen extends StatelessWidget {
  const SchedulingSettingsScreen({super.key});

  static const _cancellationReasons = [
    'Homeowner scheduling conflict',
    'Agent scheduling conflict',
    'Property not ready/available',
    'Bad weather',
    'Homeowner decided not to list',
  ];

  static const _rescheduleReasons = [
    'Homeowner scheduling conflict',
    'Agent scheduling conflict',
    'Property not ready/available',
    'Bad weather',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _breadcrumb(),
              const SizedBox(height: 10),
              const Text('Scheduling Settings', style: AppText.pageTitle),
              const SizedBox(height: 6),
              _subtitle(),
              const SizedBox(height: 24),
              LayoutBuilder(builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 900;

                final schedulingMethodCard = ExpandableSettingsCard(
                  icon: Icons.calendar_today_outlined,
                  title: 'Scheduling Method',
                  subtitle: 'Initialize manual or automated scheduling slots',
                  content: const SchedulingMethodContent(),
                );
                final schedulingSettingCard = ExpandableSettingsCard(
                  icon: Icons.tune,
                  title: 'Scheduling Setting',
                  subtitle: 'Configure client cancellation buffer window & policies',
                  content: const SchedulingSettingContent(),
                );
                final cancellationReasonsCard = ExpandableSettingsCard(
                  icon: Icons.playlist_add_check,
                  title: 'Cancellation Reasons',
                  subtitle: 'Manage cancellation list reasons for agents',
                  content: const ReasonListEditor(
                    introText: 'Add reasons for agents to select when canceling their order.',
                    initialReasons: _cancellationReasons,
                  ),
                );
                final rescheduleReasonsCard = ExpandableSettingsCard(
                  icon: Icons.playlist_add_check,
                  title: 'Reschedule Reasons',
                  subtitle: 'Manage reschedule list reasons for agents',
                  content: const ReasonListEditor(
                    introText: 'Add reasons for agents to select when rescheduling their order.',
                    initialReasons: _rescheduleReasons,
                  ),
                );
                final agentInviteCard = ExpandableSettingsCard(
                  icon: Icons.calendar_today_outlined,
                  title: 'Agent Appointment Invite Settings',
                  subtitle: 'Toggle automatic downloadable calendar attachments',
                  content: const AgentAppointmentInviteContent(),
                );

                if (isWide) {
                  return Column(
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: schedulingMethodCard),
                            const SizedBox(width: 20),
                            Expanded(child: schedulingSettingCard),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: cancellationReasonsCard),
                            const SizedBox(width: 20),
                            Expanded(child: rescheduleReasonsCard),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      agentInviteCard,
                    ],
                  );
                }

                return Column(
                  children: [
                    schedulingMethodCard,
                    const SizedBox(height: 20),
                    schedulingSettingCard,
                    const SizedBox(height: 20),
                    cancellationReasonsCard,
                    const SizedBox(height: 20),
                    rescheduleReasonsCard,
                    const SizedBox(height: 20),
                    agentInviteCard,
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _breadcrumb() {
    return Row(
      children: [
        Text('Dashboard', style: TextStyle(fontSize: 12.5, color: AppColors.orangeMuted)),
        const _Slash(),
        const Text('Settings', style: TextStyle(fontSize: 12.5, color: AppColors.blueLink)),
        const _Slash(),
        const Text('Schedules', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      ],
    );
  }

  Widget _subtitle() {
    return RichText(
      text: TextSpan(
        style: AppText.pageSubtitle,
        children: const [
          TextSpan(text: 'Configure appointment dispatching preferences, '),
          TextSpan(text: 'scheduling slots, and rules.', style: TextStyle(color: AppColors.blueLink)),
        ],
      ),
    );
  }
}

class _Slash extends StatelessWidget {
  const _Slash();
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: Text('/', style: TextStyle(fontSize: 12.5, color: AppColors.textMuted)),
    );
  }
}
