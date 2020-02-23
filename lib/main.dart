import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'routes/index.dart';

void main() {
  runApp(MyApp());
  _initSettings();
}

void _initSettings() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent)
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ncov',
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
    );
  }
}
