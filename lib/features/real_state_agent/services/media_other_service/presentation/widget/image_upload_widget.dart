// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:file_picker/file_picker.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
//
// class ImageUploadWidget extends StatefulWidget {
//   final String label;
//   final String hintText;
//   final Function(List<File>)? onFilesSelected;
//   final List<File>? initialFiles;
//   final bool allowMultiple;
//   final bool allowPdf;
//   final bool allowVideo;
//
//   const ImageUploadWidget({
//     super.key,
//     this.label = 'Upload Image',
//     this.hintText = 'Upload Image',
//     this.onFilesSelected,
//     this.initialFiles,
//     this.allowMultiple = true,
//     this.allowPdf = true,
//     this.allowVideo = true,
//   });
//
//   @override
//   State<ImageUploadWidget> createState() => _ImageUploadWidgetState();
// }
//
// class _ImageUploadWidgetState extends State<ImageUploadWidget> {
//   final ImagePicker _imagePicker = ImagePicker();
//   List<File> selectedFiles = [];
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.initialFiles != null) {
//       selectedFiles = List.from(widget.initialFiles!);
//     }
//   }
//
//   // Image picker from camera ✅
//   Future<void> _pickImageFromCamera() async {
//     try {
//       final XFile? pickedFile = await _imagePicker.pickImage(
//         source: ImageSource.camera,
//         imageQuality: 80,
//       );
//
//       if (pickedFile != null) {
//         setState(() {
//           selectedFiles.add(File(pickedFile.path));
//         });
//         widget.onFilesSelected?.call(selectedFiles);
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to pick image from camera: $e',
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }
//
//   // Image picker from gallery ✅ (Updated for new version)
//   Future<void> _pickImageFromGallery() async {
//     try {
//       if (widget.allowMultiple) {
//         // ✅ pickMultiImage for new version
//         final List<XFile> pickedFiles = await _imagePicker.pickMultiImage(
//           imageQuality: 80,
//           limit: 10, // Maximum 10 images
//         );
//
//         if (pickedFiles.isNotEmpty) {
//           setState(() {
//             selectedFiles.addAll(
//               pickedFiles.map((file) => File(file.path)),
//             );
//           });
//           widget.onFilesSelected?.call(selectedFiles);
//         }
//       } else {
//         final XFile? pickedFile = await _imagePicker.pickImage(
//           source: ImageSource.gallery,
//           imageQuality: 80,
//         );
//
//         if (pickedFile != null) {
//           setState(() {
//             selectedFiles = [File(pickedFile.path)];
//           });
//           widget.onFilesSelected?.call(selectedFiles);
//         }
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to pick image from gallery: $e',
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }
//
//   // File picker - PDF, Documents ✅ (Updated for new version)
//   Future<void> _pickFile() async {
//     try {
//       // ✅ Using FilePicker.instance for new version
//       FilePickerResult? result = await FilePicker.instance.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
//         allowMultiple: widget.allowMultiple,
//       );
//
//       if (result != null && result.files.isNotEmpty) {
//         setState(() {
//           for (var file in result.files) {
//             if (file.path != null) {
//               selectedFiles.add(File(file.path!));
//             }
//           }
//         });
//         widget.onFilesSelected?.call(selectedFiles);
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to pick file: $e',
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }
//
//   // Delete file
//   void _deleteFile(int index) {
//     setState(() {
//       selectedFiles.removeAt(index);
//     });
//     widget.onFilesSelected?.call(selectedFiles);
//   }
//
//   // Show file picker bottom sheet
//   void _showFilePickerBottomSheet() {
//     Get.bottomSheet(
//       Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20.r),
//             topRight: Radius.circular(20.r),
//           ),
//         ),
//         padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Header
//               Text(
//                 'Select File',
//                 style: TextStyle(
//                   fontSize: 18.h,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black,
//                 ),
//               ),
//               SizedBox(height: 20.h),
//
//               // Camera option
//               GestureDetector(
//                 onTap: () {
//                   Get.back();
//                   _pickImageFromCamera();
//                 },
//                 child: _buildPickerOption(
//                   icon: Icons.camera_alt_outlined,
//                   title: 'Take Photo',
//                   subtitle: 'Capture with camera',
//                 ),
//               ),
//
//               SizedBox(height: 12.h),
//
//               // Gallery option
//               GestureDetector(
//                 onTap: () {
//                   Get.back();
//                   _pickImageFromGallery();
//                 },
//                 child: _buildPickerOption(
//                   icon: Icons.image_outlined,
//                   title: 'Choose from Gallery',
//                   subtitle: 'Select from your photos',
//                 ),
//               ),
//
//               SizedBox(height: 12.h),
//
//               // File picker option
//               GestureDetector(
//                 onTap: () {
//                   Get.back();
//                   _pickFile();
//                 },
//                 child: _buildPickerOption(
//                   icon: Icons.file_present_outlined,
//                   title: 'Choose File',
//                   subtitle: 'PDF, Documents, Images',
//                 ),
//               ),
//
//               SizedBox(height: 12.h),
//
//               // Cancel button
//               GestureDetector(
//                 onTap: () => Get.back(),
//                 child: Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.symmetric(vertical: 14.h),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(10.r),
//                   ),
//                   child: Center(
//                     child: Text(
//                       'Cancel',
//                       style: TextStyle(
//                         fontSize: 16.h,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//
//               SizedBox(height: 10.h),
//             ],
//           ),
//         ),
//       ),
//       isScrollControlled: true,
//     );
//   }
//
//   // Build picker option widget ✅ (Updated withValues)
//   Widget _buildPickerOption({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//   }) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
//       decoration: BoxDecoration(
//         // ✅ Updated to withValues
//         color: Colors.blue.withValues(alpha: 0.1),
//         borderRadius: BorderRadius.circular(12.r),
//         border: Border.all(color: Colors.blue, width: 1),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 50.w,
//             height: 50.h,
//             decoration: BoxDecoration(
//               color: Colors.blue,
//               borderRadius: BorderRadius.circular(10.r),
//             ),
//             child: Icon(
//               icon,
//               color: Colors.white,
//               size: 24,
//             ),
//           ),
//           SizedBox(width: 12.w),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 16.h,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black,
//                 ),
//               ),
//               SizedBox(height: 4.h),
//               Text(
//                 subtitle,
//                 style: TextStyle(
//                   fontSize: 13.h,
//                   color: Colors.grey[600],
//                 ),
//               ),
//             ],
//           ),
//           const Spacer(),
//           Icon(
//             Icons.arrow_forward_ios,
//             color: Colors.blue,
//             size: 18,
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Get file extension
//   String _getFileExtension(String path) {
//     return path.split('.').last.toUpperCase();
//   }
//
//   // Get file icon based on extension
//   IconData _getFileIcon(String path) {
//     final ext = path.split('.').last.toLowerCase();
//     if (['jpg', 'jpeg', 'png', 'gif'].contains(ext)) {
//       return Icons.image_outlined;
//     } else if (ext == 'pdf') {
//       return Icons.picture_as_pdf_outlined;
//     } else {
//       return Icons.file_present_outlined;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 16.h),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (widget.label.isNotEmpty)
//             Text(
//               widget.label,
//               style: TextStyle(
//                 fontSize: 14.h,
//                 color: Colors.black,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           if (widget.label.isNotEmpty) SizedBox(height: 8.h),
//
//           // Upload button
//           GestureDetector(
//             onTap: _showFilePickerBottomSheet,
//             child: Container(
//               width: double.infinity,
//               padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.grey[300]!,
//                   width: 2,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.grey[50],
//               ),
//               child: Column(
//                 children: [
//                   Icon(
//                     Icons.cloud_upload_outlined,
//                     size: 40,
//                     color: Colors.blue,
//                   ),
//                   SizedBox(height: 8.h),
//                   Text(
//                     widget.hintText,
//                     style: TextStyle(
//                       fontSize: 14.h,
//                       color: Colors.blue,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   SizedBox(height: 4.h),
//                   Text(
//                     'Tap to upload',
//                     style: TextStyle(
//                       fontSize: 12.h,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           // Files list
//           if (selectedFiles.isNotEmpty)
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 16.h),
//                 Text(
//                   'Selected Files (${selectedFiles.length})',
//                   style: TextStyle(
//                     fontSize: 13.h,
//                     color: Colors.black,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 SizedBox(height: 8.h),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: selectedFiles.length,
//                   itemBuilder: (context, index) {
//                     final file = selectedFiles[index];
//                     final fileName = file.path.split('/').last;
//                     final fileExt = _getFileExtension(file.path);
//                     final fileIcon = _getFileIcon(file.path);
//
//                     return Container(
//                       margin: EdgeInsets.only(bottom: 8.h),
//                       padding: EdgeInsets.all(12.w),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[50],
//                         borderRadius: BorderRadius.circular(8.r),
//                         border: Border.all(
//                           color: Colors.grey[200]!,
//                           width: 1,
//                         ),
//                       ),
//                       child: Row(
//                         children: [
//                           // File icon
//                           Container(
//                             width: 40.w,
//                             height: 40.h,
//                             decoration: BoxDecoration(
//                               // ✅ Updated to withValues
//                               color: Colors.blue.withValues(alpha: 0.1),
//                               borderRadius: BorderRadius.circular(6.r),
//                             ),
//                             child: Icon(
//                               fileIcon,
//                               color: Colors.blue,
//                               size: 20,
//                             ),
//                           ),
//                           SizedBox(width: 12.w),
//
//                           // File info
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   fileName,
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: TextStyle(
//                                     fontSize: 13.h,
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                                 SizedBox(height: 2.h),
//                                 Text(
//                                   fileExt,
//                                   style: TextStyle(
//                                     fontSize: 11.h,
//                                     color: Colors.grey[600],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//
//                           // Delete button
//                           GestureDetector(
//                             onTap: () => _deleteFile(index),
//                             child: Container(
//                               padding: EdgeInsets.all(8.w),
//                               decoration: BoxDecoration(
//                                 // ✅ Updated to withValues
//                                 color: Colors.red.withValues(alpha: 0.1),
//                                 borderRadius: BorderRadius.circular(6.r),
//                               ),
//                               child: Icon(
//                                 Icons.close,
//                                 color: Colors.red,
//                                 size: 18,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//         ],
//       ),
//     );
//   }
// }