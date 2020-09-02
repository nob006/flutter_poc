import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanPage extends StatefulWidget {
  @override
  _QRScanPageState createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  QRViewController qrViewController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String qrResult = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("QR SCAN"),
        ),
        body: Column(
          children: [
            Expanded(
                flex: 4,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.red,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 300,
                  ),
                )),
            Expanded(
                flex: 1,
                child: Center(
                  child: Text("Result $qrResult"),
                ))
          ],
        ),
      ),
    );
  }

  _onQRViewCreated(QRViewController qrViewController) {
    this.qrViewController = qrViewController;
    this.qrViewController.scannedDataStream.listen((event) {
      print("QR Result $event");
      setState(() {
        qrResult = event;
      });
    });
  }

  @override
  void dispose() {
    this.qrViewController.dispose();
    super.dispose();
  }
}
