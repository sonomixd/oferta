import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoryDetailsScreen extends StatefulWidget {
  final Map data;

  StoryDetailsScreen(this.data);

  @override
  _StoryDetailsScreenState createState() => _StoryDetailsScreenState();
}

class _StoryDetailsScreenState extends State<StoryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: 350,
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(widget.data['images'][2]),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black87,
                        blurRadius: 30,
                        offset: Offset(20, 20))
                  ]),
              child: Center(
                  child: Text(
                widget.data['title'],
                style: TextStyle(fontSize: 40, color: Colors.white),
              )),
            ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
