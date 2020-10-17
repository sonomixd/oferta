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

  Text germany = Text("GERMANY");
  Text albania = Text("ALBANIA");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(100)),
            RaisedButton(
              child: germany,
              onPressed: () {
                selectedCountry(germany.data);
              },
            ),
            RaisedButton(
              child: albania,
              onPressed: () {
                selectedCountry(albania.data);
              },
            )
          ],
        ),
      ),
    );
  }
}
