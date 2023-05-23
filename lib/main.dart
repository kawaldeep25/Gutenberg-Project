import 'package:flutter/material.dart';
import 'package:guten/locator.dart';

import 'app.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}
