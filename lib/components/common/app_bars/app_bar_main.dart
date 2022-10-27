import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:jolobox_staff_app/theme/theme_constants.dart';
import 'package:jolobox_staff_app/components/common/avatar_widget.dart';


class AppBarMain extends AppBar {
  AppBarMain({Key? key}):super(
    key: key,
    backgroundColor: JoloboxTheme.colors.background,
    toolbarHeight: JoloboxTheme.sizes.themeScale(80.0),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        SizedBox(
          height: JoloboxTheme.sizes.themeScale(40.0),

          child: const AvatarWidget(
              image: Image (
                  image: AssetImage('resources/images/avatar_example.jpeg'),
                  fit: BoxFit.cover
              )
          ),
        ),
        SizedBox(
          width: JoloboxTheme.sizes.themeScale(14.0),
        ),
        const Expanded(
          child: Text(
            'Сергей Борисов',
            overflow: TextOverflow.fade,
          ),
        ),
        SizedBox(
          height: JoloboxTheme.sizes.themeScale(40.0),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: SvgPicture.asset('resources/images/logos/J_logo.svg'),
          ),
        ),
        const SizedBox(width: 10.0)
      ],
    ),
  );
}
