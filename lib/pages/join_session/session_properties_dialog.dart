import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jolobox_staff_app/theme/theme_constants.dart';

import 'package:jolobox_staff_app/components/common/custom_inputs.dart';
import 'package:jolobox_staff_app/components/common/layouts/dialog_layouts.dart';
import 'package:jolobox_staff_app/components/common/custom_buttons.dart';
import 'package:jolobox_staff_app/components/common/avatar_widget.dart';
import 'package:jolobox_staff_app/components/common/divider_line.dart';
import 'package:jolobox_staff_app/components/common/custom_placeholders.dart';
import 'package:jolobox_staff_app/components/common/custom_collapse.dart';
import 'package:jolobox_staff_app/components/common/staff_list_tiles.dart';
import 'package:jolobox_staff_app/pages/join_session/session_staff_choose_dialog.dart';

import 'package:jolobox_staff_app/models/staff_model.dart';


class JoinSessionSettings {
  JoinSessionSettings();
}


class SessionPropertiesDialog extends StatefulWidget {
  const SessionPropertiesDialog({Key? key, required this.onResult}) : super(key: key);

  final Function(JoinSessionSettings?) onResult;

  @override
  State<SessionPropertiesDialog> createState() => _SessionPropertiesDialogState();
}

class _SessionPropertiesDialogState extends State<SessionPropertiesDialog> {
  JoinSessionSettings? result;
  bool _isStaffSetupCollapsed = true;
  EmployeeData? _chooseEmployeeData;

  void _onChooseEmployeeData() async {
    StaffModel staffModel = Provider.of<StaffModel>(context, listen: false);
    int? staffIndex = await _chooseEmployeeDialogBuilder(context, staffModel);

    int? chooseStaffIndex;
    if (staffIndex != null) {
      chooseStaffIndex = staffIndex > -1 ? staffIndex : null;
    }
    else {
      chooseStaffIndex = null;
    }

    setState(() {
      _chooseEmployeeData = staffModel.employeeData[chooseStaffIndex!];
    });
  }

  Future<int?> _chooseEmployeeDialogBuilder(BuildContext context, StaffModel staffModel) async {
    await _updateStaffModel(staffModel);

    return showDialog<int>(
      context: context,
      builder: (context) {
        return const SessionStaffChooseDialog();
      }
    );
  }

  Future<void> _updateStaffModel(StaffModel staffModel) async {
    List<EmployeeData> staffData = await _getStaffData();
    staffModel.employeeData = staffData;
  }

  Future<List<EmployeeData>> _getStaffData() {
    return Future(() {
      return <EmployeeData>[
        EmployeeData(
          id: 1,
          avatar: 'resources/images/avatar_example.jpeg',
          firstname: 'Сергей',
          midname: 'Дмитриевич',
          lastname: 'Борисов',
          position: 'Официант'
        ),
        EmployeeData(
          id: 2,
          avatar: 'resources/images/avatar_example.jpeg',
          firstname: 'Сергей',
          midname: 'Дмитриевич',
          lastname: 'Борисов',
          position: 'Менеджер'
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return FullSizeDialogLayout(
      title: 'Вход в сессию',
      onWillPop: () async {
        widget.onResult(result);
        return false;
      },
      children: [
        SizedBox(height: JoloboxTheme.sizes.bigPadding),
        Center(
          child: SizedBox(
            height: JoloboxTheme.sizes.themeScale(150.0),
            child: AvatarWidget(
              image: const Image (
                  image: AssetImage('resources/images/house_example.png'),
                  fit: BoxFit.cover
              ),
              circleWidth: JoloboxTheme.sizes.themeScale(4.0),
            ),
          ),
        ),
        SizedBox(height: JoloboxTheme.sizes.smallPadding),
        Center(
          child: Text(
            'Jolobox Cafe',
            style: TextStyle(
                fontSize: JoloboxTheme.sizes.themeScale(24.0),
                fontWeight: FontWeight.w700
            ),
          ),
        ),
        SizedBox(height: JoloboxTheme.sizes.smallPadding),
        Center(
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'Сессия запущена: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now()),
                  style: TextStyle(
                    fontSize: JoloboxTheme.sizes.origTextSize,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: JoloboxTheme.sizes.smallPadding),
        const DividerLine(),
        SizedBox(height: JoloboxTheme.sizes.smallPadding),
        CustomCheckbox(
            title: 'Выйти на замену',
            isDefaultChecked: !_isStaffSetupCollapsed,
            onChanged: (isChecked) {
              setState(() {
                _isStaffSetupCollapsed = !(isChecked!);
              });
            }
        ),
        CustomCollapse(
          collapsed: _isStaffSetupCollapsed,
          child: Column(
            children: [
              SizedBox(height: JoloboxTheme.sizes.smallPadding / 2.0),
              IntrinsicHeight(
                child: Row(
                  children: [
                    const CollapseDecorationLine(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: JoloboxTheme.sizes.themeScale(250),
                            ),
                            child: _chooseEmployeeData == null
                            ? const StaffListElementPlaceholder()
                            : EmployeeStaticListTile(
                              avatarImage: Image(
                                  image: AssetImage(_chooseEmployeeData!.avatar),
                                  fit: BoxFit.cover
                              ),
                              title: '${_chooseEmployeeData!.firstname} ${_chooseEmployeeData!.lastname}',
                              subtitle: _chooseEmployeeData!.position,
                            ),
                          ),
                          SizedBox(height: JoloboxTheme.sizes.smallPadding / 2.0),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 8.0
                            ),
                            child: TextButton.icon(
                              onPressed: _onChooseEmployeeData,
                              icon: const Icon(
                                Icons.edit_rounded,
                              ),
                              label: const Text('указать сотрудника'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
        SizedBox(height: JoloboxTheme.sizes.bigPadding),
        Center(
          child: CustomDialogButton(
            label: 'Вход',
            onPressed: () {
              result = JoinSessionSettings();
              widget.onResult(result);
            },
          )
        ),
      ],
    );
  }
}
