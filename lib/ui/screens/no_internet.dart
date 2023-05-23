import 'package:flutter/material.dart';
import 'package:guten/utils/theme/app_textstyles.dart';

class NoInternet extends StatefulWidget {
  NoInternet({
    Key? key,
  }) : super(key: key);
  @override
  _NoInternetState createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'No Internet Found',
          style: AppTextStyles.body1,
        ),
      ),
    );
  }
}
