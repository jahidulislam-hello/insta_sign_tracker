// import 'package:flutter/material.dart';
//
// /// Draws a dashed rounded-rectangle border around [child] without needing
// /// any third-party package.
// class DashedBox extends StatelessWidget {
//   final Widget child;
//   final double radius;
//   final Color color;
//   final double strokeWidth;
//
//   const DashedBox({
//     super.key,
//     required this.child,
//     this.radius = 8,
//     this.color = const Color(0xFFC7CBD1),
//     this.strokeWidth = 1.2,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: _DashedBorderPainter(
//         radius: radius,
//         color: color,
//         strokeWidth: strokeWidth,
//       ),
//       child: child,
//     );
//   }
// }
//
// class _DashedBorderPainter extends CustomPainter {
//   final double radius;
//   final Color color;
//   final double strokeWidth;
//
//   _DashedBorderPainter({
//     required this.radius,
//     required this.color,
//     required this.strokeWidth,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color
//       ..strokeWidth = strokeWidth
//       ..style = PaintingStyle.stroke;
//
//     final rrect = RRect.fromRectAndRadius(
//       Rect.fromLTWH(0, 0, size.width, size.height),
//       Radius.circular(radius),
//     );
//     final path = Path()..addRRect(rrect);
//     canvas.drawPath(_dashPath(path, dashArray: const [6, 4]), paint);
//   }
//
//   Path _dashPath(Path source, {required List<double> dashArray}) {
//     final Path dest = Path();
//     for (final metric in source.computeMetrics()) {
//       double distance = 0;
//       bool draw = true;
//       int i = 0;
//       while (distance < metric.length) {
//         final len = dashArray[i % dashArray.length];
//         if (draw) {
//           dest.addPath(
//             metric.extractPath(distance, distance + len),
//             Offset.zero,
//           );
//         }
//         distance += len;
//         draw = !draw;
//         i++;
//       }
//     }
//     return dest;
//   }
//
//   @override
//   bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) =>
//       oldDelegate.color != color ||
//       oldDelegate.radius != radius ||
//       oldDelegate.strokeWidth != strokeWidth;
// }
