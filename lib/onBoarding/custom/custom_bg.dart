import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class OnBoardingBackground extends CustomPainter {
  OnBoardingBackground({
    this.firstColor,
    this.secondColor,
  });

  final Color? firstColor;
  final Color? secondColor;

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;
    final widthItem = size.width / 3;

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4
      ..shader = ui.Gradient.linear(
        Offset(size.width / 2, 0),
        Offset(size.width / 2, size.height),
        [firstColor ?? Colors.blueGrey.shade900, secondColor ?? Colors.greenAccent.shade200],
      );

    final path = Path()
      ..moveTo(width * 0.04, height * 0.45)
      ..quadraticBezierTo(widthItem * 0.25, height * 0.58, widthItem * 0.5, height * 0.4)
      ..quadraticBezierTo(widthItem * 0.7, height * 0.22, widthItem * 0.78, height * 0.3)
      ..quadraticBezierTo(widthItem * 0.8, height * 0.4, widthItem, height * 0.5)
      ..quadraticBezierTo((widthItem * 2) * 0.75, height * 0.73, widthItem * 2, height * 0.5)
      ..quadraticBezierTo(width * 0.8, height * 0.25, width * 0.85, height * 0.4)
      ..quadraticBezierTo(width * 0.87, height * 0.5, width * 0.92, height * 0.5)
      ..quadraticBezierTo(width * 1, height * 0.5, width * 0.95, height * 0.35)
      ..quadraticBezierTo(width * 0.9, height * 0.2, width * 0.8, height * 0.15)
      ..quadraticBezierTo(width * 0.72, height * 0.12, widthItem * 2, height * 0.2)
      ..quadraticBezierTo(widthItem * 1.9, height * 0.24, widthItem * 1.86, height * 0.28)
      ..quadraticBezierTo(widthItem * 1.5, height * 0.6, widthItem * 1.14, height * 0.28)
      ..quadraticBezierTo(widthItem * 1.1, height * 0.24, widthItem, height * 0.2)
      ..quadraticBezierTo(widthItem * 0.7, height * 0.1, widthItem * 0.4, height * 0.2)
      ..quadraticBezierTo(widthItem * 0.05, height * 0.33, width * 0.04, height * 0.45);

    canvas.drawShadow(path, const Color(0xffF52C6A), 30, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
