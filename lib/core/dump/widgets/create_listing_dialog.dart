// import 'package:flutter/material.dart';
// import 'package:insta_sign_tracker/core/utils/app_colors.dart';
// import '../models/listing.dart';
// import 'dashed_box.dart';
//
// class CreateListingDialog extends StatefulWidget {
//   const CreateListingDialog({super.key});
//
//   @override
//   State<CreateListingDialog> createState() => _CreateListingDialogState();
// }
//
// class _CreateListingDialogState extends State<CreateListingDialog> {
//   final _addressCtrl = TextEditingController();
//   final _priceCtrl = TextEditingController();
//   final _dateCtrl = TextEditingController();
//   final _shotByCtrl = TextEditingController();
//   final _agentCtrl = TextEditingController();
//   final _notesCtrl = TextEditingController();
//   bool _rushed = false;
//
//   @override
//   void dispose() {
//     _addressCtrl.dispose();
//     _priceCtrl.dispose();
//     _dateCtrl.dispose();
//     _shotByCtrl.dispose();
//     _agentCtrl.dispose();
//     _notesCtrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: const EdgeInsets.all(24),
//       child: Container(
//         width: 460,
//         padding: const EdgeInsets.all(22),
//         decoration: modalDecoration(),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 const Text('Create Listing', style: AppText.sectionHeader),
//                 const Spacer(),
//                 InkWell(
//                   onTap: () => Navigator.of(context).pop(),
//                   child: const Icon(Icons.close, size: 20, color: AppColors.textSecondary),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             const Divider(height: 1, color: AppColors.border),
//             const SizedBox(height: 18),
//             IntrinsicHeight(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Left: thumbnail upload + rushed toggle
//                   SizedBox(
//                     width: 150,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         DashedBox(
//                           radius: 8,
//                           child: SizedBox(
//                             height: 150,
//                             width: 150,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: const [
//                                 Icon(Icons.upload_outlined,
//                                     size: 26, color: AppColors.textMuted),
//                                 SizedBox(height: 8),
//                                 Text(
//                                   'Upload Thumbnail',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     fontSize: 12.5,
//                                     color: AppColors.textSecondary,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 14),
//                         Row(
//                           children: [
//                             Transform.scale(
//                               scale: 0.8,
//                               child: Switch(
//                                 value: _rushed,
//                                 activeColor: Colors.white,
//                                 activeTrackColor: AppColors.textPrimary,
//                                 onChanged: (v) => setState(() => _rushed = v),
//                               ),
//                             ),
//                             const SizedBox(width: 2),
//                             const Text('Rushed Order',
//                                 style: TextStyle(fontSize: 13, color: AppColors.textPrimary)),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 18),
//                   // Right: form fields
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         _labeledField('Address', _addressCtrl, hint: 'Enter property address...'),
//                         const SizedBox(height: 14),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: _labeledField('Listing Price', _priceCtrl,
//                                   hint: 'Enter price', keyboardType: TextInputType.number),
//                             ),
//                             const SizedBox(width: 12),
//                             Expanded(
//                               child: _labeledField('Date Shot', _dateCtrl, hint: 'mm/dd/yyyy'),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 14),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: _labeledField('Shot By', _shotByCtrl,
//                                   hint: 'Photographer'),
//                             ),
//                             const SizedBox(width: 12),
//                             Expanded(
//                               child: _labeledField('Agent / Client', _agentCtrl,
//                                   hint: 'Agent Name'),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 14),
//                         _labeledField('Tasks / Notes', _notesCtrl,
//                             hint: 'Any specific tasks...'),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 22),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                   child: const Text('Cancel',
//                       style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.w600)),
//                 ),
//                 const SizedBox(width: 8),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.blue,
//                     foregroundColor: Colors.white,
//                     elevation: 0,
//                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//                   ),
//                   onPressed: () {
//                     final listing = Listing(
//                       address: _addressCtrl.text.isEmpty
//                           ? 'New Listing'
//                           : _addressCtrl.text,
//                       listingPrice: double.tryParse(_priceCtrl.text) ?? 0,
//                       dateShot: _dateCtrl.text.isEmpty ? '—' : _dateCtrl.text,
//                       shotBy: _shotByCtrl.text.isEmpty ? '—' : _shotByCtrl.text,
//                       agentClient: _agentCtrl.text.isEmpty ? '—' : _agentCtrl.text,
//                       agentInitials: _agentCtrl.text.isNotEmpty
//                           ? _agentCtrl.text.trim()[0].toUpperCase()
//                           : '?',
//                       agentColor: AppColors.pink,
//                       rushed: _rushed,
//                       tasks: _notesCtrl.text.isEmpty ? 'N/A' : _notesCtrl.text,
//                     );
//                     Navigator.of(context).pop(listing);
//                   },
//                   child: const Text('Create Listing'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _labeledField(String label, TextEditingController controller,
//       {String? hint, TextInputType? keyboardType}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: AppText.fieldLabel),
//         const SizedBox(height: 6),
//         TextField(
//           controller: controller,
//           keyboardType: keyboardType,
//           style: const TextStyle(fontSize: 13),
//           decoration: inputDecoration(hint: hint),
//         ),
//       ],
//     );
//   }
// }
