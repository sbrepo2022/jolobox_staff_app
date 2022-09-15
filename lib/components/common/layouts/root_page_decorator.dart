import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RootPageDecorator extends StatelessWidget {
  const RootPageDecorator({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        } else {
          // Android back button hack
          SystemNavigator.pop();
        }
        return Future.value(true);
      },
      child: child,
    );
  }
}
