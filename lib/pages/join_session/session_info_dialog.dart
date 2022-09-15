import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:jolobox_staff_app/models/session_model.dart';
import 'package:provider/provider.dart';

import 'package:jolobox_staff_app/theme/theme_constants.dart';

import 'package:jolobox_staff_app/components/common/layouts/dialog_layouts.dart';
import 'package:jolobox_staff_app/components/common/custom_buttons.dart';
import 'package:jolobox_staff_app/components/common/avatar_widget.dart';
import 'package:jolobox_staff_app/components/common/divider_line.dart';
import 'package:jolobox_staff_app/components/common/staff_list_tiles.dart';

import 'package:jolobox_staff_app/models/staff_model.dart';


class SessionInfoResult {
  SessionInfoResult();
}


class SessionInfoDialog extends StatefulWidget {
  const SessionInfoDialog({Key? key, required this.onResult}) : super(key: key);

  final Function(SessionInfoResult?) onResult;

  @override
  State<SessionInfoDialog> createState() => _SessionInfoDialogState();
}

class _SessionInfoDialogState extends State<SessionInfoDialog> {
  SessionInfoResult? result;

  @override
  Widget build(BuildContext context) {
    return FullSizeDialogLayout(
      title: 'Информация о сессии',
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
        Center(
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'Вы вошли в сессию:\n',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: DateFormat('HH ч mm мин ').format(DateTime.now()),
                  style: TextStyle(
                    fontSize: JoloboxTheme.sizes.origTextSize,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const TextSpan(
                  text: 'назад',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: JoloboxTheme.sizes.smallPadding),
        const DividerLine(),
        SizedBox(height: JoloboxTheme.sizes.smallPadding),

        Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: JoloboxTheme.sizes.themeScale(500.0),
            ),
            child: const EmployeeStaticListTile(
              avatarImage: Image(
                  image: AssetImage('resources/images/avatar_example.jpeg'),
                  fit: BoxFit.cover
              ),
              title: 'Сергей Борисов',
              subtitle: 'Официант',
            ),
          ),
        ),

        SizedBox(height: JoloboxTheme.sizes.smallPadding),
        const Center(
          child: Text(
            'Вышел на замену сотрудника:',
            style: TextStyle(
              fontWeight: FontWeight.w700
            ),
          ),
        ),
        SizedBox(height: JoloboxTheme.sizes.smallPadding),

        Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: JoloboxTheme.sizes.themeScale(500.0),
            ),
            child: const EmployeeStaticListTile(
              avatarImage: Image(
                image: AssetImage('resources/images/avatar_example.jpeg'),
                fit: BoxFit.cover
              ),
              title: 'Сергей Борисов',
              subtitle: 'Официант',
            ),
          ),
        ),

        SizedBox(height: JoloboxTheme.sizes.bigPadding),
        Center(
          child: CustomDialogButton(
            label: 'Выход из сессии',
            onPressed: () {
              SessionModel sessionModel = Provider.of<SessionModel>(context, listen: false);
              sessionModel.isSessionActive = false;
              widget.onResult(result);
            },
            color: JoloboxTheme.colors.danger,
            textColor: JoloboxTheme.colors.background,
            splashMainColor: JoloboxTheme.colors.background
          )
        ),
      ],
    );
  }
}
