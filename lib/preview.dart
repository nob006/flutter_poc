import 'dart:io';

import 'package:flutter/material.dart';

class PreviewPage extends StatefulWidget {
  final String imagePart;

  PreviewPage({this.imagePart});

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview"),
      ),
      body: Center(child: Image.file(File(widget.imagePart))),
    );
  }
}
