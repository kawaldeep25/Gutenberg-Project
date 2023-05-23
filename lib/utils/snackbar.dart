import 'package:flutter/material.dart';

extension ShowSnackbarGlobalKeyScaffoldStateExtension
    on GlobalKey<ScaffoldState> {
  void showSnackBar(
    String message,
    Color color, [
    Duration duration = const Duration(seconds: 2),
  ]) {
    currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: duration,
      ),
    );
  }
}

extension ShowSnackBarBuildContextExtension on BuildContext {
  void showSnackBar(
    String message,
    Color color, [
    Duration duration = const Duration(seconds: 2),
  ]) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: duration,
      ),
    );
  }
}

class ShowSnackBarBuildWithBuildContext {
  void showSnackBar(
    BuildContext context,
    String message,
    Color color, [
    Duration duration = const Duration(seconds: 2),
  ]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: duration,
      ),
    );
  }
}

SnackBar snackBar(
  String text, {
  bool? error,
}) {
  return SnackBar(
    content: Text(text),
    action: SnackBarAction(
      label: 'X',
      textColor: Colors.white,
      onPressed: () {},
    ),
    backgroundColor: error! ? Colors.red : Colors.green,
    behavior: SnackBarBehavior.fixed,
    duration: const Duration(seconds: 5),
  );
}

errorSnackBar({required context, String? text, bool? error}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    snackBar(
      text ?? "Error",
      error: error,
    ),
  );
}
