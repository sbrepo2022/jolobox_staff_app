import 'package:flutter/material.dart';

import 'package:jolobox_staff_app/theme/theme_constants.dart';

import 'package:jolobox_staff_app/components/common/layouts/root_page_decorator.dart';
import 'package:jolobox_staff_app/components/common/app_bars/app_bar_main.dart';

import 'package:jolobox_staff_app/pages/orders.dart';
import 'package:jolobox_staff_app/pages/marks.dart';
import 'package:jolobox_staff_app/pages/work.dart';
import 'package:jolobox_staff_app/pages/profile.dart';

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    OrdersPage(),
    MarksPage(),
    WorkPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
          appBar: AppBarMain(),
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: SizedBox(
            height: JoloboxTheme.sizes.bottomNavbarHeight,

            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color> [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary
                  ],
                ),
              ),

              child: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.assignment_rounded),
                      label: 'Заказы',
                      backgroundColor: Colors.transparent
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.qr_code_rounded),
                      label: 'Метки',
                      backgroundColor: Colors.transparent
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.work),
                      label: 'Работа',
                      backgroundColor: Colors.transparent
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
                    label: 'Профиль',
                    backgroundColor: Colors.transparent,
                  ),
                ],
                currentIndex: _selectedIndex,
                backgroundColor: Colors.transparent,
                elevation: 0,
                selectedItemColor: Theme.of(context).colorScheme.onPrimary,
                unselectedItemColor: JoloboxTheme.colors.onPrimaryInactive,
                selectedLabelStyle: TextStyle(
                  fontSize: JoloboxTheme.sizes.bottomNavbarFontSize,
                  fontWeight: FontWeight.bold,
                ),
                onTap: _onItemTapped,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
