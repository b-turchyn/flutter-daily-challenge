import 'dart:ui';
import 'package:daily_challenge/challenges/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Challenge20210917 extends StatefulWidget with ChallengeItem {
  @override
  String get name => "Overlapping with SliverAppBar";

  @override
  String get description => "Doing relative positioning with a parallax effect.";

  @override
  DateTime get date => DateTime(2021, 9, 17);

  @override
  State<Challenge20210917> createState() => _Challenge20210917State();
}

class _Challenge20210917State extends State<Challenge20210917> {
  static const kHeaderHeight = 235.0;
  static const fadePercentage = 0.7;

  late ScrollController _scrollController;

  double get _avatarSize {
    return _relativeBetween(0.5, 1.0);
  }

  double get _avatarOpacity {
    return _relativeBetween(0.0, 1.0);
  }

  double _relativeBetween(double min, double max) {

    if (_scrollController.hasClients) {
      final adjustedHeight = kHeaderHeight * fadePercentage;
      final offset = _scrollController.offset;

      if (offset > kHeaderHeight) {
        return min;
      } else if (offset < adjustedHeight) {
        return max;
      } else {
        final val = 1 - ((offset - adjustedHeight) / (kHeaderHeight - adjustedHeight));
        return lerpDouble(min, max, val) ?? max;
      }
    } else return max;
  }

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: MediaQuery.of(context).size.height * 0.4,
          title: Text(
              "Username",
            //style: TextStyle(color: Colors.black, shadows: [Shadow(color: Colors.white, blurRadius: 16.0)]),
          ),
          primary: true,
          centerTitle: true,
          flexibleSpace: Stack(
            clipBehavior: Clip.none,
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Positioned(
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      "https://images.unsplash.com/photo-1576679833928-f6c778b4a864?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1700&q=80",
                    ),
                    repeat: ImageRepeat.repeat,
                  ),
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0),
              Positioned(
                child: Row(
                  children: [
                    avatar(context),
                  ],
                ),
                bottom: (-50 * _avatarSize),
              ),
            ],
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 50.0,
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.deepOrange[100 * (index + 1 % 9)],
                child: Text(
                  'List Item $index',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget avatar(BuildContext context) {
    return Opacity(
      opacity: _avatarOpacity,
      child: Container(
        alignment: Alignment.center,
        width: 100 * _avatarSize,
        height: 100 * _avatarSize,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://www.gravatar.com/avatar/9312dc7d6db53f8698d5bd2adfe72f2b?s=400&d=mm&r=x"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(50)),
          border: Border.all(
            color: Colors.deepOrange[800]!,
            width: 4.0,
          ),
        ),
      ),
    );
  }
}


/**
class StackWithAllChildrenReceiveEvents extends Stack {

  StackWithAllChildrenReceiveEvents({
    key,
    AlignmentDirectional alignment = AlignmentDirectional.topStart,
    TextDirection textDirection = TextDirection.ltr,
    StackFit fit = StackFit.loose,
    clipBehavior,
    List<Widget> children = const <Widget>[],
  }) : super(
    key: key,
    alignment: alignment,
    textDirection: textDirection,
    fit: fit,
    clipBehavior: clipBehavior,
    children: children,
  );


  @override
  RenderStackWithAllChildrenReceiveEvents createRenderObject(BuildContext context) {
    return RenderStackWithAllChildrenReceiveEvents(
      children: children,
      alignment: alignment,
      textDirection: textDirection ?? Directionality.of(context),
      fit: fit,
      clipBehavior: clipBehavior,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderStackWithAllChildrenReceiveEvents renderObject) {
    renderObject
      ..alignment = alignment
      ..textDirection = textDirection ?? Directionality.of(context)
      ..fit = fit
      ..clipBehavior = clipBehavior;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AlignmentGeometry>('alignment', alignment));
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection, defaultValue: null));
    properties.add(EnumProperty<StackFit>('fit', fit));
    properties.add(EnumProperty<Overflow>('overflow', overflow));
  }

}

class RenderStackWithAllChildrenReceiveEvents extends RenderStack {
  RenderStackWithAllChildrenReceiveEvents({
    required List<RenderBox> children,
    AlignmentGeometry alignment = AlignmentDirectional.topStart,
    textDirection,
    StackFit fit = StackFit.loose,
    clipBehavior = Clip.antiAlias,
  }): super(
    alignment: alignment,
    textDirection: textDirection,
    fit: fit,
    clipBehavior: clipBehavior,
  );

  bool allCdefaultHitTestChildren(HitTestResult result, { Offset? position }) {
    // the x, y parameters have the top left of the node's box as the origin
    RenderBox? child = lastChild;
    while (child != null) {
      final StackParentData childParentData = child.parentData!;
      child.hitTest(result, position: position - childParentData.offset);
      child = childParentData.previousSibling;
    }
    return false;
  }

  @override
  bool hitTestChildren(HitTestResult result, { Offset? position }) {
    return allCdefaultHitTestChildren(result, position: position);
  }
}
// */