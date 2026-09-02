// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:insta_sign_tracker/core/utils/app_colors.dart';
//
//
// class LinksDialog extends StatelessWidget {
//   final String listingId;
//   const LinksDialog({super.key, required this.listingId});
//
//   @override
//   Widget build(BuildContext context) {
//     final base = 'https://media.rcinstapost.com';
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: const EdgeInsets.all(24),
//       child: Container(
//         width: 400,
//         padding: const EdgeInsets.all(20),
//         decoration: modalDecoration(),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 const Text('Links', style: AppText.sectionHeader),
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
//             _linkRow(context, 'Marketing Kit', '$base/m/$listingId'),
//             const SizedBox(height: 12),
//             _linkRow(context, 'Download Page', '$base/d/$listingId'),
//             const SizedBox(height: 14),
//             const Divider(height: 1, color: AppColors.border),
//             const SizedBox(height: 14),
//             const Text('Single Property Website', style: AppText.fieldLabel),
//             const SizedBox(height: 10),
//             _linkRow(context, 'Branded', '$base/s/$listingId', indent: true),
//             const SizedBox(height: 12),
//             _linkRow(context, 'Unbranded', '$base/u/$listingId', indent: true),
//             const SizedBox(height: 14),
//             const Divider(height: 1, color: AppColors.border),
//             const SizedBox(height: 14),
//             _linkRow(context, 'Property Owner Preview', '$base/h/$listingId'),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _linkRow(BuildContext context, String label, String url, {bool indent = false}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: AppText.fieldLabel),
//         const SizedBox(height: 6),
//         Row(
//           children: [
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFFAFAFB),
//                   borderRadius: BorderRadius.circular(6),
//                   border: Border.all(color: AppColors.border),
//                 ),
//                 child: Text(
//                   url,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 8),
//             _smallOutlinedButton(
//               icon: Icons.visibility_outlined,
//               label: 'View',
//               onTap: () {},
//             ),
//             const SizedBox(width: 6),
//             _smallOutlinedButton(
//               icon: Icons.copy_outlined,
//               label: 'Copy',
//               onTap: () {
//                 Clipboard.setData(ClipboardData(text: url));
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Link copied to clipboard'), duration: Duration(seconds: 1)),
//                 );
//               },
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _smallOutlinedButton({
//     required IconData icon,
//     required String label,
//     required VoidCallback onTap,
//   }) {
//     return OutlinedButton.icon(
//       onPressed: onTap,
//       style: OutlinedButton.styleFrom(
//         foregroundColor: AppColors.blue,
//         side: const BorderSide(color: AppColors.blue),
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//       ),
//       icon: Icon(icon, size: 14),
//       label: Text(label, style: const TextStyle(fontSize: 12)),
//     );
//   }
// }
