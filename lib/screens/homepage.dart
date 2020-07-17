import 'package:flutter/material.dart';
import 'package:oferta/widgets/category.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text('Oferta'),
      ),
      body: ListView(
        children: <Widget>[
          Center(child: Text('Categories', style: TextStyle(fontSize: 40),)),
          Category(),
        ],
      ),
    );
  }
}