import 'package:flutter/material.dart';

import 'widgets/slideshow.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oferta',
      theme: ThemeData(primaryColor: Colors.teal, accentColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Slideshow())
    );
  }
}
