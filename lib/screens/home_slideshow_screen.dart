import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oferta/screens/story_details_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shimmer/shimmer.dart';

class Slideshow extends StatefulWidget {
  @override
  _SlideshowState createState() => _SlideshowState();
}

class _SlideshowState extends State<Slideshow> {
  final PageController ctrl = PageController(viewportFraction: 0.8);

  final Firestore db = Firestore.instance;
  Stream slides;

  String activeTag = 'favourites';

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _queryDb();

    ctrl.addListener(() {
      int next = ctrl.page.round();

      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: slides,
        initialData: [],
        builder: (context, AsyncSnapshot snap) {
          List slideList = snap.data.toList();
          return PageView.builder(
            controller: ctrl,
            itemCount: slideList.length + 1,
            itemBuilder: (context, int currentIdx) {
              if (currentIdx == 0) {
                return _buildTagPage();
              } else if (slideList.length >= currentIdx) {
                bool active = currentIdx == currentPage;
                return _buildStoryPage(slideList[currentIdx - 1], active);
              } else
                return Container();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.home,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
        onPressed: () => ctrl.animateToPage(0,
            duration: Duration(milliseconds: 200), curve: Curves.bounceOut),
      ),
    );
  }

  void _queryDb({String tag = 'favourites'}) {
    Query query = db.collection('stories').where('tags', arrayContains: tag);

    slides =
        query.snapshots().map((list) => list.documents.map((doc) => doc.data));

    setState(() {
      activeTag = tag;
    });
  }

  _buildStoryPage(Map data, bool active) {
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 100 : 0;

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => StoryDetailsScreen(data),
        ),
      ),
      child: AnimatedContainer(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(-20, 10),
            )
          ]),
          duration: Duration(milliseconds: 1000),
          curve: Curves.easeOutQuint,
          margin: EdgeInsets.only(top: 20, bottom: 20, right: 20),
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage.assetNetwork(
                  height: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: 'assets/images/google_signin.png',
                  image: data['img'],
                ),
              ),
              Center(
                child: new CircularPercentIndicator(
                  radius: 200.0,
                  lineWidth: 10.0,
                  percent: double.parse(data['product_sale_percentage']) / 100,
                  center: new Text(
                    data['product_sale_percentage'] + "%",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 50),
                  ),
                  progressColor: Colors.green,
                ),
              ),
            ],
          )),
    );
  }

  _buildTagPage() {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'KATEGORITE',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text('FILTER', style: TextStyle(color: Colors.black26)),
        _buildButton('favourites'),
        _buildButton('happy'),
        _buildButton('sunny'),
      ],
    ));
  }

  _buildButton(tag) {
    Color color = tag == activeTag ? Colors.green : Colors.white;
    return FlatButton(
        color: color,
        child: Text('#$tag'),
        onPressed: () => _queryDb(tag: tag));
  }
}
