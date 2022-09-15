import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:jolobox_staff_app/components/common/app_bars/app_bar_dialog.dart';


class QRViewerDialog extends StatefulWidget {
  const QRViewerDialog({Key? key, required this.onResult}) : super(key: key);

  final Function(Barcode?) onResult;

  @override
  State<QRViewerDialog> createState() => _QRViewerDialogState();
}

class _QRViewerDialogState extends State<QRViewerDialog> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.onResult(result);
        return false;
      },
      child: Scaffold(
        appBar: AppBarDialog(
            title: 'Сканирование QR'
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderRadius: 20,
                  borderWidth: 10,
                  borderColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      widget.onResult(result);
    });
    controller.pauseCamera();
    controller.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}