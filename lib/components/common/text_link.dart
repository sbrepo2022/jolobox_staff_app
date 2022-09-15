import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:jolobox_staff_app/theme/theme_constants.dart';

class TextLink extends StatefulWidget {
  const TextLink({Key? key, required this.label, required this.link}) : super(key: key);

  final String label;
  final String link;

  @override
  State<TextLink> createState() => _TextLinkState();
}

class _TextLinkState extends State<TextLink> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(
        widget.label,
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontSize: JoloboxTheme.sizes.origTextSize,
          fontFamily: JoloboxTheme.fonts.mainFontFamily,
          decoration: _pressed ? TextDecoration.underline : TextDecoration.none,
        ),
      ),
      onTap: () async {
        String url = widget.link;
        if (await canLaunchUrlString(url)) {
          await launchUrlString(url);
        } else {
          throw 'Could not launch $url';
        }
      },
      onTapDown: (e) {
        setState(() => _pressed = true);
      },
      onTapUp: (e) {
        setState(() => _pressed = false);
      },
      onTapCancel: () {
        setState(() => _pressed = false);
      },
    );
  }
}
