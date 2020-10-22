import 'package:flutter/material.dart';
import 'package:oferta/screens/home_slideshow_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectCountry extends StatefulWidget {
  @override
  _SelectCountryState createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String country;

  //check if user has already selected the country
  @override
  void initState() {
    getSharedPreferencesData();
    //super.initState();
  }

  getSharedPreferencesData() async {
    final SharedPreferences prefs = await _prefs;
    country = prefs.getString("COUNTRY");
    if (country != null) {
      redirectToHomeScreen();
    }
  }

  redirectToHomeScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Slideshow()),
    );
  }

  Future<void> selectedCountry(String country) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("COUNTRY", country);
    redirectToHomeScreen();
  }

  Text germany = Text("DE");
  Text albania = Text("AL");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("SELECT YOUR LOCATION",
             style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),),
            Padding(padding: EdgeInsets.only(top: 50)),
            ButtonTheme(

              buttonColor: Colors.white,
              minWidth: MediaQuery.of(context).size.width * 0.7,
              child: RaisedButton(
                highlightColor: Colors.green,
                child: germany,
                onPressed: () {
                  selectedCountry(germany.data.toLowerCase());
                },
              ),
            ),
            ButtonTheme(
              buttonColor: Colors.white,
              minWidth: MediaQuery.of(context).size.width * 0.7,
              child: RaisedButton(
                highlightColor: Colors.green,
                child: albania,
                onPressed: () {
                  selectedCountry(albania.data.toLowerCase());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
