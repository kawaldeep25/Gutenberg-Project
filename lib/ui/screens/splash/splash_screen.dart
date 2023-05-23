import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guten/ui/screens/home/home.dart';
import 'package:guten/ui/screens/no_internet.dart';
import 'package:guten/utils/constants/strings.dart';
import 'package:guten/utils/theme/app_colours.dart';

//Renting Reinvented
//Rent on your terms with furnished or un-furnished homes,
// flexible leases, all inclusive payments and a fully digital living experience.
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const ROUTE_NAME = 'SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // AnimationController? controller;
  // Animation<double>? animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nextScreen();
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  nextScreen() {
    // controller = AnimationController(
    //     duration: const Duration(milliseconds: 1000), vsync: this);
    // animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    // controller.forward();
    internetConnectivity();
    // Timer(
    //     Duration(seconds: 2),
    //         () => {
    //       Navigator.of(context).push(MaterialPageRoute(
    //           builder: (BuildContext context) => MyMainPage()))
    //     });
  }

  internetConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          Future.delayed(const Duration(milliseconds: 2000), () {
            Route _createRoute() {
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => Home(),
                transitionDuration: const Duration(milliseconds: 0),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              );
            }

            Navigator.of(context).pop();
            Navigator.of(context).push(_createRoute());
          });
        });
      }
    } on SocketException catch (_) {
      print('not connected');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => NoInternet()));
    }
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Container(
          alignment: Alignment.center,
          width: _width,
          height: _height,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Strings.welcome,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                Strings.gutenberg + ' ' + Strings.project,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ));
  }
}
