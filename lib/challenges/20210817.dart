import 'interface.dart';
import 'package:flutter/material.dart';
import 'dart:math' as Math;

class Challenge20210817 extends StatelessWidget with ChallengeItem {
  @override
  String get name => "Path Drawing";

  @override
  String get description => "Attempting to draw paths on the screen";

  @override
  DateTime get date => DateTime(2021, 8, 17);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: _PathPainter(),
      ),
    );
  }
}

class _PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    double degToRad(num deg) => deg * (Math.pi / 180.0);

    Path path = Path();
    path.lineTo(size.width / 2, size.height / 2);
    path.arcTo(Rect.fromLTWH(size.width / 2 - 90, size.height / 2 - 45, 90, 90), degToRad(0), degToRad(90), false);
    path.lineTo(size.width * .15, size.height / 2 + 45);
    //path.addArc(Rect.fromLTWH(size.width / 2 - 90, size.height / 2 - 45, 90, 90), degToRad(0), degToRad(90));
    //path.close();

    canvas.drawPath(path, paint);
  }

  @override
  shouldRepaint(covariant CustomPainter oldDelegate) => true;
}