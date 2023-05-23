// import 'package:guten/utils/theme_states.dart';
// import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guten/data/providers/booklist_provider.dart';
import 'package:guten/main.dart';
import 'package:guten/utils/constants/responsive_constant.dart';
import 'package:guten/utils/routes/all_routes.dart';
import 'package:guten/utils/theme/app_theme.dart';
import 'package:provider/provider.dart';

import 'ui/screens/splash/splash_screen.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return MultiProvider(
            providers: [
              ChangeNotifierProvider<UnrestrictedProvider>(
                create: (context) => UnrestrictedProvider(),
              ),
            ],
            child: MaterialApp(
              title: 'Gutenberg',
              debugShowCheckedModeBanner: false,
              theme: GutenbergTheme.appTheme(),
              navigatorKey: navigatorKey,
              localizationsDelegates: const <LocalizationsDelegate>[
                DefaultMaterialLocalizations.delegate,
                DefaultWidgetsLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate
              ],
              initialRoute: SplashScreen.ROUTE_NAME,
              home: const SplashScreen(),
              onGenerateRoute: (RouteSettings settings) => allRoutes(settings),
            ));
      });
    });
  }
}

class CustomError extends StatelessWidget {
  final FlutterErrorDetails? errorDetails;

  const CustomError({
    Key? key,
    @required this.errorDetails,
  })  : assert(errorDetails != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
            body: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          alignment: Alignment.center,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 48,
                ),
                const Text(
                  'Some Error Occurred',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                const SizedBox(height: 25),
                Text(
                  errorDetails!.exception.toString(),
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        )));
  }
}
