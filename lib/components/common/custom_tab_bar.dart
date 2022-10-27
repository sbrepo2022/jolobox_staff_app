import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'package:jolobox_staff_app/theme/theme_constants.dart';


@immutable
class CustomTabData {
  const CustomTabData({
    required this.title,
    this.marked = false
  });

  final String title;
  final bool marked;
}


class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    Key? key,
    required this.currentIndex,
    required this.tabData,
    required this.onIndexChanged,
  }) : super(key: key);

  final int currentIndex;
  final List<CustomTabData> tabData;
  final Function(int) onIndexChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...tabData.mapIndexed((index, element) {
           return Expanded(
             child: InkWell(
               splashFactory: NoSplash.splashFactory,
               highlightColor: Colors.transparent,
               onTap: () {
                 onIndexChanged(index);
               },
               child: Container(
                 padding: EdgeInsets.all(JoloboxTheme.sizes.smallPadding / 2),
                 child: Center(
                   child: Text(
                     element.title,
                     style: TextStyle(
                       color: index == currentIndex ? JoloboxTheme.colors.primary : JoloboxTheme.colors.text,
                       fontWeight: FontWeight.w600,
                     ),
                   ),
                 ),
               ),
             ),
           );
        }),
      ],
    );
  }
}
