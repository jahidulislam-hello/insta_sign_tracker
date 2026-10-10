import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../models/technician.dart';
import '../widgets/labeled_field.dart';

/// Shown when the user presses the edit (pencil) icon on a row.
/// Pre-fills every field from [technician] and returns the updated
/// technician via Navigator.pop when "Save Changes" is pressed.
class EditTechnicianDialog extends StatefulWidget {
  final Technician technician;
  const EditTechnicianDialog({super.key, required this.technician});

  @override
  State<EditTechnicianDialog> createState() => _EditTechnicianDialogState();
}

class _EditTechnicianDialogState extends State<EditTechnicianDialog> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _addressCtrl;
  late String _role;

  @override
  void initState() {
    super.initState();
    final t = widget.technician;
    _nameCtrl = TextEditingController(text: t.name);
    _emailCtrl = TextEditingController(text: t.email);
    _phoneCtrl = TextEditingController(text: t.phone);
    _addressCtrl = TextEditingController(text: t.address);
    _role = t.role.label;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
  }

  void _save() {
    final t = widget.technician;
    t.name = _nameCtrl.text.trim();
    t.email = _emailCtrl.text.trim();
    t.phone = _phoneCtrl.text.trim();
    t.address = _addressCtrl.text.trim();
    t.role = TechnicianRoleX.fromLabel(_role);
    Navigator.of(context).pop(t);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 22, 24, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Edit Technician',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.close, size: 22, color: AppColors.textSecondary),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              LabeledField(label: 'Name', controller: _nameCtrl),
              const SizedBox(height: 16),
              LabeledDropdown(
                label: 'Role',
                value: _role,
                items: const ['Installer', 'Photographer'],
                onChanged: (v) => setState(() => _role = v ?? _role),
              ),
              const SizedBox(height: 16),
              LabeledField(label: 'Email', controller: _emailCtrl, keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 16),
              LabeledField(label: 'Phone', controller: _phoneCtrl, keyboardType: TextInputType.phone),
              const SizedBox(height: 16),
              LabeledField(label: 'Address', controller: _addressCtrl),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close', style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Save Changes', style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
