import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bluetooth.dart';
import 'package:flutter_app/gps.dart';
import 'package:flutter_app/restclient.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("POC"),
      ),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
                child: Text("QR Scan"),
                onPressed: () {
                  Navigator.pushNamed(context, "/qr_scan");
                }),
            RaisedButton(
                child: Text("CAMERA"),
                onPressed: () {
                  _navigateToCamera(context);
                }),
            RaisedButton(
                child: Text("GPS Tracking"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GPSPage()));
                }),
            RaisedButton(
                child: Text("REST Client"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RestClientPage()));
                }),
            RaisedButton(
                child: Text("BLUETOOTH"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BlueToothPage()));
                }) //bluetooth
          ],
        ),
      ),
    );
  }

  _navigateToCamera(BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    Navigator.pushNamed(context, "/camera");
  }
}
