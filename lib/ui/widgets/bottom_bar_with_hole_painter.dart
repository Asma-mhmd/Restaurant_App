import 'dart:ui';

import 'package:flutter/material.dart';

class BottomBarWithHolePainter extends CustomPainter {
  final Color color;
  final double notchWidth;
  final double notchHeight;
  final double cornerRadius;

  BottomBarWithHolePainter({
    required this.color,
    required this.notchWidth,
    required this.notchHeight,
    required this.cornerRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.fillType = PathFillType.evenOdd;
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final notchPath = Path();
    final center = Offset(size.width / 2, size.height / 2);

    final notchRect = Rect.fromCenter(
      center: center,
      width: notchWidth,
      height: notchHeight,
    );

    notchPath.moveTo(notchRect.left, notchRect.top);
    notchPath.lineTo(notchRect.right, notchRect.top);
    notchPath.arcToPoint(
      Offset(notchRect.right, notchRect.bottom),
      radius: Radius.circular(cornerRadius),
      clockwise: true,
    );
    notchPath.lineTo(notchRect.left, notchRect.bottom);
    notchPath.arcToPoint(
      Offset(notchRect.left, notchRect.top),
      radius: Radius.circular(cornerRadius),
      clockwise: true,
    );
    notchPath.close();

    path.addPath(notchPath, Offset.zero);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}