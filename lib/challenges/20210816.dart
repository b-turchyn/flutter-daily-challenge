import 'package:daily_challenge/challenges/interface.dart';
import 'package:flutter/material.dart';
import 'dart:math' as Math;

class Challenge20210816 extends StatelessWidget with ChallengeItem {
  @override
  String get name => "Top Offers Card";
  @override
  String get description => "MEX - Android Flutter Design System";
  @override
  DateTime get date => DateTime(2021, 8, 16);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(),
        _OfferCard(store: "Uber Eats", percentageOff: 25, image: "assets/2021-08-16/food.png"),
        _OfferCard(store: "Uber Eats", percentageOff: 25, image: "assets/2021-08-16/food.png"),
      ],
    );
  }
}

class _OfferCard extends StatelessWidget {
  static const double PADDING = 16.0;
  static const TextStyle _DEFAULT_TEXT_STYLE = TextStyle(
    color: Colors.white,
    decoration: TextDecoration.none,
    fontSize: PADDING * 1.5,
    fontWeight: FontWeight.normal
  );

  final String store;
  final int percentageOff;
  final String image;

  _OfferCard({required this.store, required this.percentageOff, required this.image, key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ClipPath(
        clipper: _OfferCardClipper(),
        child: Container(
          decoration: BoxDecoration(
            //borderRadius: BorderRadius.all(Radius.circular(_PADDING)),
            color: Colors.green,
          ),
          padding: EdgeInsets.all(PADDING * 1.5),
          margin: EdgeInsets.all(PADDING),
          height: 200,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(store, style: _DEFAULT_TEXT_STYLE.merge(const TextStyle(fontWeight: FontWeight.bold))),
              Text("$percentageOff% off", style: _DEFAULT_TEXT_STYLE.merge(const TextStyle(fontSize: PADDING * 0.8, height: 2.0))),
            ],
          ),
        ),
      ),
    );
  }
}

class _OfferCardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    const P = _OfferCard.PADDING;
    const CUTOUT_X = 0.4;
    const CUTOUT_Y = 0.7;
    Rect circle1 = Rect.fromCircle(center: Offset(2 * P, 2 * P), radius: P);
    Rect circle2 = Rect.fromCircle(center: Offset(size.width - (2 * P), 2 * P), radius: P);

    double degToRad(num deg) => deg * (Math.pi / 180.0);

    /**
    path.moveTo(0, P);
    path.arcTo(circle1, degToRad(180), degToRad(90), false);
    path.moveTo(P, 0);
    path.lineTo(size.width - P, 0);
    path.arcTo(circle2, degToRad(270), degToRad(90), false);
    path.moveTo(size.width, P);
    path.lineTo(size.width, size.height - P);
    // */
    //**
    path.lineTo(size.width, size.height);
    path.lineTo(size.width * CUTOUT_X, size.height);
    //path.arcTo(Rect.fromLTWH(size.width * CUTOUT_X, size.height - P, P, P), degToRad(270), degToRad(180), true);
    //path.addArc(Rect.fromPoints(Offset.zero, Offset(-P, -P)), degToRad(270), degToRad(180));
    path.addArc(Rect.fromCircle(center: Offset(size.width * CUTOUT_X - P, size.height * CUTOUT_Y - P), radius: P), degToRad(270), degToRad(90));
    path.lineTo(size.width * CUTOUT_X, size.height * CUTOUT_Y);
    path.lineTo(0, size.height * CUTOUT_Y);
    path.lineTo(0, 0);

        // */
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}