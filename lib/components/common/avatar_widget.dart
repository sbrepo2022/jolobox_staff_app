import 'package:flutter/material.dart';
import 'package:jolobox_staff_app/theme/theme_constants.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({Key? key, required this.image, this.circleWidth = 2.0, this.borderRadius = 100.0}) : super(key: key);

  final Image image;
  final double circleWidth;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,

      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color> [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary
            ],
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.all(circleWidth),

        child: Container(
          padding: EdgeInsets.all(circleWidth),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Theme.of(context).colorScheme.onPrimary,
          ),

          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
            ),

            child: image,
          ),
        ),
      ),
    );
  }
}
