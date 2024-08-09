import 'dart:math';

import 'package:flutter/material.dart';

class EditAreaPainter extends CustomPainter {
  final Color color;
  final Offset centerOfCircle;

  EditAreaPainter({required this.centerOfCircle, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawArc(
      Rect.fromCircle(center: centerOfCircle, radius: 120), //Offset(0, 670)
      pi,
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
