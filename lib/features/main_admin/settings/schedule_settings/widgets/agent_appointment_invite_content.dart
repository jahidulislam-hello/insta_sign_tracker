import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import 'shared_controls.dart';

class AgentAppointmentInviteContent extends StatefulWidget {
  const AgentAppointmentInviteContent({super.key});

  @override
  State<AgentAppointmentInviteContent> createState() => _AgentAppointmentInviteContentState();
}

class _AgentAppointmentInviteContentState extends State<AgentAppointmentInviteContent> {
  bool _includeCalendarInvite = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: AppColors.panelFill, borderRadius: BorderRadius.circular(8)),
          child: ToggleRow(
            title: 'Include a calendar invitation when sending out appointment confirmed emails.',
            description:
                'Please note that this will include a downloadable calendar invitation whenever an appointment confirmation email is sent. Your agent can save this to their calendar.',
            titleColor: AppColors.blueLink,
            value: _includeCalendarInvite,
            onChanged: (v) => setState(() => _includeCalendarInvite = v),
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
