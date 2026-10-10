// import 'package:flutter/material.dart';
// import 'package:insta_sign_tracker/core/utils/app_colors.dart';
// import '../models/listing.dart';
//
// class SendEmailDialog extends StatefulWidget {
//   final Listing listing;
//   const SendEmailDialog({super.key, required this.listing});
//
//   @override
//   State<SendEmailDialog> createState() => _SendEmailDialogState();
// }
//
// class _SendEmailDialogState extends State<SendEmailDialog> {
//   late final TextEditingController _subjectCtrl;
//   final _fromNameCtrl = TextEditingController();
//   final _replyToCtrl = TextEditingController();
//   final _recipientsCtrl = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _subjectCtrl = TextEditingController(text: 'Media for ${widget.listing.address}');
//   }
//
//   @override
//   void dispose() {
//     _subjectCtrl.dispose();
//     _fromNameCtrl.dispose();
//     _replyToCtrl.dispose();
//     _recipientsCtrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: const EdgeInsets.all(24),
//       child: Container(
//         width: 360,
//         padding: const EdgeInsets.all(20),
//         decoration: modalDecoration(),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 const Text('Send Email', style: AppText.sectionHeader),
//                 const Spacer(),
//                 InkWell(
//                   onTap: () => Navigator.of(context).pop(),
//                   child: const Icon(Icons.close, size: 20, color: AppColors.textSecondary),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             const Divider(height: 1, color: AppColors.border),
//             const SizedBox(height: 16),
//             const Text('Email Template', style: AppText.fieldLabel),
//             const SizedBox(height: 6),
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(6),
//                 border: Border.all(color: AppColors.blue, width: 1.2),
//               ),
//               child: Row(
//                 children: const [
//                   Expanded(
//                     child: Text(
//                       'Media Ready (Client Delivery Email) - Spiro Default',
//                       style: TextStyle(fontSize: 12.5, color: AppColors.textPrimary),
//                     ),
//                   ),
//                   Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.textMuted),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 14),
//             _amberLabeledField('Email Subject', _subjectCtrl),
//             const SizedBox(height: 12),
//             _amberLabeledField('Send From Name', _fromNameCtrl, hint: 'Enter here.'),
//             const SizedBox(height: 12),
//             _amberLabeledField('Reply-to Email Address', _replyToCtrl, hint: 'Enter here'),
//             const SizedBox(height: 12),
//             _amberLabeledField('Additional Recipients', _recipientsCtrl, hint: 'Enter here'),
//             const SizedBox(height: 18),
//             Align(
//               alignment: Alignment.centerRight,
//               child: ElevatedButton.icon(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Email sent successfully')),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.blue,
//                   foregroundColor: Colors.white,
//                   elevation: 0,
//                   padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//                 ),
//                 icon: const Icon(Icons.send, size: 16),
//                 label: const Text('Send Email'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _amberLabeledField(String label, TextEditingController controller, {String? hint}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label,
//             style: const TextStyle(
//                 fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.amberLabel)),
//         const SizedBox(height: 6),
//         TextField(
//           controller: controller,
//           style: const TextStyle(fontSize: 13),
//           decoration: inputDecoration(hint: hint),
//         ),
//       ],
//     );
//   }
// }
