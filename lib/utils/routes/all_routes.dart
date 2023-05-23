import 'package:flutter/material.dart';
import 'package:guten/ui/screens/category/category_screen.dart';
import 'package:guten/ui/screens/home/home.dart';
import 'package:guten/ui/screens/splash/splash_screen.dart';

allRoutes(RouteSettings settings) {
  switch (settings.name) {
    case Home.ROUTE_NAME:
      return _getDefaultRoute(Home());
    case CategoryScreen.ROUTE_NAME:
      return _getDefaultRoute(CategoryScreen(
        category: settings.arguments as String?,
      ));
    // case AddDocumentScreen.ROUTE_NAME:
    //   return _getDefaultRoute(AddDocumentScreen(
    //     isPhoto: settings.arguments as bool?,
    //   ));
    // case UploadDocumentScreen.ROUTE_NAME:
    //   Map data = settings.arguments as Map<dynamic, dynamic>;
    //   return _getDefaultRoute(UploadDocumentScreen(
    //     label: data['label'],
    //     isPhoto: data['isPhoto'],
    //   ));
    //   return _getDefaultRoute(UploadDocumentScreen(
    //     isPhoto: settings.arguments as bool?,
    //   ));
    case SplashScreen.ROUTE_NAME:
      return _getDefaultRoute(const SplashScreen(), withAnimation: true);
    //
    // // case SellScreen.ROUTE_NAME:
    // //   return _getDefaultRoute(SellScreen(isTab: settings.arguments as bool?),
    // //       withAnimation: true);
    default:
      return _getDefaultRoute(const SplashScreen());
  }
}

Route _getDefaultRoute(Widget widget, {bool withAnimation = true}) {
  if (!withAnimation) {
    return PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) => widget,
      transitionDuration: Duration.zero,
    );
  }

  return MaterialPageRoute(builder: (BuildContext context) {
    return widget;
  });
}

class SlideLeftRoute extends PageRouteBuilder {
  final Widget page;
  SlideLeftRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
