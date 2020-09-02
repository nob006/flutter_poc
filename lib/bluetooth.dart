import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BlueToothPage extends StatefulWidget {
  @override
  _BlueToothPageState createState() => _BlueToothPageState();
}

class _BlueToothPageState extends State<BlueToothPage> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> devicesList = List<BluetoothDevice>();

  @override
  void dispose() {
    flutterBlue.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _startScanBluetoothDevice();
    return Scaffold(
      appBar: AppBar(
        title: Text("Bluetooth Scan"),
      ),
      body: ListView.builder(
          itemCount: devicesList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [Divider(),
                Text(devicesList[index].name.isNotEmpty ? devicesList[index].name : devicesList[index].id.id)
              ],
            );
          }),
    );
  }

  _startScanBluetoothDevice() {
    flutterBlue.scanResults.listen((event) {
      for (ScanResult r in event) {
        if (r.device.type != BluetoothDeviceType.unknown) {
          if (!devicesList.contains(r.device)) {
            devicesList.add(r.device);
            setState(() {

            });
          }
        }
      }
      print("device found : " + devicesList.length.toString());
    });

    flutterBlue.startScan(timeout: Duration(seconds: 4));
  }
}
