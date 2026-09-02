import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';


/// The reusable "icon + title + subtitle + chevron" header that, when
/// tapped, animates open to reveal [content]. Used by all 5 cards on the
/// Scheduling Settings screen.
class ExpandableSettingsCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget content;
  final bool initiallyExpanded;

  const ExpandableSettingsCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.content,
    this.initiallyExpanded = false,
  });

  @override
  State<ExpandableSettingsCard> createState() => _ExpandableSettingsCardState();
}

class _ExpandableSettingsCardState extends State<ExpandableSettingsCard> {
  late bool _expanded = widget.initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: cardDecoration(),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(color: AppColors.blueIconBg, shape: BoxShape.circle),
                    child: Icon(widget.icon, size: 17, color: AppColors.blue),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.title, style: AppText.cardTitle),
                        const SizedBox(height: 2),
                        Text(widget.subtitle, style: AppText.cardSubtitle),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.keyboard_arrow_down, color: AppColors.textMuted, size: 22),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: _expanded
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(height: 1, color: AppColors.border),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                        child: widget.content,
                      ),
                    ],
                  )
                : const SizedBox(width: double.infinity, height: 0),
          ),
        ],
      ),
    );
  }
}
