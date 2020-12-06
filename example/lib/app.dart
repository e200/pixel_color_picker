import 'package:example/screens/home/screen.dart';
import 'package:flutter/material.dart';

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example App',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
