import 'package:flutter/material.dart';

import 'screens/home_slideshow_screen.dart';
import 'package:flutter/services.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized(); 
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_){
    runApp(MyApp());
   });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Oferta',
        theme: ThemeData(primaryColor: Colors.teal, accentColor: Colors.white),
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Slideshow()));
  }
}
