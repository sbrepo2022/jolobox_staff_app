import 'package:flutter/material.dart';
import 'package:jolobox_staff_app/theme/theme_constants.dart';

class ContentSurface extends StatelessWidget {
  const ContentSurface({Key? key, required this.child, this.padding}) : super(key: key);

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: JoloboxTheme.sizes.surfaceElevation,
      shadowColor: JoloboxTheme.colors.shadowColor,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.all(Radius.circular(JoloboxTheme.sizes.borderRadius)),
      color: Theme.of(context).colorScheme.background,
      child: Container(
          padding: padding ?? EdgeInsets.all(JoloboxTheme.sizes.smallPadding),
          color: Colors.transparent,
          child: child
      ),
    );
  }
}


class ContentTitleSurface extends StatelessWidget {
  const ContentTitleSurface({Key? key, required this.title, required this.children}) : super(key: key);

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ContentSurface(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: JoloboxTheme.sizes.bigTextSize,
                fontWeight: FontWeight.bold
            )
          ),
          SizedBox(height: JoloboxTheme.sizes.bigPadding),
          ...children
        ],
      ),
    );
  }
}

