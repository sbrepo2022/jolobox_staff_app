import 'dart:async';
import 'package:flutter/material.dart';

import 'package:jolobox_staff_app/models/orders_model.dart';
import 'package:provider/provider.dart';

import 'package:jolobox_staff_app/models/session_model.dart';

import 'package:jolobox_staff_app/theme/theme_constants.dart';

import 'package:jolobox_staff_app/components/common/layouts/page_content_decorator.dart';
import 'package:jolobox_staff_app/components/common/layouts/page_layouts.dart';
import 'package:jolobox_staff_app/components/common/content_surface.dart';
import 'package:jolobox_staff_app/components/current/session_enter_surface.dart';
import 'package:jolobox_staff_app/pages/join_session/session_info_dialog.dart';
import 'package:jolobox_staff_app/components/current/order_tile.dart';


class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  _onShowSessionInfoDialog() async {
    Completer sessionInfoCompleter = Completer();
    NavigatorState navigatorState = Navigator.of(context);

    navigatorState.push(
      MaterialPageRoute(
          builder: (context) => SessionInfoDialog(
            onResult: (SessionInfoResult? sessionInfoResult) {
              sessionInfoCompleter.complete(sessionInfoResult);
            },
          ),
          fullscreenDialog: true
      ),
    );

    SessionInfoResult? sessionInfoResult = await sessionInfoCompleter.future;
    navigatorState.pop();
  }

  // -- ТОЛЬКО ДЛЯ ПРИМЕРА --
  int lastId = 1;
  late Timer updateOrdersTimer;

  void setupOrdersTestTimer() {
    OrdersModel ordersModel = Provider.of<OrdersModel>(context, listen: false);
    updateOrdersTimer = Timer.periodic(
      const Duration(seconds: 10),
      (Timer timer) {
        SessionModel sessionModel = Provider.of<SessionModel>(context, listen: false);
        if (sessionModel.isSessionActive) {
          addOrderToModelTestCallback(ordersModel);
        }
      }
    );
  }

  void cancelOrdersTestTimer() {
    updateOrdersTimer.cancel();
  }

  void addOrderToModelTestCallback(OrdersModel ordersModel) {
    ordersModel.addOrders(
        [
          OrderData(
            id: lastId,
            markName: 'Стол $lastId',
            time: DateTime.now(),
            orderNumber: lastId,
            orderPositions: <OrderPositionData>[
              OrderPositionData(
                name: 'Капучино',
                count: 2,
              ),
              OrderPositionData(
                name: 'Паста карбонара',
                count: 1,
              ),
              OrderPositionData(
                name: 'Бизнес-ланч',
                count: 1,
                children: <OrderPositionData>[
                  OrderPositionData(
                      name: 'Мясо по-французски',
                      count: 1
                  ),
                  OrderPositionData(
                      name: 'Лимонад',
                      count: 2
                  ),
                ],
              ),
            ],
          ),
        ]
    );
    ++lastId;
  }
  // -- ТОЛЬКО ДЛЯ ПРИМЕРА --

  @override
  void initState() {
    super.initState();
    // здесь должен быть запуск таймера синхронизации или потока прослушивания вебсокетов

    // -- ТОЛЬКО ДЛЯ ПРИМЕРА --
    setupOrdersTestTimer();
    // -- ПОКА НЕЯСНО, БУДЕТ ОБНОВЛЕНИЕ ПО ТАЙМЕРУ ИЛИ ЧЕРЕЗ ВЕБСОКЕТЫ --
  }

  @override
  void dispose() {
    // здесь должно быть удаление таймера синхронизации

    // -- ТОЛЬКО ДЛЯ ПРИМЕРА --
    cancelOrdersTestTimer();
    // -- ПОКА НЕЯСНО, БУДЕТ ОБНОВЛЕНИЕ ПО ТАЙМЕРУ ИЛИ ЧЕРЕЗ ВЕБСОКЕТЫ --
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SessionModel sessionModel = Provider.of<SessionModel>(context);

    return PageContentDecorator(
      child: PageLayoutDefault(
        title: 'Заказы',
        actionButtons: sessionModel.isSessionActive ?
        [
          IconButton(
            color: JoloboxTheme.colors.primary,
            highlightColor: JoloboxTheme.colors.primary.withAlpha(0x30),
            splashColor: JoloboxTheme.colors.primary.withAlpha(0x30),
            splashRadius: JoloboxTheme.sizes.themeScale(32.0),
            iconSize: 32.0,
            visualDensity: const VisualDensity(
              vertical: VisualDensity.minimumDensity,
              horizontal: VisualDensity.minimumDensity,
            ),
            icon: const Icon(
              Icons.settings_rounded,
            ),
            onPressed: _onShowSessionInfoDialog,
          ),
        ]
            : [],
        children: [
          sessionModel.isSessionActive ?
          Center(
            child: Consumer<OrdersModel>(
              builder: (context, ordersModel, child) {
                int elemCount = ordersModel.ordersData.length;

                return elemCount > 0 ?
                Column(
                  children: [
                    ...ordersModel.ordersData.asMap().map((index, orderData) {
                      return MapEntry(
                        index,
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: index < ordersModel.ordersData.length - 1 ? JoloboxTheme.sizes.smallPadding : 0
                          ),
                          child: SizedBox(
                            width: 500,
                            child: OrderTile(
                              orderData: orderData,
                            )
                          ),
                        ),
                      );
                    }).values.toList(),
                  ],
                )
                : SizedBox(
                  width: 500,
                  child: ContentSurface(
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: JoloboxTheme.sizes.bigPadding),
                        child: Text(
                          'Нет существующих заказов',
                          style: TextStyle(
                            fontSize: JoloboxTheme.sizes.bigTextSize,
                            color: JoloboxTheme.colors.inactiveButtonText,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  )
                );
              },
            )
          )
          : Expanded(
            child: Column(
              children: [
                const Spacer(flex: 1),
                Center(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: JoloboxTheme.sizes.themeScale(500.0),
                    ),
                    width: double.infinity,
                    child: const SessionEnterSurface(),
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ],
      )
    );
  }
}
