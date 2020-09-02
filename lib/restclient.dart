import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/weather_res.dart';

class RestClientPage extends StatefulWidget {
  @override
  _RestClientPageState createState() => _RestClientPageState();
}

class _RestClientPageState extends State<RestClientPage> {
  final _controller = TextEditingController();

  var temp = "";
  var description = "";

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rest Client"),
      ),
      body: Column(
        children: [
          Text("Please input you city"),
          TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'bangkok, london...',
              )),
          RaisedButton(
              child: Text("Search"),
              onPressed: () {
                var city = _controller.text;
                if (city.isNotEmpty) {
                  _getServiceAPI(city);
                }
              }),
          Text("Temp : $temp"),
          Text("Description : $description"),
        ],
      ),
    );
  }

  _getServiceAPI(String city) async {
    var url = "http://api.openweathermap.org/data/2.5/weather?q=bangkok&appid=5617f69bf09513b0a89313937ff6660e&units=metric&lang=th";
    try {
      Response response = await Dio().get(url);
      print(response);
      var res = WeatherRes.fromJson(json.decode(response.toString()));
      if (res.cod == 200) {
        this.temp = res.main.temp.toString();
        this.description = res.weather[0].description;
        setState(() {
          // just update ui
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
