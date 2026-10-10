import 'package:flutter/material.dart';

/// Dependency-free dashed rounded-rectangle border, used by every
/// "Click / drag & drop to upload image" box across the app.
class DashedBox extends StatelessWidget {
  final Widget child;
  final double radius;
  final Color color;
  final double strokeWidth;

  const DashedBox({
    super.key,
    required this.child,
    this.radius = 10,
    this.color = const Color(0xFFC7CBD1),
    this.strokeWidth = 1.3,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(radius: radius, color: color, strokeWidth: strokeWidth),
      child: child,
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final double radius;
  final Color color;
  final double strokeWidth;

  _DashedBorderPainter({required this.radius, required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );
    final path = Path()..addRRect(rrect);
    canvas.drawPath(_dashPath(path, dashArray: const [6, 4]), paint);
  }

  Path _dashPath(Path source, {required List<double> dashArray}) {
    final Path dest = Path();
    for (final metric in source.computeMetrics()) {
      double distance = 0;
      bool draw = true;
      int i = 0;
      while (distance < metric.length) {
        final len = dashArray[i % dashArray.length];
        if (draw) {
          dest.addPath(metric.extractPath(distance, distance + len), Offset.zero);
        }
        distance += len;
        draw = !draw;
        i++;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.radius != radius || oldDelegate.strokeWidth != strokeWidth;
}

/// The "Click to upload image" / "Upload category icon image" box body,
/// reused by every dialog that needs an image upload placeholder.
class ImageUploadBox extends StatelessWidget {
  final String title;
  final String? subtitle;
  final double height;
  final VoidCallback? onTap;
  final String? fileName;

  const ImageUploadBox({
    super.key,
    this.title = 'Click to upload image',
    this.subtitle = 'PNG, JPG, WEBP',
    this.height = 130,
    this.onTap,
    this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: DashedBox(
        child: SizedBox(
          width: double.infinity,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(color: Color(0xFFEDEEF1), shape: BoxShape.circle),
                child: const Icon(Icons.upload_outlined, size: 16, color: Color(0xFF6B7280)),
              ),
              const SizedBox(height: 10),
              Text(
                fileName ?? title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: Color(0xFF4B5563)),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(subtitle!,
                    style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
