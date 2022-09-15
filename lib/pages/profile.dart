import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:jolobox_staff_app/theme/theme_constants.dart';

import 'package:jolobox_staff_app/models/auth_model.dart';

import 'package:jolobox_staff_app/components/common/layouts/page_content_decorator.dart';
import 'package:jolobox_staff_app/components/common/layouts/page_layouts.dart';
import 'package:jolobox_staff_app/components/common/content_surface.dart';
import 'package:jolobox_staff_app/components/common/custom_inputs.dart';
import 'package:jolobox_staff_app/components/common/custom_buttons.dart';
import 'package:jolobox_staff_app/components/common/avatar_widget.dart';
import 'package:jolobox_staff_app/components/common/divider_line.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _staffDataFormKey = GlobalKey<FormState>();
  final _passwordChangeFormKey = GlobalKey<FormState>();
  final _logoutFormKey = GlobalKey<FormState>();
  Map<dynamic, dynamic> saveButtons = {};
  File? _avatar;

  void _formChanged(Key? formKey) {
    saveButtons[formKey].currentState.activateAction();
  }

  @override
  void initState() {
    super.initState();

    saveButtons = {
      _staffDataFormKey: GlobalKey<CustomSaveButtonState>(),
      _passwordChangeFormKey: GlobalKey<CustomSaveButtonState>(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return PageContentDecorator(
      child: PageLayoutDefault(
        title: 'Профиль',
        children: [
          Form(
            key: _staffDataFormKey,
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: JoloboxTheme.sizes.themeScale(500.0),
                ),
                width: double.infinity,
                child: ContentTitleSurface(
                  title: 'Основные данные',
                  children: [
                    Center(
                      child: SizedBox(
                        height: JoloboxTheme.sizes.themeScale(150.0),

                        child: AvatarWidget(
                          image: _avatar != null
                            ? Image.file(
                              _avatar!,
                              fit: BoxFit.cover
                            )
                            : const Image (
                              image: AssetImage('resources/images/avatar_example.jpeg'),
                              fit: BoxFit.cover
                          ),
                          circleWidth: JoloboxTheme.sizes.themeScale(4.0),
                        ),
                      ),
                    ),
                    Center(
                      child: TextButton.icon(
                        onPressed: () async {
                          XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                          if (image != null) {
                            setState(() {
                              _avatar = File(image.path);
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.add_a_photo,
                        ),
                        label: const Text('выбрать фото'),
                      ),
                    ),
                    SizedBox(height: JoloboxTheme.sizes.smallPadding),
                    CustomTextInput(
                      label: 'Имя',
                      formKey: _staffDataFormKey,
                      onChanged: _formChanged,
                    ),
                    SizedBox(height: JoloboxTheme.sizes.smallPadding),
                    CustomTextInput(
                      label: 'Фамилия',
                      formKey: _staffDataFormKey,
                      onChanged: _formChanged,
                    ),
                    SizedBox(height: JoloboxTheme.sizes.smallPadding),
                    CustomTextInput(
                      label: 'Отчество',
                      formKey: _staffDataFormKey,
                      onChanged: _formChanged,
                    ),
                    SizedBox(height: JoloboxTheme.sizes.smallPadding),
                    const DividerLine(),
                    SizedBox(height: JoloboxTheme.sizes.smallPadding),
                    CustomRadioGroup(
                      label: 'Пол',
                      formKey: _staffDataFormKey,
                      onChanged: _formChanged,
                      list: const [
                        {
                          'title': 'Мужской',
                          'value': 0,
                        },
                        {
                          'title': 'Женский',
                          'value': 1,
                        },
                      ],
                    ),
                    SizedBox(height: JoloboxTheme.sizes.smallPadding),
                    const DividerLine(),
                    SizedBox(height: JoloboxTheme.sizes.smallPadding),
                    CustomDateTimeInput(
                      label: 'Дата рождения',
                      formKey: _staffDataFormKey,
                      onChanged: _formChanged,
                    ),
                    SizedBox(height: JoloboxTheme.sizes.bigPadding),
                    Center(
                      child: CustomSaveButton(
                        key: saveButtons[_staffDataFormKey],
                        label: 'Сохранить',
                        onPressed: () {

                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: JoloboxTheme.sizes.bigPadding),

          Form(
            key: _passwordChangeFormKey,
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
                      Text(
                          'Смена пароля',
                          style: TextStyle(
                              fontSize: JoloboxTheme.sizes.bigTextSize,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      SizedBox(height: JoloboxTheme.sizes.smallPadding),
                      CustomPasswordInput(
                        label: 'Старый пароль',
                        formKey: _passwordChangeFormKey,
                        onChanged: _formChanged,
                      ),
                      SizedBox(height: JoloboxTheme.sizes.smallPadding),
                      const DividerLine(),
                      SizedBox(height: JoloboxTheme.sizes.smallPadding),
                      CustomPasswordInput(
                        label: 'Новый пароль',
                        formKey: _passwordChangeFormKey,
                        onChanged: _formChanged,
                      ),
                      SizedBox(height: JoloboxTheme.sizes.smallPadding),
                      CustomPasswordInput(
                        label: 'Повтор пароля',
                        formKey: _passwordChangeFormKey,
                        onChanged: _formChanged,
                      ),
                      SizedBox(height: JoloboxTheme.sizes.bigPadding),
                      Center(
                        child: CustomSaveButton(
                          key: saveButtons[_passwordChangeFormKey],
                          label: 'Сохранить',
                          onPressed: () {

                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: JoloboxTheme.sizes.bigPadding),

          Form(
            key: _logoutFormKey,
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
                      Text(
                          'Выход из аккаунта',
                          style: TextStyle(
                              fontSize: JoloboxTheme.sizes.bigTextSize,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      SizedBox(height: JoloboxTheme.sizes.smallPadding),

                      SizedBox(
                        width: double.infinity,
                        child: TextButton.icon(
                          onPressed: () {
                            AuthModel authModel = Provider.of<AuthModel>(context, listen: false);
                            authModel.isUserAuth = false;
                            Navigator.pushReplacementNamed(context, '/LoginPage');
                          },
                          icon: const Icon(
                            Icons.logout_rounded,
                          ),
                          label: const Text('выход'),
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(JoloboxTheme.colors.danger),
                            overlayColor: MaterialStateProperty.all(JoloboxTheme.colors.danger.withAlpha(0x30)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
