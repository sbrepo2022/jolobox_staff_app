import 'package:flutter/material.dart';
import 'package:jolobox_staff_app/theme/theme_constants.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({
    Key? key,
    required this.label,
    this.expandFactor = 1.0
  }) : super(key: key);

  final String label;
  final double expandFactor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: JoloboxTheme.sizes.themeScale(4.0 * (1.0 - expandFactor)),
        ),
        Text(
          label,
          style: TextStyle(
              fontSize: JoloboxTheme.sizes.themeScale(24.0 + 12 * expandFactor),
              fontWeight: FontWeight.w700
          ),
        ),
        Container(
            width: JoloboxTheme.sizes.themeScale(125.0),
            height: JoloboxTheme.sizes.themeScale(4.0),
            margin: EdgeInsets.only(top: JoloboxTheme.sizes.themeScale(10) * expandFactor),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(JoloboxTheme.sizes.themeScale(4))),
              gradient: LinearGradient(
                  colors: <Color> [
                    Theme.of(context).colorScheme.secondary.withOpacity(expandFactor),
                    Theme.of(context).colorScheme.primary.withOpacity(expandFactor)
                  ]
              ),
            )
        ),
      ],
    );
  }
}
