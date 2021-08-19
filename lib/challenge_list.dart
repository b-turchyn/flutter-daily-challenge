import 'package:flutter/material.dart';

import 'challenges/list.dart';

class ChallengeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
            children: ChallengeList.asListView(context),
          )
      ),
    );
  }
}

