import 'package:flutter/material.dart';
import 'package:jolobox_staff_app/theme/theme_constants.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: JoloboxTheme.sizes.themeScale(36.0),
                fontWeight: FontWeight.w700
            ),
          ),
          Container(
            width: JoloboxTheme.sizes.themeScale(125.0),
            height: JoloboxTheme.sizes.themeScale(4.0),
            margin: EdgeInsets.only(top: JoloboxTheme.sizes.themeScale(10)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(JoloboxTheme.sizes.themeScale(4))),
              gradient: LinearGradient(
                colors: <Color> [
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.primary
                ]
              ),
            )
          ),
        ],
      ),
    );
  }
}
