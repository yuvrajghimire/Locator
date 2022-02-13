import 'package:flutter/material.dart';
import 'package:locator/locator.dart';
import 'package:locator/map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'locator',
        routes: {
          'locator': (context) => const Locator(),
          'map': (context) => const OpenStreetMap(),
        });
  }
}
