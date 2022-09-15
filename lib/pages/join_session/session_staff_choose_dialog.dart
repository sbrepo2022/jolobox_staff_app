import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jolobox_staff_app/theme/theme_constants.dart';

import 'package:jolobox_staff_app/components/common/choose_dialog.dart';
import 'package:jolobox_staff_app/components/common/avatar_widget.dart';
import 'package:jolobox_staff_app/components/common/divider_line.dart';
import 'package:jolobox_staff_app/components/common/staff_list_tiles.dart';

import 'package:jolobox_staff_app/models/staff_model.dart';


class SessionStaffChooseDialog extends StatefulWidget {
  const SessionStaffChooseDialog({Key? key}) : super(key: key);

  @override
  State<SessionStaffChooseDialog> createState() => _SessionStaffChooseDialogState();
}

class _SessionStaffChooseDialogState extends State<SessionStaffChooseDialog> {
  int _groupValue = -1;
  final GlobalKey<ChooseDialogState> _chooseDialogKey = GlobalKey<ChooseDialogState>();

  @override
  Widget build(BuildContext context) {
    StaffModel staffModel = Provider.of<StaffModel>(context);

    return ChooseDialog(
      key: _chooseDialogKey,
      title: 'Выбор сотрудника',
      acceptButtonLabel: 'Указать',
      acceptButtonEnabled: false,

      onChoose: () {
        Navigator.of(context).pop(_groupValue);
      },

      itemBuilder: (BuildContext context, int index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EmployeeChooseListTile(
              leading: SizedBox(
                height: JoloboxTheme.sizes.themeScale(40.0),
                child: AvatarWidget(
                  image: Image (
                      image: AssetImage(staffModel.employeeData[index].avatar),
                      fit: BoxFit.cover
                  ),
                  circleWidth: JoloboxTheme.sizes.themeScale(2.0),
                ),
              ),
              title: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: index == _groupValue
                ? TextStyle(
                  color:  JoloboxTheme.colors.primary,
                  fontFamily: JoloboxTheme.fonts.mainFontFamily,
                  fontWeight: FontWeight.w500,
                )
                : TextStyle(
                  color:  JoloboxTheme.colors.text,
                  fontFamily: JoloboxTheme.fonts.mainFontFamily,
                  fontWeight: FontWeight.w500,
                ),
                child: Text(
                  '${staffModel.employeeData[index].firstname} ${staffModel.employeeData[index].lastname}',
                )
              ),
              subtitle: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: index == _groupValue
                  ? TextStyle(
                    color:  JoloboxTheme.colors.secondary,
                    fontFamily: JoloboxTheme.fonts.mainFontFamily,
                  )
                  : TextStyle(
                    color:  JoloboxTheme.colors.inactiveButtonText,
                    fontFamily: JoloboxTheme.fonts.mainFontFamily,
                  ),
                  child: Text(
                    staffModel.employeeData[index].position,
                  )
              ),
              value: index,
              groupValue: _groupValue,
              onChanged: (value) {
                setState(() {
                  _groupValue = value!;
                  _chooseDialogKey.currentState!.acceptButtonEnable(_groupValue >= 0);
                });
              },
            ),

            Visibility(
                visible: index < staffModel.employeeData.length - 1,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: JoloboxTheme.sizes.smallPadding),
                    child: const DividerLine()
                )
            )
          ],
        );
      },

      itemCount: staffModel.employeeData.length,
    );
  }
}

