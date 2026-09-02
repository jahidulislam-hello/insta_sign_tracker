import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../models/technician.dart';


class RoleBadge extends StatelessWidget {
  final TechnicianRole role;
  const RoleBadge({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final isInstaller = role == TechnicianRole.installer;
    final bg = isInstaller ? AppColors.installerBg : AppColors.photographerBg;
    final fg = isInstaller ? AppColors.installerText : AppColors.photographerText;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        role.label,
        style: TextStyle(color: fg, fontSize: 12.5, fontWeight: FontWeight.w600),
      ),
    );
  }
}
