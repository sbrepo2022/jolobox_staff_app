import 'package:flutter/material.dart';

import 'package:jolobox_staff_app/theme/theme_constants.dart';

class StaffListElementPlaceholder extends StatelessWidget {
  const StaffListElementPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: const VisualDensity(
        vertical: VisualDensity.minimumDensity,
        horizontal: VisualDensity.minimumDensity,
      ),
      leading: Container(
        width: JoloboxTheme.sizes.themeScale(40.0),
        height: JoloboxTheme.sizes.themeScale(40.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(JoloboxTheme.sizes.themeScale(40.0)),
          color: JoloboxTheme.colors.buttonSurface,
        ),
      ),
      title: Transform.translate(
        offset: Offset(0, JoloboxTheme.sizes.themeScale(-6.0)),
        child: Container(
          height: JoloboxTheme.sizes.themeScale(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(JoloboxTheme.sizes.themeScale(12.0)),
            color: JoloboxTheme.colors.buttonSurface,
          ),
        ),
      ),
      subtitle: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              height: JoloboxTheme.sizes.themeScale(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(JoloboxTheme.sizes.themeScale(12.0)),
                color: JoloboxTheme.colors.buttonSurface,
              ),
            ),
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
