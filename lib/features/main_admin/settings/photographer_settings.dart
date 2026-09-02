import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';






// Local accent colors for icon badges that aren't already distinct tokens
// in app_theme.dart (kept here, not added to the shared file, since they're
// specific to this screen's 8 category icons).
class _IconAccent {
  final Color bg;
  final Color fg;
  const _IconAccent(this.bg, this.fg);

  static const invoicing = _IconAccent(AppColors.blueBadgeBg, AppColors.blue);
  static const reschedule = _IconAccent(AppColors.redLight, AppColors.coralRed);
  static const mileage = _IconAccent(AppColors.greenLight, AppColors.green);
  static const beginDay = _IconAccent(AppColors.orangeLight, AppColors.orange);
  static const feeMods = _IconAccent(Color(0xFFEFEBFF), Color(0xFF7C6FEF));
  static const defaults = _IconAccent(Color(0xFFE8EAFB), Color(0xFF5B5FC7));
  static const portal = _IconAccent(AppColors.redLight, Color(0xFFE0546B));
  static const calendarEvent = _IconAccent(Color(0xFFE0F7F3), Color(0xFF1FA98F));
}

class PhotographerSettingsScreen extends StatefulWidget {
  const PhotographerSettingsScreen({super.key});

  @override
  State<PhotographerSettingsScreen> createState() =>
      _PhotographerSettingsScreenState();
}

class _PhotographerSettingsScreenState
    extends State<PhotographerSettingsScreen> {
  int? _expandedIndex;

  void _toggle(int index) {
    setState(() {
      _expandedIndex = _expandedIndex == index ? null : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sections = <_SectionSpec>[
      _SectionSpec(
        title: 'Invoicing',
        subtitle: 'Manage photographer invoicing types and cycles',
        icon: Icons.description_outlined,
        accent: _IconAccent.invoicing,
        builder: (_) => const _InvoicingPanel(),
      ),
      _SectionSpec(
        title: 'Rescheduling and Cancellation',
        subtitle: 'Configure photographer compensation for cancellations and rescheduling',
        icon: Icons.event_busy_outlined,
        accent: _IconAccent.reschedule,
        builder: (_) => const _RescheduleCancellationPanel(),
      ),
      _SectionSpec(
        title: 'Daily Mileage',
        subtitle: 'Reimbursement rules for photographer travel',
        icon: Icons.signpost_outlined,
        accent: _IconAccent.mileage,
        builder: (_) => const _DailyMileagePanel(),
      ),
      _SectionSpec(
        title: 'Begin Day Time',
        subtitle: 'Set the start and end hours for photographer routing',
        icon: Icons.access_time_rounded,
        accent: _IconAccent.beginDay,
        builder: (_) => const _BeginDayTimePanel(),
      ),
      _SectionSpec(
        title: 'Photographer Fee Modifications',
        subtitle: 'Manage base payouts and custom modifiers per service',
        icon: Icons.link_rounded,
        accent: _IconAccent.feeMods,
        builder: (_) => const _FeeModificationsPanel(),
      ),
      _SectionSpec(
        title: 'Photographer Defaults',
        subtitle: 'Global default booking parameters and slot definitions',
        icon: Icons.tune_rounded,
        accent: _IconAccent.defaults,
        builder: (_) => const _DefaultsPanel(),
      ),
      _SectionSpec(
        title: 'Photographer Portal Settings',
        subtitle: 'Configure feature visibility and permission states inside photographer portals',
        icon: Icons.shield_outlined,
        accent: _IconAccent.portal,
        builder: (_) => const _PortalSettingsPanel(),
      ),
      _SectionSpec(
        title: 'Calendar Event Settings',
        subtitle: 'Configure event details and template display modes on calendar layouts',
        icon: Icons.calendar_today_outlined,
        accent: _IconAccent.calendarEvent,
        builder: (_) => const _CalendarEventSettingsPanel(),
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Breadcrumb(),
                const SizedBox(height: 14),
                const Text('Photographer Settings', style: AppText.h1),
                const SizedBox(height: 6),
                const Text(
                  'Configure invoicing cycles, cancellation policies, mileage reimbursement, '
                      'start times, portal permissions, and fee overrides.',
                  style: AppText.pageSubtitle,
                ),
                const SizedBox(height: 20),
                for (var i = 0; i < sections.length; i++) ...[
                  _SectionCard(
                    spec: sections[i],
                    isExpanded: _expandedIndex == i,
                    onTap: () => _toggle(i),
                  ),
                  const SizedBox(height: 14),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Breadcrumb ──────────────────────────────────────────────────────────
class _Breadcrumb extends StatelessWidget {
  const _Breadcrumb();
  @override
  Widget build(BuildContext context) {
    final linkStyle = AppText.breadcrumb.copyWith(
      color: AppColors.orangeMuted,
      fontWeight: FontWeight.w500,
    );
    final sepStyle = AppText.breadcrumb;
    final activeStyle = AppText.breadcrumb.copyWith(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w600,
    );
    return Row(
      children: [
        Text('Dashboard', style: linkStyle),
        Text('  /  ', style: sepStyle),
        Text('Users Management', style: linkStyle),
        Text('  /  ', style: sepStyle),
        Text('Photographer', style: activeStyle),
      ],
    );
  }
}

// ── Data holder for each accordion item ────────────────────────────────
class _SectionSpec {
  final String title;
  final String subtitle;
  final IconData icon;
  final _IconAccent accent;
  final WidgetBuilder builder;

  _SectionSpec({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.builder,
  });
}

// ── Accordion card: icon + title/subtitle header, chevron, animated body ──
class _SectionCard extends StatelessWidget {
  final _SectionSpec spec;
  final bool isExpanded;
  final VoidCallback onTap;

  const _SectionCard({
    required this.spec,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: cardDecoration(radius: AppColors.radiusLg),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: spec.accent.bg,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(spec.icon, size: 19, color: spec.accent.fg),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(spec.title, style: AppText.cardTitle),
                        const SizedBox(height: 2),
                        Text(spec.subtitle, style: AppText.cardSubtitle),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity, height: 0),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: spec.builder(context),
            ),
            crossFadeState:
            isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 220),
            sizeCurve: Curves.easeInOut,
          ),
        ],
      ),
    );
  }
}

// ── Shared small widgets (same building blocks as the Invoicing screen) ───

class _FieldLabel extends StatelessWidget {
  final String label;
  final TextStyle labelStyle;
  final Widget child;
  final String? helper;
  final bool required;

  const _FieldLabel({
    required this.label,
    required this.labelStyle,
    required this.child,
    this.helper,
    this.required = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: labelStyle),
            if (required)
              const Text(' *', style: TextStyle(color: AppColors.dangerRed, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 8),
        child,
        if (helper != null) ...[
          const SizedBox(height: 6),
          Text(helper!, style: AppText.bodyMuted.copyWith(height: 1.4)),
        ],
      ],
    );
  }
}

class _Dropdown extends StatelessWidget {
  final String value;
  const _Dropdown({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.inputFillLight,
        borderRadius: BorderRadius.circular(AppColors.radiusSm),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(value, overflow: TextOverflow.ellipsis, style: AppText.cell),
          ),
          const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}

class _TextInput extends StatelessWidget {
  final String value;
  final String? hint;
  final Widget? prefix;
  const _TextInput({required this.value, this.hint, this.prefix});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: TextField(
        controller: TextEditingController(text: value),
        style: AppText.cell,
        decoration: boxedInputDecoration(hint: hint).copyWith(
          prefixIcon: prefix,
          prefixIconConstraints: const BoxConstraints(minWidth: 34, minHeight: 0),
        ),
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? labelColor;
  const _ToggleRow({
    required this.label,
    required this.value,
    required this.onChanged,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Transform.scale(
            scale: 0.85,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.white,
              activeTrackColor: AppColors.blue,
              inactiveTrackColor: AppColors.borderStrong,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              label,
              style: AppText.optionTitle.copyWith(
                fontWeight: FontWeight.w500,
                color: labelColor ?? AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool fullWidth;
  const _SaveButton({required this.onPressed, this.fullWidth = false});

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.blue,
        foregroundColor: AppColors.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: fullWidth ? 0 : 22, vertical: fullWidth ? 14 : 13),
        minimumSize: fullWidth ? const Size(double.infinity, 46) : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppColors.radiusMd)),
      ),
      child: const Text('Save Changes', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600)),
    );
    return fullWidth
        ? SizedBox(width: double.infinity, child: button)
        : Align(alignment: Alignment.centerRight, child: button);
  }
}

class _RemovableChip extends StatelessWidget {
  final String label;
  const _RemovableChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: AppColors.inputFillLight,
        borderRadius: BorderRadius.circular(AppColors.radiusSm),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.link),
            ),
          ),
          const Icon(Icons.delete_outline, size: 18, color: AppColors.deleteRed),
        ],
      ),
    );
  }
}

class _AddRow extends StatelessWidget {
  final String hint;
  const _AddRow({required this.hint});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _TextInput(value: '', hint: hint)),
        const SizedBox(width: 8),
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.blue),
            borderRadius: BorderRadius.circular(AppColors.radiusSm),
          ),
          child: const Icon(Icons.add, size: 18, color: AppColors.blue),
        ),
      ],
    );
  }
}

// ── PANEL 1: Invoicing ──────────────────────────────────────────────────
class _InvoicingPanel extends StatelessWidget {
  const _InvoicingPanel();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 1, color: AppColors.border),
        const SizedBox(height: 18),
        _FieldLabel(
          label: 'Invoicing Type',
          required: true,
          labelStyle: AppText.fieldLabel.copyWith(color: AppColors.accentBlue),
          child: const _Dropdown(value: 'Weekly (Invoices on Mondays)'),
        ),
        const SizedBox(height: 20),
        _SaveButton(onPressed: () {}),
      ],
    );
  }
}

// ── PANEL 2: Rescheduling and Cancellation ─────────────────────────────
class _RescheduleCancellationPanel extends StatelessWidget {
  const _RescheduleCancellationPanel();
  @override
  Widget build(BuildContext context) {
    final labelStyle = AppText.fieldLabel.copyWith(color: AppColors.accentBlue);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 1, color: AppColors.border),
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _FieldLabel(
                label: 'Photographer Cancellation Fee',
                labelStyle: labelStyle,
                child: const _TextInput(value: '0', prefix: Icon(Icons.attach_money, size: 16, color: AppColors.textMuted)),
                helper: 'Payment to photographer if client cancels appointment outside cancellation window',
              ),
            ),
            const SizedBox(width: 32),
            Expanded(
              child: _FieldLabel(
                label: 'Photographer Reschedule Fee',
                labelStyle: labelStyle,
                child: const _TextInput(value: '0', prefix: Icon(Icons.attach_money, size: 16, color: AppColors.textMuted)),
                helper: 'Payment to photographer if client reschedules appointment outside reschedule window',
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _FieldLabel(
                label: 'Cancellation Window (hours)',
                labelStyle: labelStyle,
                child: const _TextInput(value: '24'),
                helper: 'Minimum hours notice required before appointment to avoid cancellation fees',
              ),
            ),
            const SizedBox(width: 32),
            Expanded(
              child: _FieldLabel(
                label: 'Reschedule Window (hours)',
                labelStyle: labelStyle,
                child: const _TextInput(value: '24'),
                helper: 'Minimum hours notice required before appointment to avoid reschedule fees',
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _SaveButton(onPressed: () {}),
      ],
    );
  }
}

// ── PANEL 3: Daily Mileage ──────────────────────────────────────────────
class _DailyMileagePanel extends StatefulWidget {
  const _DailyMileagePanel();
  @override
  State<_DailyMileagePanel> createState() => _DailyMileagePanelState();
}

class _DailyMileagePanelState extends State<_DailyMileagePanel> {
  bool excludeFromLaunchToFirst = false;
  bool excludeFromLastToLaunch = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 1, color: AppColors.border),
        const SizedBox(height: 18),
        _FieldLabel(
          label: 'Minimum Daily Mileage (miles)',
          labelStyle: AppText.fieldLabel,
          child: const _TextInput(value: '0', prefix: Icon(Icons.place_outlined, size: 16, color: AppColors.textMuted)),
          helper: 'Photographers\' daily uncompensated mileage (accounts for mileage driven to first '
              'appointment and from last appointment)',
        ),
        const SizedBox(height: 18),
        _FieldLabel(
          label: 'Minimum Mileage Per Appointment (miles)',
          labelStyle: AppText.fieldLabel,
          child: const _TextInput(value: '0', prefix: Icon(Icons.place_outlined, size: 16, color: AppColors.textMuted)),
          helper: 'Photographers\' uncompensated mileage between each appointment',
        ),
        const SizedBox(height: 18),
        _FieldLabel(
          label: 'Payment Configuration',
          labelStyle: AppText.fieldLabel,
          child: const _Dropdown(value: 'Flat'),
        ),
        const SizedBox(height: 18),
        _FieldLabel(
          label: 'Payment',
          required: true,
          labelStyle: AppText.fieldLabel,
          child: const _TextInput(value: '0', prefix: Icon(Icons.attach_money, size: 16, color: AppColors.textMuted)),
        ),
        const SizedBox(height: 14),
        _ToggleRow(
          label: 'Exclude drive distance from "Launch" location to first appointment',
          value: excludeFromLaunchToFirst,
          onChanged: (v) => setState(() => excludeFromLaunchToFirst = v),
          labelColor: AppColors.link,
        ),
        _ToggleRow(
          label: 'Exclude drive distance from Last Appointment to "Launch" location',
          value: excludeFromLastToLaunch,
          onChanged: (v) => setState(() => excludeFromLastToLaunch = v),
          labelColor: AppColors.link,
        ),
        const SizedBox(height: 14),
        _SaveButton(onPressed: () {}),
      ],
    );
  }
}

// ── PANEL 4: Begin Day Time ─────────────────────────────────────────────
class _BeginDayTimePanel extends StatelessWidget {
  const _BeginDayTimePanel();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 1, color: AppColors.border),
        const SizedBox(height: 18),
        _FieldLabel(
          label: 'Begin Day Time',
          labelStyle: AppText.fieldLabel,
          child: const _Dropdown(value: '5:00 PM'),
          helper: 'This is the time (day before) when a photographer is able to press the '
              'begin day button and set their arrival time for their first appointment.',
        ),
        const SizedBox(height: 20),
        _SaveButton(onPressed: () {}),
      ],
    );
  }
}

// ── PANEL 5: Photographer Fee Modifications ─────────────────────────────
class _FeeModificationsPanel extends StatefulWidget {
  const _FeeModificationsPanel();
  @override
  State<_FeeModificationsPanel> createState() => _FeeModificationsPanelState();
}

class _FeeModificationsPanelState extends State<_FeeModificationsPanel> {
  final overrideReasons = ['Weather conditions', 'Technical difficulties on site', 'Client request for manual adjustment'];
  final chargeReasons = ['Toll road reimbursement', 'Extra parking fee', 'Twilight shoot extension'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 1, color: AppColors.border),
        const SizedBox(height: 18),
        const Text('Override Reasons', style: AppText.cardTitle),
        const SizedBox(height: 4),
        const Text(
          'A photographer can select one of these reasons when modifying their invoice in the Photographer Portal.',
          style: AppText.descriptionText,
        ),
        const SizedBox(height: 10),
        const _AddRow(hint: 'Enter here'),
        const SizedBox(height: 12),
        for (final reason in overrideReasons) _RemovableChip(label: reason),
        const SizedBox(height: 18),
        const Text('Custom Charge Reasons', style: AppText.cardTitle),
        const SizedBox(height: 4),
        const Text(
          'A photographer can select one of these reasons when adding charges to their invoice in the Photographer Portal.',
          style: AppText.descriptionText,
        ),
        const SizedBox(height: 10),
        const _AddRow(hint: 'Enter here'),
        const SizedBox(height: 12),
        for (final reason in chargeReasons) _RemovableChip(label: reason),
        const SizedBox(height: 8),
        _SaveButton(onPressed: () {}),
      ],
    );
  }
}

// ── PANEL 6: Photographer Defaults ──────────────────────────────────────
class _DefaultsPanel extends StatelessWidget {
  const _DefaultsPanel();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 1, color: AppColors.border),
        const SizedBox(height: 18),
        _FieldLabel(
          label: 'Default Photo Bracket Size',
          labelStyle: AppText.fieldLabel.copyWith(color: AppColors.accentBlue),
          child: const _Dropdown(value: '5'),
        ),
        const SizedBox(height: 20),
        _SaveButton(onPressed: () {}),
      ],
    );
  }
}

// ── PANEL 7: Photographer Portal Settings ───────────────────────────────
class _PortalSettingsPanel extends StatefulWidget {
  const _PortalSettingsPanel();
  @override
  State<_PortalSettingsPanel> createState() => _PortalSettingsPanelState();
}

class _PortalSettingsPanelState extends State<_PortalSettingsPanel> {
  final Map<String, bool> toggles = {
    'Show Agent Name': true,
    'Show Agent Phone': true,
    'Show Company Name': false,
    'Show Company Phone': false,
    'Show Additional Contact Name': false,
    'Show Additional Contact Phone': false,
    'Show Home Owner Name': false,
    'Show Home Owner Phone': false,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 1, color: AppColors.border),
        const SizedBox(height: 14),
        for (final entry in toggles.entries)
          _ToggleRow(
            label: entry.key,
            value: entry.value,
            onChanged: (v) => setState(() => toggles[entry.key] = v),
            labelColor: AppColors.link,
          ),
        const SizedBox(height: 14),
        Row(
          children: const [
            Text(
              'Next Client Notification Settings',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.accentBlue),
            ),
            SizedBox(width: 5),
            Icon(Icons.help_outline, size: 14, color: AppColors.blue),
          ],
        ),
        const SizedBox(height: 8),
        const _Dropdown(value: 'Default (Send as soon as photogr...'),
        const SizedBox(height: 18),
        _SaveButton(onPressed: () {}, fullWidth: true),
      ],
    );
  }
}

// ── PANEL 8: Calendar Event Settings ────────────────────────────────────
class _CalendarEventSettingsPanel extends StatelessWidget {
  const _CalendarEventSettingsPanel();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 1, color: AppColors.border),
        const SizedBox(height: 18),
        _FieldLabel(
          label: 'Calendar Mode',
          labelStyle: AppText.fieldLabel.copyWith(color: AppColors.amberLabel),
          child: const _Dropdown(value: 'Basic Mode'),
          helper: 'Contains the basic information needed for a particular appointment',
        ),
        const SizedBox(height: 18),
        _SaveButton(onPressed: () {}, fullWidth: true),
      ],
    );
  }
}