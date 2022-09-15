import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jolobox_staff_app/models/session_model.dart';

import 'package:jolobox_staff_app/theme/theme_constants.dart';

import 'package:jolobox_staff_app/components/common/content_surface.dart';
import 'package:jolobox_staff_app/pages/join_session/join_session.dart';

class SessionEnterSurface extends StatelessWidget {
  const SessionEnterSurface({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentTitleSurface(
      title: 'Вход в сессию',
      children: [
        const Text(
          'Вы не вошли в сессию. Для входа отсканируйте QR-код, который вам выдал администратор.'
        ),
        SizedBox(height: JoloboxTheme.sizes.smallPadding),
        Center(
          child: TextButton.icon(
            onPressed: () async {
              SessionModel sessionModel = Provider.of<SessionModel>(context, listen: false);
              JoinSessionData data = await JoinSession.joinSession(Navigator.of(context));
              if (data.success) {
                sessionModel.isSessionActive = true;
              }
            },
            icon: const Icon(
              Icons.qr_code_rounded,
            ),
            label: const Text('сканировать QR'),
          ),
        ),
      ],
    );
  }
}
