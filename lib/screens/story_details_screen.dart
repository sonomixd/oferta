import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class StoryDetailsScreen extends StatefulWidget {
  final Map data;

  StoryDetailsScreen(this.data);

  @override
  _StoryDetailsScreenState createState() => _StoryDetailsScreenState();
}

class _StoryDetailsScreenState extends State<StoryDetailsScreen> {
  final List<String> images = [
    'assets/images/google_sign_in.png',
    'assets/images/google_sign_in.png',
    'assets/images/google_sign_in.png'
  ];

  int currentIndex = 0;

  void _next() {
    setState(() {
      if (currentIndex < 2) {
        currentIndex++;
      } else {
        currentIndex = currentIndex;
      }
    });
  }

  void _previous() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      } else {
        currentIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: CircularProgressIndicator()
          ),    
          Positioned(     
            child: FadeInImage.assetNetwork(
              height: 450,
              fit: BoxFit.cover,
              placeholder: 'assets/images/google_signin.png', 
              image: widget.data['images'][currentIndex]
              ),
          ),     
          GestureDetector(
            onHorizontalDragEnd: (DragEndDetails details) {
              if (details.velocity.pixelsPerSecond.dx > 0) {
                _previous();
              } else if (details.velocity.pixelsPerSecond.dx < 0) {
                _next();
              }
            },
            child: Container(
              width: double.infinity,
              height: 450,
              margin: EdgeInsets.only(bottom: 10),
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     image: DecorationImage(
              //       image: NetworkImage(widget.data['images'][currentIndex]),
              //       fit: BoxFit.cover,
              //     ),
              //     ),
              child: Container(
                decoration: BoxDecoration(
                  gradient:
                      LinearGradient(begin: Alignment.bottomRight, colors: [
                    Colors.grey[700].withOpacity(.9),
                    Colors.grey.withOpacity(.0),
                  ]),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 30,
                      margin: EdgeInsets.only(bottom: 50),
                      child: Row(
                        children: _buildIndicator(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
            child: Transform.translate(
              offset: Offset(0, 240),
              child: Container(
                height: 300,
                width: double.infinity,
                padding: EdgeInsets.all(30),
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.data['title'],
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          widget.data['product_price'],
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 20, decoration: TextDecoration.lineThrough),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              widget.data['product_sale_price'],
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ],
                        )
                      ],
                    ),
                    Expanded(
                      child: Align(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: ButtonTheme(
                              minWidth: 300.0,
                              child: FlatButton(   
                                    color: Colors.green,
                                      child: Text("GO TO STORE", style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  _launchInBrowser(_launchUrl);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
            padding: EdgeInsets.only(top: 30),
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

  Future<void> _launched;
  String _launchUrl = 'https://www.google.com';

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _indicator(bool isActive) {
    return Expanded(
      child: Container(
        height: 4,
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: isActive ? Colors.grey[800] : Colors.white),
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }
}
