// import 'package:flutter/material.dart';
// import 'package:insta_sign_tracker/core/utils/app_colors.dart';
// import '../main_admin/media/models/listing.dart';
// import '../main_admin/media/widgets/create_listing_dialog.dart';
// import '../main_admin/media/widgets/filter_panel.dart';
// import '../main_admin/media/widgets/send_email_dialog.dart';
// import '../main_admin/media/widgets/links_dialog.dart';
//
//
// class MediaDeliveryScreen extends StatefulWidget {
//   const MediaDeliveryScreen({super.key});
//
//   @override
//   State<MediaDeliveryScreen> createState() => _MediaDeliveryScreenState();
// }
//
// class _MediaDeliveryScreenState extends State<MediaDeliveryScreen> {
//   final List<Listing> _listings = [
//     Listing(
//       address: '309 Beard St, Decatur, AL 35601',
//       listingPrice: 175000,
//       dateShot: 'Jan 7, 2026 - CST',
//       shotBy: 'Trey Kelly',
//       agentClient: 'Tabitha Kontur',
//       agentInitials: 'TK',
//       agentColor: AppColors.pink,
//     ),
//   ];
//
//   final LayerLink _filterLink = LayerLink();
//   OverlayEntry? _filterOverlay;
//
//   void _openCreateListingDialog() async {
//     final result = await showDialog<Listing>(
//       context: context,
//       builder: (_) => const CreateListingDialog(),
//     );
//     if (result != null) {
//       setState(() => _listings.add(result));
//     }
//   }
//
//   void _toggleFilterPanel() {
//     if (_filterOverlay != null) {
//       _closeFilterPanel();
//       return;
//     }
//     final overlay = Overlay.of(context);
//     _filterOverlay = OverlayEntry(
//       builder: (context) {
//         return Stack(
//           children: [
//             // Tap-away scrim
//             Positioned.fill(
//               child: GestureDetector(
//                 behavior: HitTestBehavior.translucent,
//                 onTap: _closeFilterPanel,
//                 child: Container(color: Colors.transparent),
//               ),
//             ),
//             CompositedTransformFollower(
//               link: _filterLink,
//               showWhenUnlinked: false,
//               offset: const Offset(-190, 46),
//               child: FilterPanel(
//                 onClose: _closeFilterPanel,
//                 onApply: _closeFilterPanel,
//                 onClearAll: () {},
//               ),
//             ),
//           ],
//         );
//       },
//     );
//     overlay.insert(_filterOverlay!);
//   }
//
//   void _closeFilterPanel() {
//     _filterOverlay?.remove();
//     _filterOverlay = null;
//   }
//
//   void _openSendEmailDialog(Listing listing) {
//     showDialog(
//       context: context,
//       builder: (_) => SendEmailDialog(listing: listing),
//     );
//   }
//
//   void _openLinksDialog(Listing listing) {
//     showDialog(
//       context: context,
//       builder: (_) => LinksDialog(listingId: listing.address.hashCode.abs().toString()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(24),
//           child: Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: AppColors.cardBackground,
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: AppColors.border),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.03),
//                   blurRadius: 8,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _header(),
//                 const SizedBox(height: 16),
//                 const Divider(height: 1, color: AppColors.border),
//                 const SizedBox(height: 16),
//                 _toolbar(),
//                 const SizedBox(height: 20),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: SizedBox(
//                         width: 1220,
//                         child: _table(),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _header() {
//     return Row(
//       children: [
//         const Text('Media Delivery', style: AppText.title),
//         const Spacer(),
//         OutlinedButton.icon(
//           onPressed: () {},
//           style: OutlinedButton.styleFrom(
//             foregroundColor: AppColors.red,
//             side: const BorderSide(color: AppColors.red),
//             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//           ),
//           icon: const Icon(Icons.settings_outlined, size: 16),
//           label: const Text('Settings'),
//         ),
//       ],
//     );
//   }
//
//   Widget _toolbar() {
//     return Row(
//       children: [
//         ElevatedButton.icon(
//           onPressed: _openCreateListingDialog,
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppColors.blue,
//             foregroundColor: Colors.white,
//             elevation: 0,
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//           ),
//           icon: const Icon(Icons.add, size: 18),
//           label: const Text('Create Listing'),
//         ),
//         const SizedBox(width: 14),
//         Text(
//           'You have ${_listings.length} listing${_listings.length == 1 ? '' : 's'}',
//           style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
//         ),
//         const Spacer(),
//         CompositedTransformTarget(
//           link: _filterLink,
//           child: _iconBox(icon: Icons.tune, onTap: _toggleFilterPanel),
//         ),
//         const SizedBox(width: 10),
//         SizedBox(
//           width: 220,
//           child: TextField(
//             style: const TextStyle(fontSize: 13),
//             decoration: inputDecoration(hint: 'Search').copyWith(
//               prefixIcon: const Icon(Icons.search, size: 18, color: AppColors.textMuted),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _iconBox({required IconData icon, required VoidCallback onTap}) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(6),
//       child: Container(
//         width: 40,
//         height: 40,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           border: Border.all(color: AppColors.border),
//           borderRadius: BorderRadius.circular(6),
//         ),
//         child: Icon(icon, size: 18, color: AppColors.textSecondary),
//       ),
//     );
//   }
//
//   // ---- Table ----
//
//   static const double _wAddress = 260;
//   static const double _wThumb = 90;
//   static const double _wRushed = 70;
//   static const double _wPrice = 120;
//   static const double _wDate = 140;
//   static const double _wShotBy = 110;
//   static const double _wAgent = 170;
//   static const double _wStatus = 90;
//   static const double _wTasks = 70;
//   static const double _wActions = 110;
//
//   Widget _table() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             _headCell('Address', _wAddress),
//             _headCell('Thumbnail', _wThumb),
//             _headCell('Rushed', _wRushed),
//             _headCell('Listing Price', _wPrice),
//             _headCell('Date Shot', _wDate),
//             _headCell('Shot by', _wShotBy),
//             _headCell('Agent/Client', _wAgent),
//             _headCell('Status', _wStatus),
//             _headCell('Tasks', _wTasks),
//             _headCell('Actions', _wActions),
//           ],
//         ),
//         const SizedBox(height: 12),
//         const Divider(height: 1, color: AppColors.border),
//         for (final listing in _listings) ...[
//           const SizedBox(height: 14),
//           _row(listing),
//         ],
//         if (_listings.isEmpty) ...[
//           const SizedBox(height: 40),
//           const Center(
//             child: Text('No listings yet', style: AppText.cellMuted),
//           ),
//         ],
//       ],
//     );
//   }
//
//   Widget _headCell(String label, double width) {
//     return SizedBox(width: width, child: Text(label, style: AppText.columnHeader));
//   }
//
//   Widget _row(Listing listing) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         SizedBox(
//           width: _wAddress,
//           child: Text(listing.address, style: AppText.cell, overflow: TextOverflow.ellipsis),
//         ),
//         SizedBox(
//           width: _wThumb,
//           child: Container(
//             width: 60,
//             height: 40,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               color: const Color(0xFFF2F3F5),
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: const Text('No Image',
//                 style: TextStyle(fontSize: 9, color: AppColors.textMuted)),
//           ),
//         ),
//         SizedBox(
//           width: _wRushed,
//           child: listing.rushed
//               ? const Icon(Icons.flash_on, size: 16, color: AppColors.red)
//               : const SizedBox.shrink(),
//         ),
//         SizedBox(width: _wPrice, child: Text(listing.formattedPrice, style: AppText.cell)),
//         SizedBox(width: _wDate, child: Text(listing.dateShot, style: AppText.cell)),
//         SizedBox(
//           width: _wShotBy,
//           child: Text(listing.shotBy,
//               style: const TextStyle(fontSize: 13, color: AppColors.blueLink, fontWeight: FontWeight.w500)),
//         ),
//         SizedBox(
//           width: _wAgent,
//           child: Row(
//             children: [
//               CircleAvatar(
//                 radius: 12,
//                 backgroundColor: listing.agentColor,
//                 child: Text(
//                   listing.agentInitials,
//                   style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w700),
//                 ),
//               ),
//               const SizedBox(width: 6),
//               Expanded(
//                 child: Text(listing.agentClient,
//                     style: AppText.cell, overflow: TextOverflow.ellipsis),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           width: _wStatus,
//           child: Row(
//             children: [
//               if (listing.sentStatus)
//                 const Icon(Icons.send_outlined, size: 16, color: AppColors.green),
//               const SizedBox(width: 8),
//               if (listing.paidStatus)
//                 const Icon(Icons.attach_money, size: 16, color: AppColors.green),
//             ],
//           ),
//         ),
//         SizedBox(width: _wTasks, child: Text(listing.tasks, style: AppText.cellMuted)),
//         SizedBox(
//           width: _wActions,
//           child: Row(
//             children: [
//               _actionIcon(
//                 icon: Icons.description_outlined,
//                 onTap: () {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Opening documents...'), duration: Duration(seconds: 1)),
//                   );
//                 },
//               ),
//               const SizedBox(width: 6),
//               _actionIcon(
//                 icon: Icons.mail_outline,
//                 onTap: () => _openSendEmailDialog(listing),
//               ),
//               const SizedBox(width: 6),
//               _actionIcon(
//                 icon: Icons.more_vert,
//                 onTap: () => _openLinksDialog(listing),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _actionIcon({required IconData icon, required VoidCallback onTap}) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(4),
//       child: Padding(
//         padding: const EdgeInsets.all(4),
//         child: Icon(icon, size: 17, color: AppColors.red),
//       ),
//     );
//   }
// }
