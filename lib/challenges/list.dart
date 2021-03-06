import 'package:daily_challenge/challenges/20210819.dart';
import 'package:daily_challenge/challenges/20210817.dart';
import 'package:daily_challenge/challenges/20210818.dart';
import 'package:daily_challenge/challenges/20210917.dart';
import 'package:daily_challenge/challenges/interface.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class ChallengeList {
  static final List<ChallengeItem> _challenges = [
    Challenge20210817(),
    Challenge20210818(),
    Challenge20210819(),
    Challenge20210917(),
  ];

  static List<Widget> asListView(BuildContext context) {
    return _challenges.map((element) => ListTile(
      title: Text("${element.formattedDate} - ${element.name}"),
      subtitle: Text(element.description),
      onTap: () => context.vRouter.to("/${element.dateString}"),
    )).toList();
  }

  static List<VWidget> asRoutes(BuildContext context) {
    return _challenges.map((element) => VWidget(path: element.dateString, widget: element as Widget)).toList();
  }
}
