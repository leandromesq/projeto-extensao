import 'package:flutter/material.dart';
import 'package:rachadinha/core/utils/transitions/transitions.dart';
import 'package:routefly/routefly.dart';

import 'main.route.dart';
part 'main.g.dart';

void main() {
  runApp(const AppWidget());
}

@Main('lib/ui')
class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: Routefly.routerConfig(
        routes: routes,
        initialPath: routePaths.auth.login,
        routeBuilder: iOSTransition,
      ),
    );
  }
}
