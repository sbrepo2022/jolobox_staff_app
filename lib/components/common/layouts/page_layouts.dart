import 'package:flutter/material.dart';

import 'package:jolobox_staff_app/theme/theme_constants.dart';
import 'package:jolobox_staff_app/components/common/page_title.dart';


class PageLayoutDefault extends StatelessWidget {
  const PageLayoutDefault({
    Key? key,
    required this.title,
    required this.children,
    this.actionButtons
  }) : super(key: key);

  final String title;
  final List<Widget> children;
  final List<Widget>? actionButtons;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: JoloboxTheme.sizes.smallPadding,
        left: JoloboxTheme.sizes.smallPadding,
        bottom: JoloboxTheme.sizes.smallPadding,
        top: JoloboxTheme.sizes.smallPadding + MediaQuery.of(context).padding.top
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              PageTitle(label: title),
              const Spacer(),
              ...?actionButtons
            ],
          ),
          SizedBox(height: JoloboxTheme.sizes.bigPadding),
          ...children
        ],
      )
    );
  }
}
