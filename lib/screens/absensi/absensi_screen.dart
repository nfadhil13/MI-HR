import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/util/color.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class AbsensiScreen extends StatefulWidget {
  const AbsensiScreen({Key? key}) : super(key: key);

  static final routeName = "/absensi-screen";

  @override
  _AbsensiScreenState createState() => _AbsensiScreenState();
}

class _AbsensiScreenState extends State<AbsensiScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }


  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return Scaffold(
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: ThemeColors.primaryThird,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: scanArea
            ),
          ),
        ],
      )
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      _showAbsenceDialog(scanData);
    });
  }

  void _showAbsenceDialog(Barcode data) {
    showDialog(context: context, builder: (ctx) => AlertDialog(
      content: Card(
        color: Colors.black45,
        child: Row(
          children: [
            Text("Halo ${data.code}")
          ],
        ),
      ),
    )).then((value){
      controller?.resumeCamera();
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
