import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';



class InvoicingSettingsScreen extends StatefulWidget {
  const InvoicingSettingsScreen({super.key});

  @override
  State<InvoicingSettingsScreen> createState() =>
      _InvoicingSettingsScreenState();
}

class _InvoicingSettingsScreenState extends State<InvoicingSettingsScreen> {
  int? _expandedIndex = 0;

  void _toggle(int index) {
    setState(() {
      _expandedIndex = _expandedIndex == index ? null : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 980),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Breadcrumb(),
                const SizedBox(height: 14),
                const Text('Invoicing Settings', style: AppText.h1),
                const SizedBox(height: 6),
                const Text(
                  'Configure reschedule fees, invoicing terms, agent and company delivery '
                      'buffers, payment plans, and custom invoicing cycles.',
                  style: AppText.pageSubtitle,
                ),
                const SizedBox(height: 22),
                _ExpandableSection(
                  title: 'General',
                  isExpanded: _expandedIndex == 0,
                  onTap: () => _toggle(0),
                  child: const _GeneralPanel(),
                ),
                const SizedBox(height: 16),
                _ExpandableSection(
                  title: 'Sales Taxes',
                  isExpanded: _expandedIndex == 1,
                  onTap: () => _toggle(1),
                  child: const _SalesTaxesPanel(),
                ),
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
        Text('Settings', style: linkStyle),
        Text('  /  ', style: sepStyle),
        Text('Invoicing', style: activeStyle),
      ],
    );
  }
}

// ── Reusable expandable card ──────────────────────────────────────────────
class _ExpandableSection extends StatelessWidget {
  final String title;
  final bool isExpanded;
  final VoidCallback onTap;
  final Widget child;

  const _ExpandableSection({
    required this.title,
    required this.isExpanded,
    required this.onTap,
    required this.child,
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
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: AppText.cardTitle),
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
          // AnimatedCrossFade is what actually fixes "tap but content
          // doesn't show" — the body stays in the tree and is measured /
          // animated open instead of being silently omitted.
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity, height: 0),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
              child: child,
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

// ── GENERAL panel content ─────────────────────────────────────────────────
class _GeneralPanel extends StatefulWidget {
  const _GeneralPanel();
  @override
  State<_GeneralPanel> createState() => _GeneralPanelState();
}

class _GeneralPanelState extends State<_GeneralPanel> {
  bool includeAddress = true;
  bool includePhone = true;
  bool includeEmail = true;
  bool allowSplitPayments = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 1, color: AppColors.border),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _FieldLabel(
                label: 'Do you charge for Reschedules/Cancellations?',
                labelStyle: AppText.fieldLabel,
                hasHelp: true,
                child: const _Dropdown(value: 'No'),
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              child: _FieldLabel(
                label: 'Invoice Terms',
                labelStyle: AppText.fieldLabel.copyWith(color: AppColors.amberLabel),
                child: const _Dropdown(value: '30 Days'),
                helper:
                'For example: Net 0 - Due Upon Receipt of Invoice, Net 30 - '
                    'Due 30 Days after Receipt of Invoice',
              ),
            ),
          ],
        ),
        const SizedBox(height: 26),
        Row(
          children: const [
            Expanded(child: Text('AGENT SETTINGS', style: AppText.sectionLabel)),
            SizedBox(width: 40),
            Expanded(child: Text('COMPANY SETTINGS', style: AppText.sectionLabel)),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _FieldLabel(
                label: 'Default Agent Payment Plan',
                labelStyle: AppText.fieldLabel.copyWith(color: AppColors.amberLabel),
                badge: 'IMPORTANT',
                child: const _Dropdown(value: 'Pay Before Order Submission'),
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              child: _FieldLabel(
                label: 'Default Company Payment Plan',
                labelStyle: AppText.fieldLabel.copyWith(color: AppColors.amberLabel),
                child: const _Dropdown(value: 'Invoice Monthly'),
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
                label: 'Agent Invoicing Preference',
                labelStyle: AppText.fieldLabel.copyWith(color: AppColors.accentBlue),
                hasHelp: true,
                child: const _Dropdown(
                  value: 'Always create a separate invoice for each order (do not group)',
                  enabled: false,
                ),
                helper:
                'This has been disabled because of your selected default payment plan for agents.',
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              child: _FieldLabel(
                label: 'Company Invoicing Preference',
                labelStyle: AppText.fieldLabel.copyWith(color: AppColors.accentBlue),
                hasHelp: true,
                child: const _Dropdown(
                  value: 'Always create one invoice and group orders for the billing period',
                ),
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
                label: 'Invoice Delivery Window (Agent)',
                labelStyle: AppText.fieldLabel.copyWith(color: AppColors.accentBlue),
                child: const _TextInput(value: '0'),
                helper:
                'Minimum number of days between appointment completion and when an '
                    'order is ready to be invoiced to an agent. Agent invoices are created '
                    'on Tuesdays for all orders that are ready to be invoiced at the start '
                    'of the week. This gives you a buffer in case you need to modify any '
                    'details of the order.',
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              child: _FieldLabel(
                label: 'Invoice Delivery Window (Company)',
                labelStyle: AppText.fieldLabel.copyWith(color: AppColors.accentBlue),
                child: const _TextInput(value: '0'),
                helper:
                'Minimum number of days between appointment completion and when an '
                    'order is ready to be invoiced to a company. Company invoices are '
                    'created on the last of the month for all orders that are ready to be '
                    'invoiced. This gives you a buffer in case you need to modify any '
                    'details of the order.',
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
                label: 'Custom Invoicing Dates for Agents',
                labelStyle: AppText.fieldLabel,
                child: const _LinkAddRow(label: 'Agent Invoicing Dates'),
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              child: _FieldLabel(
                label: 'Custom Invoicing Dates for Companies',
                labelStyle: AppText.fieldLabel,
                child: const _LinkAddRow(label: 'Company Invoicing Dates'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(
              child: _ReminderScheduleCard(
                title: 'Agent Invoice Reminder Schedule',
                before: 'Weekly (7 days)',
                after: 'Weekly (7 days)',
              ),
            ),
            SizedBox(width: 40),
            Expanded(
              child: _ReminderScheduleCard(
                title: 'Company Invoice Reminder Schedule',
                before: 'Fortnightly (14 days)',
                after: 'Fortnightly (14 days)',
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _FieldLabel(
                label: 'Invoice PDF - Additional Company Information',
                labelStyle: AppText.fieldLabel,
                child: const _TextInput(
                  value: '',
                  hint: 'Enter Here (e.g. Company Number/VAT Number etc.)',
                ),
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              child: _FieldLabel(
                label: 'Invoice PDF - Memo/Note',
                labelStyle: AppText.fieldLabel,
                child: const _TextInput(value: '', hint: 'Enter Here'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        const Text('Invoice PDF Options', style: AppText.cardTitle),
        const SizedBox(height: 4),
        const Text(
          'Note: Any changes will only apply to invoices created after the changes '
              'have been saved',
          style: AppText.descriptionText,
        ),
        const SizedBox(height: 10),
        _ToggleRow(
          label: 'Include Business Address on Invoice PDFs',
          value: includeAddress,
          onChanged: (v) => setState(() => includeAddress = v),
        ),
        _ToggleRow(
          label: 'Include Business Phone Number on Invoice PDFs',
          value: includePhone,
          onChanged: (v) => setState(() => includePhone = v),
        ),
        _ToggleRow(
          label: 'Include Business Email Address on Invoice PDFs',
          value: includeEmail,
          onChanged: (v) => setState(() => includeEmail = v),
        ),
        const SizedBox(height: 18),
        _FieldLabel(
          label: 'Invoice Numbers start from',
          labelStyle: AppText.fieldLabel,
          child: const _TextInput(value: '0'),
          helper:
          'Define the number from which you would like your invoices to start '
              'from. By default they will start from 0.',
          maxWidth: 460,
        ),
        const SizedBox(height: 18),
        _ToggleRow(
          label: 'Allow agents to split payments',
          value: allowSplitPayments,
          onChanged: (v) => setState(() => allowSplitPayments = v),
        ),
        const SizedBox(height: 22),
        Align(alignment: Alignment.centerRight, child: _SaveButton(onPressed: () {})),
      ],
    );
  }
}

// ── SALES TAXES panel content ─────────────────────────────────────────────
class _SalesTaxesPanel extends StatefulWidget {
  const _SalesTaxesPanel();
  @override
  State<_SalesTaxesPanel> createState() => _SalesTaxesPanelState();
}

class _SalesTaxesPanelState extends State<_SalesTaxesPanel> {
  bool regionActive = true;
  bool previewEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 1, color: AppColors.border),
        const SizedBox(height: 18),
        const Text('Tax Regions', style: AppText.cardTitle),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.tableHeaderBg,
            borderRadius: BorderRadius.circular(AppColors.radiusSm),
          ),
          child: const Row(
            children: [
              Expanded(flex: 3, child: Text('TAX REGION', style: AppText.columnHeader)),
              Expanded(flex: 3, child: Text('INTERNAL NAME', style: AppText.columnHeader)),
              Expanded(flex: 3, child: Text('REGION NAME', style: AppText.columnHeader)),
              Expanded(flex: 3, child: Text('TAX TYPE', style: AppText.columnHeader)),
              Expanded(flex: 2, child: Text('TAX RATE (%)', style: AppText.columnHeader)),
              Expanded(flex: 2, child: Text('ACTIVE', style: AppText.columnHeader)),
              SizedBox(width: 60, child: Text('ACTION', style: AppText.columnHeader)),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(flex: 3, child: _Dropdown(value: 'Select')),
            const SizedBox(width: 8),
            const Expanded(flex: 3, child: _TextInput(value: '', hint: 'e.g. State Sales Tax')),
            const SizedBox(width: 8),
            const Expanded(
              flex: 3,
              child: _TextInput(value: '', hint: 'Search Here', icon: Icons.search),
            ),
            const SizedBox(width: 8),
            const Expanded(flex: 3, child: _Dropdown(value: 'Select')),
            const SizedBox(width: 8),
            const Expanded(flex: 2, child: _TextInput(value: '0.00')),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: Center(
                child: Switch(
                  value: regionActive,
                  onChanged: (v) => setState(() => regionActive = v),
                  activeColor: AppColors.white,
                  activeTrackColor: AppColors.blue,
                  inactiveTrackColor: AppColors.toggleOffTrack,
                ),
              ),
            ),
            SizedBox(
              width: 60,
              child: Center(
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: AppColors.blueIconBg,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, size: 16, color: AppColors.blue),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 26),
        const Divider(height: 1, color: AppColors.border),
        const SizedBox(height: 18),
        const Text('Sales Tax Configuration', style: AppText.cardTitle),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _FieldLabel(
                label: 'Tax label preference',
                labelStyle: AppText.fieldLabel,
                child: const _TextInput(value: 'Tax'),
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              child: _FieldLabel(
                label: 'Select which address to use for sales tax',
                labelStyle: AppText.fieldLabel,
                child: const _Dropdown(value: 'Listing Address'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.panelFill,
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(AppColors.radiusMd),
          ),
          child: _ToggleRow(
            label: 'Enable Sales Tax Preview in Order Portal',
            value: previewEnabled,
            onChanged: (v) => setState(() => previewEnabled = v),
            dense: true,
          ),
        ),
        const SizedBox(height: 20),
        Align(alignment: Alignment.centerRight, child: _SaveButton(onPressed: () {})),
      ],
    );
  }
}

// ── Shared small widgets ───────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  final String label;
  final TextStyle labelStyle;
  final Widget child;
  final String? helper;
  final bool hasHelp;
  final String? badge;
  final double? maxWidth;

  const _FieldLabel({
    required this.label,
    required this.labelStyle,
    required this.child,
    this.helper,
    this.hasHelp = false,
    this.badge,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(child: Text(label, style: labelStyle)),
            if (hasHelp) ...[
              const SizedBox(width: 5),
              const Icon(Icons.help_outline, size: 13, color: AppColors.textMuted),
            ],
            if (badge != null) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.totalBadgeBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  badge!,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: AppColors.totalBadgeText,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
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
    return maxWidth != null
        ? ConstrainedBox(constraints: BoxConstraints(maxWidth: maxWidth!), child: content)
        : content;
  }
}

class _Dropdown extends StatelessWidget {
  final String value;
  final bool enabled;
  const _Dropdown({required this.value, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: enabled ? AppColors.inputFillLight : AppColors.inputFill,
        borderRadius: BorderRadius.circular(AppColors.radiusSm),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: AppText.cell.copyWith(
                color: enabled ? AppColors.textPrimary : AppColors.textMuted,
              ),
            ),
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
  final IconData? icon;
  const _TextInput({required this.value, this.hint, this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: TextField(
        controller: TextEditingController(text: value),
        style: AppText.cell,
        decoration: boxedInputDecoration(hint: hint).copyWith(
          prefixIcon: icon != null
              ? Icon(icon, size: 15, color: AppColors.textMuted)
              : null,
          prefixIconConstraints: const BoxConstraints(minWidth: 34, minHeight: 0),
        ),
      ),
    );
  }
}

class _LinkAddRow extends StatelessWidget {
  final String label;
  const _LinkAddRow({required this.label});
  @override
  Widget build(BuildContext context) {
    const linkStyle = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: AppColors.link,
    );
    return Row(
      children: [
        Text(label, style: linkStyle),
        const Spacer(),
        Row(
          children: const [
            Text('Add', style: linkStyle),
            SizedBox(width: 3),
            Icon(Icons.add, size: 15, color: AppColors.link),
          ],
        ),
      ],
    );
  }
}

class _ReminderScheduleCard extends StatelessWidget {
  final String title;
  final String before;
  final String after;
  const _ReminderScheduleCard({
    required this.title,
    required this.before,
    required this.after,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.panelFill,
        borderRadius: BorderRadius.circular(AppColors.radiusMd),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppText.cardTitle.copyWith(fontSize: 12.5)),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('BEFORE DUE DATE', style: AppText.sectionLabel),
                    const SizedBox(height: 6),
                    _Dropdown(value: before),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('AFTER DUE DATE', style: AppText.sectionLabel),
                    const SizedBox(height: 6),
                    _Dropdown(value: after),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool dense;
  const _ToggleRow({
    required this.label,
    required this.value,
    required this.onChanged,
    this.dense = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: dense ? 0 : 6),
      child: Row(
        children: [
          Transform.scale(
            scale: 0.85,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.white,
              activeTrackColor: AppColors.blue,
              inactiveTrackColor: AppColors.toggleOffTrack,
            ),
          ),
          const SizedBox(width: 4),
          Text(label, style: AppText.optionTitle.copyWith(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _SaveButton({required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.blue,
        foregroundColor: AppColors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 13),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppColors.radiusSm),
        ),
      ),
      child: const Text(
        'Save Changes',
        style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600),
      ),
    );
  }
}