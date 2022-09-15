import 'package:flutter/material.dart';

import 'package:jolobox_staff_app/theme/theme_constants.dart';

import 'package:jolobox_staff_app/components/common/avatar_widget.dart';


class EmployeeChooseListTile extends StatefulWidget {
  const EmployeeChooseListTile({
    Key? key,
    this.leading,
    this.title,
    this.subtitle,
    required this.value,
    required this.groupValue,
    required this.onChanged
  }) : super(key: key);

  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final int value;
  final int groupValue;
  final Function(int?) onChanged;

  @override
  State<EmployeeChooseListTile> createState() => _EmployeeChooseListTileState();
}

class _EmployeeChooseListTileState extends State<EmployeeChooseListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        widget.onChanged(widget.value);
      },
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      leading: widget.leading,
      title: widget.title,
      subtitle: widget.subtitle,
      trailing: Radio<int>(
        visualDensity: const VisualDensity(
          vertical: VisualDensity.minimumDensity,
          horizontal: VisualDensity.minimumDensity,
        ),
        activeColor: JoloboxTheme.colors.primary,
        value: widget.value,
        groupValue: widget.groupValue,
        onChanged: widget.onChanged,
      ),
    );
  }
}


class EmployeeStaticListTile extends StatelessWidget {
  const EmployeeStaticListTile({
    Key? key,
    required this.avatarImage,
    required this.title,
    required this.subtitle
  }) : super(key: key);

  final Image avatarImage;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      leading: SizedBox(
        height: JoloboxTheme.sizes.themeScale(40.0),
        child: AvatarWidget(
          image: avatarImage,
          circleWidth: JoloboxTheme.sizes.themeScale(2.0),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color:  JoloboxTheme.colors.text,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color:  JoloboxTheme.colors.inactiveButtonText,
        ),
      ),
    );
  }
}
