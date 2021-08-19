import 'interface.dart';
import 'package:flutter/material.dart';
import 'dart:math' as Math;

class Challenge20210818 extends StatelessWidget with ChallengeItem {
  @override
  String get name => "Container Path Shape";

  @override
  String get description => "Shape a container with paths";

  @override
  DateTime get date => DateTime(2021, 8, 18);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
          child: ClipPath(
            child: Container(
              margin: EdgeInsets.all(8.0),
              color: Colors.green[200],
              height: 300,
              child: Center(
                child: Text("This container is clipped, yo", style: Theme.of(context).textTheme.bodyText1,),
              ),
            ),
            clipper: _ContainerClipper(),
          ),
        )
        ],
      ),
    );
  }
}

class _ContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    double w10 = size.width * .1;
    double h10 = size.height * .1;

    path.moveTo(0, 0);
    path.relativeLineTo(size.width, size.height * .2);
    path.lineTo(size.width, size.height);
    path.relativeLineTo(w10 * -1, h10 * -1);
    path.relativeLineTo(w10 * -1, 0);
    path.relativeLineTo(0, h10 * -1);
    path.relativeLineTo(w10 * -1, 0);
    path.relativeLineTo(0, h10 * -1);
    path.relativeLineTo(w10 * -5, h10 * -2);
    path.relativeArcToPoint(Offset(w10 * -1, h10 * -1), clockwise: true, radius: Radius.circular(w10));
    path.relativeLineTo(0, h10 * -2);
    path.lineTo(0, 0);

    return path;
  }

  @override
  shouldReclip(covariant CustomClipper oldClipper) => true;
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