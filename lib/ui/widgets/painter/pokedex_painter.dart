import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PokedexPainter extends CustomPainter {
  PokedexPainter();
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.fill;

    final bodyPath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(bodyPath, paint);

    final contourPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.w;

    final contourPath = Path()
      ..moveTo(0, size.height * 0.1)
      ..lineTo(size.width * 0.25, size.height * 0.1)
      ..lineTo(size.width * 0.25, 0)
      ..lineTo(size.width * 0.75, 0)
      ..lineTo(size.width * 0.75, size.height * 0.1)
      ..lineTo(size.width, size.height * 0.1)
      ..lineTo(size.width, size.height * 0.9)
      ..lineTo(size.width * 0.75, size.height * 0.9)
      ..lineTo(size.width * 0.75, size.height)
      ..lineTo(size.width * 0.25, size.height)
      ..lineTo(size.width * 0.25, size.height * 0.9)
      ..lineTo(0, size.height * 0.9)
      ..close();
    canvas.drawPath(contourPath, contourPaint);

    final circlePaint = Paint()..style = PaintingStyle.fill;

    circlePaint.color = Colors.black;
    canvas.drawCircle(
        Offset(size.width * 0.15, size.height * 0.15), 30.w, circlePaint);

    circlePaint.color = Colors.black;
    canvas.drawCircle(
        Offset(size.width * 0.4, size.height * 0.08), 10.w, circlePaint);
    circlePaint.color = Colors.black;
    canvas.drawCircle(
        Offset(size.width * 0.5, size.height * 0.08), 10.w, circlePaint);
    circlePaint.color = Colors.black;
    canvas.drawCircle(
        Offset(size.width * 0.6, size.height * 0.08), 10.w, circlePaint);

    final rectPaint = Paint()..color = Colors.black;
    canvas.drawRect(
      Rect.fromCenter(
          center: Offset(size.width * 0.5, size.height * 0.8),
          width: 70.w,
          height: 20.h),
      rectPaint,
    );

    final plusPaint = Paint()..color = Colors.black;
    final plusSize = 100.w;
    final plusThickness = 40.w;

    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.5 - plusSize / 2, size.height * 0.65,
          plusSize, plusThickness),
      plusPaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.5 - plusThickness / 2,
          size.height * 0.67 - plusSize / 2, plusThickness, plusSize),
      plusPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
