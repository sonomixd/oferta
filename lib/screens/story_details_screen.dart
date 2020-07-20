import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoryDetailsScreen extends StatelessWidget {
  final Map data;

  StoryDetailsScreen(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 32.0),
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(top: 100, bottom: 50, right: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(data['img']),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black87,
                      blurRadius: 30,
                      offset: Offset(20, 20))
                ]),
            child: Center(
                child: Text(
              data['title'],
              style: TextStyle(fontSize: 40, color: Colors.white),
            )),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
