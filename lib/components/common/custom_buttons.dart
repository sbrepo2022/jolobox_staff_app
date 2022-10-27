import 'package:flutter/material.dart';
import 'package:jolobox_staff_app/theme/theme_constants.dart';

class CustomPrimaryButton extends StatelessWidget {
  const CustomPrimaryButton({Key? key, required this.label, required this.onPressed}) : super(key: key);

  final String label;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color> [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary
          ]
        ),
        borderRadius: BorderRadius.all(Radius.circular(JoloboxTheme.sizes.borderRadius)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.all(JoloboxTheme.sizes.themeScale(12.0)),
            constraints: const BoxConstraints(
              minWidth: 100.0
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class CustomDialogButton extends StatelessWidget {
  const CustomDialogButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.enable = true,
    this.color,
    this.textColor,
    this.disableTextColor,
    this.disableColor,
    this.splashMainColor
  }) : super(key: key);

  final String label;
  final Function() onPressed;
  final bool enable;
  final Color? color;
  final Color? textColor;
  final Color? disableTextColor;
  final Color? disableColor;
  final Color? splashMainColor;

  @override
  Widget build(BuildContext context) {
    Color lColor = color == null ? JoloboxTheme.colors.buttonSurface : color!;
    Color lTextColor = textColor == null ? JoloboxTheme.colors.text : textColor!;
    Color lDisableTextColor = disableTextColor == null ? JoloboxTheme.colors.inactiveButtonText : disableTextColor!;
    Color lDisableColor = disableColor == null ? JoloboxTheme.colors.inactiveButtonSurface : disableColor!;
    Color lSplashMainColor = splashMainColor == null ? JoloboxTheme.colors.primary : splashMainColor!;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: enable ? lColor : lDisableColor,
        borderRadius: BorderRadius.all(Radius.circular(JoloboxTheme.sizes.borderRadius)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashFactory: enable ? InkSplash.splashFactory : NoSplash.splashFactory,
          splashColor: lSplashMainColor.withAlpha(0x30),
          highlightColor: lSplashMainColor.withAlpha(0x20),
          onTap: enable ? onPressed : null,
          child: Container(
            padding: EdgeInsets.all(JoloboxTheme.sizes.themeScale(12.0)),
            constraints: const BoxConstraints(
                minWidth: 100.0
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: enable ? lTextColor : lDisableTextColor,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
    );
  }
}



class CustomSaveButton extends StatefulWidget {
  const CustomSaveButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.initiallyActive = false,
    this.setInitiallyActiveEveryRebuild = false,
  }) : super(key: key);

  final String label;
  final Function() onPressed;
  final bool initiallyActive;
  final bool setInitiallyActiveEveryRebuild;

  @override
  State<CustomSaveButton> createState() => CustomSaveButtonState();
}

class CustomSaveButtonState extends State<CustomSaveButton> {
  late bool _active;

  void pressedAction() {
    if (_active) {
      widget.onPressed();
    }
    setState(() {
      _active = false;
    });
  }

  void activateAction() {
    setState(() {
      _active = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _active = widget.initiallyActive;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.setInitiallyActiveEveryRebuild) {
      _active = widget.initiallyActive;
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: _active ? JoloboxTheme.colors.buttonSurface : JoloboxTheme.colors.textInputBackground,
        borderRadius: BorderRadius.all(Radius.circular(JoloboxTheme.sizes.borderRadius)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashFactory: _active ? InkSplash.splashFactory : NoSplash.splashFactory,
          splashColor: JoloboxTheme.colors.primary.withAlpha(0x30),
          highlightColor: JoloboxTheme.colors.primary.withAlpha(0x20),
          onTap: pressedAction,
          child: Container(
            padding: EdgeInsets.all(JoloboxTheme.sizes.themeScale(12.0)),
            constraints: const BoxConstraints(
                minWidth: 100.0
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: _active ? JoloboxTheme.colors.text : JoloboxTheme.colors.inactiveButtonText,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  width: JoloboxTheme.sizes.themeScale(8.0),
                ),
                Icon(
                  Icons.circle,
                  size: JoloboxTheme.sizes.themeScale(12.0),
                  color: _active ? JoloboxTheme.colors.primary : JoloboxTheme.colors.buttonSurface,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
