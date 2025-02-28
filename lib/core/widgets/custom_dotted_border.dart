import 'dart:ui';

import 'package:flutter/material.dart';

class DottedBorderPainter extends CustomPainter {
  final Color color; // Border color
  final double strokeWidth; // Thickness of the border
  final double dashWidth; // Length of each dash
  final double dashSpace; // Gap between dashes

  DottedBorderPainter({
    required this.color,
    this.strokeWidth = 2.0,
    this.dashWidth = 6.0,
    this.dashSpace = 3.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Create the paint object to define the style
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // 2. Define the path for the border
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(
            0, 0, size.width, size.height), // Rectangle covering the size
        const Radius.circular(12), // Rounded corners
      ));

    // 3. Create a dashed path
    final dashPath = Path();
    PathMetric pathMetric = path.computeMetrics().first; // Measures the path
    double distance = 0.0; // Start at the beginning of the path

    while (distance < pathMetric.length) {
      // Extract the segment for the dash
      dashPath.addPath(
        pathMetric.extractPath(distance, distance + dashWidth),
        Offset.zero,
      );

      // Move the distance forward by dashWidth + dashSpace
      distance += dashWidth + dashSpace;
    }

    // 4. Draw the dashed path
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class CustomDottedBorder extends StatelessWidget {
  final Widget child;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final Color color;

  const CustomDottedBorder({
    required this.child,
    this.strokeWidth = 2.0,
    this.dashWidth = 6.0,
    this.dashSpace = 3.0,
    this.color = Colors.black,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DottedBorderPainter(
        color: color,
        strokeWidth: strokeWidth,
        dashWidth: dashWidth,
        dashSpace: dashSpace,
      ),
      child: Padding(
        padding: EdgeInsets.all(strokeWidth),
        child: child,
      ),
    );
  }
}
