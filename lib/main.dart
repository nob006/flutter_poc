import 'package:flutter/material.dart';
import 'package:flutter_app/camera.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/qr_scan.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      routes: {
        "/qr_scan" : (context) => QRScanPage(),
        "/camera" : (context) => CameraPage()
      },
    );
  }
}

