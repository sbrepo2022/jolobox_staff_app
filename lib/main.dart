import 'package:flutter/material.dart';

import 'package:jolobox_staff_app/models/provider_decorator.dart';
import 'package:jolobox_staff_app/theme/theme_constants.dart';

import 'package:jolobox_staff_app/pages/login.dart';
import 'package:jolobox_staff_app/pages/app.dart';
import 'package:jolobox_staff_app/pages/join_session/session_properties_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderDecorator(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Jolobox Staff',
          theme: ThemeData(
            fontFamily: JoloboxTheme.fonts.mainFontFamily,
            scaffoldBackgroundColor: JoloboxTheme.colors.background,
            textTheme: TextTheme(
              bodyText1: TextStyle(fontSize: JoloboxTheme.sizes.bigTextSize),
              bodyText2: TextStyle(fontSize: JoloboxTheme.sizes.origTextSize),
              button: TextStyle(fontSize: JoloboxTheme.sizes.origTextSize),
            ),
            colorScheme: ColorScheme.light(
              brightness: Brightness.light,
              primary: JoloboxTheme.colors.primary,
              onPrimary: Colors.white,
              secondary: JoloboxTheme.colors.secondary,
              onSecondary: Colors.white,
              background: JoloboxTheme.colors.background,
              onBackground: JoloboxTheme.colors.text,
              surface: JoloboxTheme.colors.background,
              onSurface: JoloboxTheme.colors.text,
            ),
            appBarTheme: AppBarTheme(
                elevation: 0,
                titleTextStyle: TextStyle(
                    fontSize: JoloboxTheme.sizes.bigTextSize,
                    fontWeight: FontWeight.w600,
                    color: JoloboxTheme.colors.text,
                    fontFamily: 'Montserrat'
                )
            )
        ),
        initialRoute: '/AppPage', // не забыть установить флаг авторизации и сессии в false в качестве дефолта
        routes: {
          '/AppPage': (context) => const AppPage(),
          '/LoginPage': (context) => const LoginPage(),
        }
      )
    );
  }
}

