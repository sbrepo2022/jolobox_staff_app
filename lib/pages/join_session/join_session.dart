import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:jolobox_staff_app/pages/join_session/qr_dialog.dart';
import 'package:jolobox_staff_app/pages/join_session/session_properties_dialog.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';


class JoinSessionData {
  JoinSessionData({ this.success = false });

  bool success = false;
}


class JoinSession {
  static Future<JoinSessionData> joinSession(NavigatorState navigatorState) async {
    Completer qrCompleter = Completer();
    Completer joinSessionSettingsCompleter = Completer();

    navigatorState.push(
      MaterialPageRoute(
          builder: (context) => QRViewerDialog(
            onResult: (Barcode? barcode) {
              qrCompleter.complete(barcode);
            },
          ),
          fullscreenDialog: true
      ),
    );

    Barcode? barcode = await qrCompleter.future;
    if (barcode == null) {
      navigatorState.pop();
      return JoinSessionData(
          success: false
      );
    }

    /*
        There will be getting session info from network
    */

    navigatorState.pushReplacement(
      MaterialPageRoute(
        builder: (context) => SessionPropertiesDialog(
          onResult: (JoinSessionSettings? joinSessionSettings) {
            joinSessionSettingsCompleter.complete(joinSessionSettings);
          },
        ),
        fullscreenDialog: true
      ),
    );

    JoinSessionSettings? joinSessionSettings = await joinSessionSettingsCompleter.future;
    navigatorState.pop();
    if (joinSessionSettings == null) {
      return JoinSessionData(
          success: false
      );
    }
    /*
        here will be connection to server for get session data
    */

    return JoinSessionData(
      success: true
    );
  }
}