import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class StoryDetailsScreen extends StatefulWidget {
  final Map data;

  StoryDetailsScreen(this.data);

  @override
  _StoryDetailsScreenState createState() => _StoryDetailsScreenState();
}

class _StoryDetailsScreenState extends State<StoryDetailsScreen> {
  String url = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: BlurHash(
              imageFit: BoxFit.cover,
              hash: "TICSbN9Maf~QNIj?-lkAkAxYjbod",
              image: widget.data['image_url'],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.7,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(30),
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
                        widget.data['price'],
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            decoration: TextDecoration.lineThrough),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            widget.data['sale_price'],
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 30)),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    padding: EdgeInsets.all(6),
                    child: ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width * 0.8,
                      height: 30,
                      child: FlatButton(
                          color: Colors.green,
                          child: Text(
                            "GO TO STORE",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Text text = Text(widget.data['url']);
                            _launchUniversalLinks(text.data);
                          }),
                    ),
                  ),
                ],
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

  Future<void> _launchUniversalLinks(String url) async {
    if (await canLaunch(url)) {
      final bool appLaunchedSuccessfully =
          await launch(url, forceSafariVC: false, universalLinksOnly: true);

      if (!appLaunchedSuccessfully) {
        await launch(url, forceSafariVC: true);
      }
    }
  }
}
