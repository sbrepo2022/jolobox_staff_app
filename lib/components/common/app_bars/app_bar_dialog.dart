import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:jolobox_staff_app/theme/theme_constants.dart';


class AppBarDialog extends AppBar {
  AppBarDialog({Key? key, required String title, bool showElevation = false}):super(
    key: key,
    backgroundColor: JoloboxTheme.colors.background,
    toolbarHeight: JoloboxTheme.sizes.themeScale(80.0),
    iconTheme: IconThemeData(
      color: JoloboxTheme.colors.text,
    ),
    title: Text(
      title,
      overflow: TextOverflow.fade,
    ),
    elevation: showElevation ? 4.0 : 0.0,
  );
}
