import 'package:daily_challenge/challenges/interface.dart';
import 'package:flutter/material.dart';
import 'dart:math' as Math;

class Challenge20210819 extends StatelessWidget with ChallengeItem {
  @override
  String get name => "Top Offers Card";
  @override
  String get description => "MEX - Android Flutter Design System";
  @override
  DateTime get date => DateTime(2021, 8, 16);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(title: Text("Top Offers Cards"),),
          _OfferCard(store: "Uber Eats", percentageOff: 25, image: "assets/2021-08-19/food1.jpg"),
          ImageAttribution(author: "Lily Banse"),
          _OfferCard(store: "Skip The Dishes", percentageOff: 15, image: "assets/2021-08-19/food2.jpg"),
          ImageAttribution(author: "Rachel Park"),
          _OfferCard(store: "Burger King", percentageOff: 15, image: "assets/2021-08-19/food3.jpg"),
          ImageAttribution(author: "Ilya Mashkov"),
          _OfferCard(store: "Wendy's", percentageOff: 15, image: "assets/2021-08-19/food4.jpg"),
          ImageAttribution(author: "amirali mirhashemian"),
          _OfferCard(store: "Fancy Steakhouse", percentageOff: 15, image: "assets/2021-08-19/food5.jpg"),
          ImageAttribution(author: "Loija Nguyen"),
          _OfferCard(store: "Other Place", percentageOff: 15, image: "assets/2021-08-19/food6.jpg"),
          ImageAttribution(author: "Caroline Attwood"),
        ],
      ),
    );
  }
}

class ImageAttribution extends StatelessWidget {
  final String author;

  ImageAttribution({required this.author, key}) : super(key: key);

  static const TextStyle _STYLE = TextStyle(
    color: Colors.black,
    fontSize: 8.0,
    decoration: TextDecoration.none,
  );

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(child: Text("Photo by $author on Unsplash", style: _STYLE)),
    );
  }
}

class _RedeemText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const height = _OfferCard.HEIGHT;
    const P = _OfferCard.PADDING;
    return LayoutBuilder(
      builder: (context, constraints) => Align(
        alignment: Alignment.centerLeft,
        child: Container(
          height: height * 0.07 + 2 * _OfferCard.PADDING,
          width: (constraints.minWidth * 0.4) - (P * 2),
          padding: EdgeInsets.only(left: P),
          child: Center(
            child: Text("REDEEM",
              style: _OfferCard._DEFAULT_TEXT_STYLE.merge(const TextStyle(fontSize: _OfferCard.PADDING * 0.9, color: Colors.black)),
              overflow: TextOverflow.clip,
            ),
          ),
        ),
      ),
    );
  }
}

class _OfferCard extends StatelessWidget {
  static const double HEIGHT = 200;
  static const double PADDING = 16.0;
  static const TextStyle _DEFAULT_TEXT_STYLE = TextStyle(
    color: Colors.white,
    decoration: TextDecoration.none,
    fontSize: PADDING * 1.5,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle _SHADOWS = TextStyle(
    shadows: [
      BoxShadow(color: Colors.black, spreadRadius: PADDING, blurRadius: PADDING)
    ]
  );

  final String store;
  final int percentageOff;
  final String image;

  _OfferCard({required this.store, required this.percentageOff, required this.image, key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(PADDING),
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          fit: StackFit.passthrough,
          children: [
            ClipPath(
              clipper: _OfferCardClipper(),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  image: DecorationImage(image: AssetImage(this.image), fit: BoxFit.cover),
                ),
                padding: EdgeInsets.all(PADDING * 1.5),
                height: HEIGHT,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(store, style: _DEFAULT_TEXT_STYLE.merge(const TextStyle(fontWeight: FontWeight.bold)).merge(_SHADOWS)),
                    Text("$percentageOff% off", style: _DEFAULT_TEXT_STYLE.merge(const TextStyle(fontSize: PADDING * 0.8, height: 2.0)).merge(_SHADOWS)),
                  ],
                ),
              ),
            ),
            _RedeemText(),
          ],
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

    path.moveTo(0, P);
    path.relativeArcToPoint(Offset(P, -P), clockwise: true, radius: Radius.circular(P));
    path.lineTo(size.width - P, 0);
    path.relativeArcToPoint(Offset(P, P), clockwise: true, radius: Radius.circular(P));
    path.lineTo(size.width, size.height - P);
    path.relativeArcToPoint(Offset(-P, P), clockwise: true, radius: Radius.circular(P));
    path.lineTo(size.width * .4 - P, size.height);
    path.relativeLineTo(0, size.height * -0.07 - P);
    path.relativeArcToPoint(Offset(-P, -P), clockwise: false, radius: Radius.circular(P));
    path.lineTo(0, (size.height * 0.93) - (2 * P));
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}