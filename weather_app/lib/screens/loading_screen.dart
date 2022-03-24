import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/location.dart';
import 'location_screen.dart';
import 'package:weather_app/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = 'a7262f8fcb9c0c49eb7c87e002de25bb';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double latitude;
  late double longtude;

  void initState() {
    super.initState();
    requestPermission();
    getLocationData();
  }

  void requestPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    print(permission);
  }

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longtude = location.longitude;

    NetworkingHelper networkingHelper = NetworkingHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longtude&appid=$apiKey');

    var weatherData = await networkingHelper.getData();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
