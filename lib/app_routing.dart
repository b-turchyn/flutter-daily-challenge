
import 'package:daily_challenge/challenges/list.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

import 'challenge_list.dart';

VRouter buildRoutes(BuildContext context) {
  return VRouter(
      routes: [
        VWidget(path: '/', widget: ChallengeListScreen(), stackedRoutes: ChallengeList.asRoutes(context)),
      ]
  );
}
