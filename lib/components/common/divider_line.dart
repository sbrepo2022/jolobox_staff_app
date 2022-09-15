import 'package:flutter/material.dart';

import 'package:jolobox_staff_app/theme/theme_constants.dart';


class DividerLine extends StatelessWidget {
  const DividerLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: JoloboxTheme.colors.buttonSurface,
    );
  }
}
