import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GPSPage extends StatefulWidget {
  @override
  _GPSPageState createState() => _GPSPageState();
}

class _GPSPageState extends State<GPSPage> {

  String lat,lon;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getCurrentLocation();
    return Scaffold(
      appBar: AppBar(title: Text("GPS"),),
      body: Column(children: [
        Text("lat : $lat"),
        Text("lon : $lon")
      ],),
    );
  }

  _getCurrentLocation() async {
    Position position = await getLastKnownPosition();
    setState(() {
      lat  = position.latitude.toString();
      lon  = position.longitude.toString();
    });
  }
}
