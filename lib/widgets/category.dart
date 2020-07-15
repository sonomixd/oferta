import 'package:flutter/material.dart';
import 'package:oferta/widgets/category_card.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CategoryCard(
            Icon(Icons.book, size: 50,),
            'Book'
          ),
          CategoryCard(
            Icon(Icons.computer, size: 50,),
            'Laptop'
          ),
          CategoryCard(
            Icon(Icons.videogame_asset, size: 50,),
            'Games'
          ),
          CategoryCard(
            Icon(Icons.videocam, size: 50,),
            'Movies'
          ),
          CategoryCard(
            Icon(Icons.audiotrack, size: 50,),
            'Audio'
          ),
        ],
      ),
    );
  }
}