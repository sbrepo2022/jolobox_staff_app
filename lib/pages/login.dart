import 'package:flutter/material.dart';
import 'package:jolobox_staff_app/components/common/layouts/page_layouts.dart';
import 'package:provider/provider.dart';

import 'package:jolobox_staff_app/theme/theme_constants.dart';

import 'package:jolobox_staff_app/models/auth_model.dart';

import 'package:jolobox_staff_app/components/common/layouts/page_content_decorator.dart';
import 'package:jolobox_staff_app/components/common/layouts/root_page_decorator.dart';
import 'package:jolobox_staff_app/components/common/content_surface.dart';
import 'package:jolobox_staff_app/components/common/custom_inputs.dart';
import 'package:jolobox_staff_app/components/common/custom_buttons.dart';
import 'package:jolobox_staff_app/components/common/text_link.dart';
import 'package:jolobox_staff_app/components/common/page_title.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _authFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return RootPageDecorator(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('resources/images/app_bg.png'),
              fit: BoxFit.cover
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: PageContentDecorator(
            child: PageLayoutDefault(
              title: 'Авторизация',
              children: [
                const Spacer(flex: 1),
                SizedBox(height: JoloboxTheme.sizes.bigPadding),
                Form(
                  key: _authFormKey,
                  child: Center(
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: JoloboxTheme.sizes.themeScale(500.0),
                      ),
                      width: double.infinity,
                      child: ContentSurface(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                                child: Text('Не зарегистрированы?')
                            ),
                            const Center(
                              child: TextLink(label: 'Создать аккаунт', link: 'https://yandex.ru'),
                            ),
                            SizedBox(height: JoloboxTheme.sizes.smallPadding),
                            const CustomTextInput(label: 'Email'),
                            SizedBox(height: JoloboxTheme.sizes.smallPadding),
                            const CustomPasswordInput(label: 'Пароль'),
                            SizedBox(height: JoloboxTheme.sizes.smallPadding / 2),
                            const Align(
                                alignment: Alignment.centerRight,
                                child: Text('Забыли пароль?')
                            ),
                            const Align(
                              alignment: Alignment.centerRight,
                              child: TextLink(label: 'Восстановить', link: 'https://yandex.ru'),
                            ),
                            SizedBox(height: JoloboxTheme.sizes.bigPadding),
                            Center(
                              child: CustomPrimaryButton(
                                label: 'Вход',
                                onPressed: () {
                                  AuthModel authModel = Provider.of<AuthModel>(context, listen: false);
                                  authModel.isUserAuth = true;
                                  Navigator.pushReplacementNamed(context, '/AppPage');
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
