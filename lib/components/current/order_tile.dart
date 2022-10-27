import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';

import 'package:jolobox_staff_app/models/orders_model.dart';

import 'package:jolobox_staff_app/theme/theme_constants.dart';

import 'package:jolobox_staff_app/components/common/content_surface.dart';
import 'package:jolobox_staff_app/components/common/divider_line.dart';
import 'package:jolobox_staff_app/components/common/custom_collapse.dart';
import 'package:jolobox_staff_app/components/common/custom_inputs.dart';
import 'package:jolobox_staff_app/components/common/custom_buttons.dart';

class OrderTile extends StatefulWidget {
  const OrderTile({
    Key? key,
    required this.orderData
  }) : super(key: key);

  final OrderData orderData;

  @override
  State<OrderTile> createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  final ValueNotifier<bool> _isOpen = ValueNotifier<bool>(false);

  String _formatDuration(Duration duration) {
    String result = '';
    result += (duration.inDays > 0 ? '${duration.inDays} дней ' : '');
    result += (result == '' ? (duration.inHours.remainder(24) > 0 ? '${duration.inHours.remainder(24)} ч ' : '') : '');
    result += (result == '' ? (duration.inMinutes.remainder(60) > 0 ? '${duration.inMinutes.remainder(60)} мин ' : '') : '');
    result += (result != '' ? 'назад' : 'только что');
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return ContentSurface(
      padding: EdgeInsets.symmetric(
        vertical: JoloboxTheme.sizes.smallPadding / 2,
        horizontal: JoloboxTheme.sizes.smallPadding,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(widget.orderData.markName),
                      SizedBox(width: JoloboxTheme.sizes.themeScale(8.0)),
                      Builder(
                        builder: (context) {
                          switch (widget.orderData.status) {
                            case OrderStatus.notViewed:
                              return Container(
                                width: JoloboxTheme.sizes.themeScale(10.0),
                                height: JoloboxTheme.sizes.themeScale(10.0),
                                margin: EdgeInsets.all(JoloboxTheme.sizes.themeScale(5.0)),
                                decoration: BoxDecoration(
                                  color: JoloboxTheme.colors.primary,
                                  borderRadius: BorderRadius.circular(JoloboxTheme.sizes.themeScale(10.0)),
                                ),
                              );

                            case OrderStatus.viewed:
                              return Container();

                            case OrderStatus.processing:
                              return Icon(
                                  Icons.autorenew_rounded,
                                  size: JoloboxTheme.sizes.themeScale(18.0),
                                  color: JoloboxTheme.colors.primary
                              );

                            case OrderStatus.finished:
                              return Icon(
                                  Icons.done_all_rounded,
                                  size: JoloboxTheme.sizes.themeScale(18.0),
                                  color: JoloboxTheme.colors.success
                              );
                          }
                        }
                      ),
                    ],
                  ),
                  Text(
                    _formatDuration(DateTime.now().difference(widget.orderData.time)),
                    style: TextStyle(
                      color:  JoloboxTheme.colors.inactiveButtonText,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              Text(
                '#${widget.orderData.orderNumber.toString().padLeft(3, '0')}',
                style: TextStyle(
                  color:  JoloboxTheme.colors.inactiveButtonText,
                ),
              ),
              SizedBox(width: JoloboxTheme.sizes.themeScale(8.0)),
              ExpandButton(
                onPressed: (opened) {
                  _isOpen.value = opened;

                  OrdersModel ordersModel = Provider.of<OrdersModel>(context, listen: false);
                  if (widget.orderData.status == OrderStatus.notViewed) {
                    widget.orderData.status = OrderStatus.viewed;
                  }
                  ordersModel.updateOrder(widget.orderData);
                }
              )
            ],
          ),

          ValueListenableBuilder<bool>(
            valueListenable: _isOpen,
            builder: (context, value, child) {
              return CustomCollapse(
                collapsed: !value,
                child: child!,
              );
            },
            child: Column(
              children: [
                SizedBox(height: JoloboxTheme.sizes.smallPadding / 2),
                const DividerLine(),
                SizedBox(height: JoloboxTheme.sizes.smallPadding / 2),
                ...widget.orderData.orderPositions.asMap().map((index, orderPosition) {
                  return MapEntry(
                    index,
                    Column(
                      children: [
                        // Mim posp dju dju dju dju dju dju
                        // Mim pops ai kak vkusno nyam nyam nyam
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                orderPosition.name
                              )
                            ),
                            Text(
                              'x ${orderPosition.count}'
                            ),
                          ],
                        ),

                        orderPosition.children != null ?
                        Padding(
                          padding: EdgeInsets.only(top: JoloboxTheme.sizes.themeScale(4.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...orderPosition.children!.mapIndexed((index, orderPositionChild) {
                                return IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              margin: EdgeInsets.only(left: JoloboxTheme.sizes.smallPadding / 2),
                                              width: 1.0,
                                              color: const Color(0xFFC4C4C4)
                                            ),
                                          ),
                                          Visibility(
                                            visible: orderPosition.children!.length - 1 == index ? true : false,
                                            child: const Spacer(flex: 1)
                                          )
                                        ],
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: JoloboxTheme.sizes.smallPadding / 4),
                                          child: Row(
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(right: JoloboxTheme.sizes.smallPadding / 2),
                                                  height: 1.0,
                                                  width: JoloboxTheme.sizes.themeScale(10.0),
                                                  color: const Color(0xFFC4C4C4)
                                              ),
                                              Expanded(
                                                child: Text(
                                                    orderPositionChild.name
                                                ),
                                              ),
                                              Text(
                                                  'x ${orderPositionChild.count}'
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                        )
                        : const SizedBox.shrink(),

                        Visibility(
                          visible: widget.orderData.orderPositions.length - 1 > index,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: JoloboxTheme.sizes.smallPadding / 2),
                            child: const DividerLine(),
                          )
                        ),
                      ],
                    ),
                  );
                }).values.toList(),

                SizedBox(height: JoloboxTheme.sizes.smallPadding),

                Row(
                  children: [
                    const Spacer(),
                    CustomSaveButton(
                      label: 'Начать',
                      initiallyActive: widget.orderData.status == OrderStatus.viewed,
                      setInitiallyActiveEveryRebuild: true,
                      onPressed: () {
                        OrdersModel ordersModel = Provider.of<OrdersModel>(context, listen: false);
                        widget.orderData.status = OrderStatus.processing;
                        ordersModel.updateOrder(widget.orderData);
                      }
                    ),
                    SizedBox(width: JoloboxTheme.sizes.smallPadding / 2),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color(0xFFC4C4C4)
                    ),
                    SizedBox(width: JoloboxTheme.sizes.smallPadding / 2),
                    CustomSaveButton(
                      label: 'Завершить',
                      initiallyActive: widget.orderData.status == OrderStatus.processing,
                      setInitiallyActiveEveryRebuild: true,
                      onPressed: () {
                        OrdersModel ordersModel = Provider.of<OrdersModel>(context, listen: false);
                        widget.orderData.status = OrderStatus.finished;
                        ordersModel.updateOrder(widget.orderData);
                      }
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
