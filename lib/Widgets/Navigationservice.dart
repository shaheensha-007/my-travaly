import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  static Future<dynamic> push(Widget page) {
    if (navigatorKey.currentState != null) {
      return navigatorKey.currentState!.push(CustomPageRoute(route: page));
    }
    return Future.value(null); // Return a default future if navigator is not ready
  }

  static Future<dynamic> pushReplacement(Widget page) {
    if (navigatorKey.currentState != null) {
      return navigatorKey.currentState!.pushReplacement(CustomPageRoute(route: page));
    }
    return Future.value(null); // Handle null case
  }

  static void pop() {
    if (navigatorKey.currentState != null) {
      navigatorKey.currentState!.pop();
    }
  }

  static Future<dynamic> pushAndRemoveUntil(
      Widget page, bool Function(Route<dynamic>) predicate) {
    if (navigatorKey.currentState != null) {
      return navigatorKey.currentState!
          .pushAndRemoveUntil(CustomPageRoute(route: page), predicate);
    }
    return Future.value(null); // Handle null case
  }

  static Future<dynamic> pushMaterialRoute(MaterialPageRoute route) {
    if (navigatorKey.currentState != null) {
      return navigatorKey.currentState!.push(route);
    }
    return Future.value(null); // Handle null case
  }
}

class CustomPageRoute extends PageRouteBuilder {
  final Widget route;
  final AxisDirection direction;

  CustomPageRoute({required this.route, this.direction = AxisDirection.right})
      : super(
      transitionDuration: const Duration(microseconds: 1000),
      pageBuilder: (context, animation, secondaryAnimation) => route);

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) =>
      FadeTransition(
        opacity: animation,
        child: route,
      );
}
