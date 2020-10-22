import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oferta/screens/story_details_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Slideshow extends StatefulWidget {
  @override
  _SlideshowState createState() => _SlideshowState();
}

class _SlideshowState extends State<Slideshow> {
  //intance of firestore database
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  //controller for the pages
  final PageController pageController = PageController(viewportFraction: 0.8);
  //list of products
  List<Map<String, dynamic>> fullList = new List<Map<String, dynamic>>();
  //active tag to be selected when app starts
  String activeTag = 'trending';
  //keep track of the pages
  int currentPage = 0;
  //country collection to retrieve the data from in database
  String countryCollection = "de";

  var tags = [];

  @override
  void initState() {
    super.initState();
    getSharedPreferencesData();
    retrieveProductsFromFirestore();
    retrieveTagsFromFirestore();
    pageController.addListener(() {
      int next = pageController.page.round();
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
      body: PageView.builder(
          controller: pageController,
          itemCount: fullList.length + 1,
          itemBuilder: (context, int currentIdx) {
            if (currentIdx == 0) {
              return _buildTagPage();
            } else if (fullList.length >= currentIdx) {
              return _buildStoryPage(fullList[currentIdx - 1]);
            } else
              return Container();
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.home,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
        onPressed: () => pageController.animateToPage(0,
            duration: Duration(milliseconds: 200), curve: Curves.bounceOut),
      ),
    );
  }

  //function to get data from shared preferences
  getSharedPreferencesData() async {
    final SharedPreferences prefs = await _prefs;
    String country = prefs.getString("COUNTRY");
    if (country == null) {
      prefs.setString("COUNTRY", "de");
      country = prefs.getString("COUNTRY");
    } 
    setState(() {
      countryCollection = country;
    });
  }

  //function to retrieve all the products with the selected tag from firestore
  retrieveProductsFromFirestore({String tag = 'trending'}) async {
    FirebaseFirestore.instance
        .collection(countryCollection)
        .where('tags', arrayContains: tag)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        setState(() {
          Map<String, dynamic> map = element.data.call();
          fullList = new List<Map<String, dynamic>>();
          fullList.add(map);
        });
      });
    });
  }

  //function to build the story page
  _buildStoryPage(Map<String, dynamic> data) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => StoryDetailsScreen(data),
        ),
      ),
      child: AnimatedContainer(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(-20, 10),
            ),
          ]),
          duration: Duration(milliseconds: 1000),
          curve: Curves.easeOutQuint,
          margin: EdgeInsets.only(top: 40, bottom: 100, right: 40),
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BlurHash(
                  imageFit: BoxFit.cover,
                  hash: "TICSbN9Maf~QNIj?-lkAkAxYjbod",
                  image: data['image_url'],
                ),
                // child: FadeInImage.assetNetwork(
                //   height: double.infinity,
                //   fit: BoxFit.cover,
                //   placeholder: 'assets/images/loading-leaf.png',
                //   image: data['img'],
                // ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient:
                      LinearGradient(begin: Alignment.bottomRight, colors: [
                    Colors.green.withOpacity(.8),
                    Colors.white.withOpacity(.0),
                  ]),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: new CircularPercentIndicator(
                  startAngle: 270,
                  restartAnimation: true,
                  animation: true,
                  animationDuration: 2000,
                  backgroundColor: Colors.white,
                  radius: 100.0,
                  lineWidth: 5.0,
                  percent: double.parse(data['sale_percentage']) / 100,
                  center: new Text(
                    data['sale_percentage'] + "%",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  footer: new Text(
                    "ULJE",
                    style: new TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0),
                  ),
                  progressColor: Colors.green,
                ),
              ),
            ],
          )),
    );
  }

  //function to build the tags page
  _buildTagPage() {
    return Container(
        child: ListView(
      padding: EdgeInsets.only(top: 40, right: 50),
      children: <Widget>[
        Text(
          'KATEGORITE',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text('FILTER', style: TextStyle(color: Colors.black26)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (int i = 0; i < tags.length; i++) _buildButton(tags[i])
          ],
        )
      ],
    ));
  }

  //function to build the tag button
  _buildButton(tag) {
    Color color = tag == activeTag ? Colors.green : Colors.white;
    return FlatButton(
        color: color,
        child: Text('#$tag'),
        onPressed: () {
          activeTag = tag;
          retrieveProductsFromFirestore(tag: tag);
        });
  }

  //function to retrieve all the tags from firestore
  retrieveTagsFromFirestore() async {
    FirebaseFirestore.instance
        .collection('tags')
        .orderBy('order')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                tags.add(doc["tag"]);
              })
            });
  }
}
