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
  Future<void> _launched;

  @override
  Widget build(BuildContext context) {
    String url = Text(widget.data['url']).data;
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
              width: MediaQuery.of(context).size.width,
              padding:
                  EdgeInsets.only(top: 10, bottom: 120, left: 30, right: 30),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      widget.data['title'],
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold),
                    ),
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
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    padding: EdgeInsets.all(6),
                    child: Center(
                      child: FlatButton(
                        padding: EdgeInsets.only(left: 100, right: 100),
                        child: Text(
                          "GO TO STORE",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          
                        ),
                        onPressed: () => setState(() {
                            _launched = _launchUniversalLinkIos(url);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              padding: EdgeInsets.only(top: 50, left: 10),
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

  Future<void> _launchUniversalLinkIos(String url) async {
    if (await canLaunch(url)) {
      final bool nativeAppLaunchSucceeded = await launch(
        url,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      if (!nativeAppLaunchSucceeded) {
        await launch(
          url,
          forceSafariVC: true,
        );
      }
    }
  }
}
