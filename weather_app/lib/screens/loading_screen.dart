import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/location.dart';
import 'location_screen.dart';
import 'package:http/http.dart' as http;

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
    getLocation();
  }

  void requestPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    print(permission);
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longtude = location.longitude;

    getData();
  }

  void getData() async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longtude&appid=$apiKey');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;

      var temperature = jsonDecode(data)["main"]["temp"];
      var id = jsonDecode(data)["weather"][0]["id"];
      var cityName = jsonDecode(data)["name"];

      print(temperature);
      print(id);
      print(cityName);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
