import 'dart:math';

import 'package:flutter/material.dart';

class ExclureAreaPainter extends CustomPainter {
  final Color color;
  final Offset centerOfCircle;

  ExclureAreaPainter({required this.centerOfCircle, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawArc(
      Rect.fromCircle(center: centerOfCircle, radius: 150), //Offset(0, 670)
      (3 * pi) / 2,
      pi / 2,
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
