import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../models/technician.dart';
import '../widgets/labeled_field.dart';

/// Shown when the user presses "Add Technician" on the list screen.
/// Returns a new [Technician] via Navigator.pop when "Add" is pressed,
/// or null when closed/cancelled.
class AddTechnicianDialog extends StatefulWidget {
  const AddTechnicianDialog({super.key});

  @override
  State<AddTechnicianDialog> createState() => _AddTechnicianDialogState();
}

class _AddTechnicianDialogState extends State<AddTechnicianDialog> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  String? _role;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_nameCtrl.text.trim().isEmpty || _role == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in name and role.')),
      );
      return;
    }
    final technician = Technician(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      address: _addressCtrl.text.trim(),
      role: TechnicianRoleX.fromLabel(_role!),
    );
    Navigator.of(context).pop(technician);
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
                    'Add Technician',
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
              LabeledField(label: 'Email', controller: _emailCtrl, keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 16),
              LabeledDropdown(
                label: 'Role',
                value: _role,
                items: const ['Installer', 'Photographer'],
                onChanged: (v) => setState(() => _role = v),
              ),
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
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 13),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Add', style: TextStyle(fontWeight: FontWeight.w600)),
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
