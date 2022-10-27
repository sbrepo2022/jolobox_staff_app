import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:jolobox_staff_app/models/marks_model.dart';

import 'package:jolobox_staff_app/models/session_model.dart';

import 'package:jolobox_staff_app/theme/theme_constants.dart';

import 'package:jolobox_staff_app/components/common/layouts/page_content_decorator.dart';
import 'package:jolobox_staff_app/components/common/layouts/page_layouts.dart';
import 'package:jolobox_staff_app/components/common/content_surface.dart';
import 'package:jolobox_staff_app/components/current/session_enter_surface.dart';
import 'package:jolobox_staff_app/components/common/divider_line.dart';
import 'package:jolobox_staff_app/components/common/custom_collapse.dart';
import 'package:jolobox_staff_app/components/common/custom_inputs.dart';
import 'package:jolobox_staff_app/pages/join_session/session_info_dialog.dart';


class MarksPage extends StatefulWidget {
  const MarksPage({Key? key}) : super(key: key);

  @override
  State<MarksPage> createState() => _MarksPageState();
}

class _MarksPageState extends State<MarksPage> {
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

  Future<void> _updateMarksModel(MarksModel marksModel) async {
    List<MarkData> marksData = await _getMarksData();
    marksModel.marksData = marksData;
  }

  Future<List<MarkData>> _getMarksData() {
    return Future(() {
      return <MarkData>[
        MarkData(
          id: 1,
          name: 'Стол 1',
          value: false,
          notListen: true,
        ),
        MarkData(
          id: 2,
          name: 'Стол 2',
          value: false,
          notListen: true,
        ),
        MarkData(
          id: 3,
          name: 'Стол 3',
          value: false,
          notListen: true,
        ),
        MarkData(
          id: 4,
          name: 'Стол 4',
          value: false,
          notListen: true,
        ),
        MarkData(
          id: 5,
          name: 'Стол 5',
          value: false,
          notListen: true,
        ),
        MarkData(
          id: 6,
          name: 'Стол 6',
          value: false,
          notListen: true,
        ),
      ];
    });
  }

  @override
  void initState() {
    super.initState();
    // здесь должен быть запуск таймера синхронизации или потока прослушивания вебсокетов
  }

  @override
  void dispose() {
    // здесь должно быть удаление таймера синхронизации

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SessionModel sessionModel = Provider.of<SessionModel>(context);

    return PageContentDecorator(
      after: sessionModel.isSessionActive ?
      [
        Container(
          width: double.infinity,
          color: JoloboxTheme.colors.background,
          padding: EdgeInsets.symmetric(
            vertical: JoloboxTheme.sizes.smallPadding / 8,
            horizontal: JoloboxTheme.sizes.smallPadding,
          ),
          child: Row(
            children: [
              TextButton.icon(
                onPressed: () async {
                  // здесь должен быть запрос на сброс и синхронизацию

                  MarksModel marksModel = Provider.of<MarksModel>(context, listen: false);
                  await _updateMarksModel(marksModel);
                },
                icon: const Icon(
                  Icons.cached_rounded,
                ),
                label: const Text('сбросить'),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(JoloboxTheme.colors.danger),
                  overlayColor: MaterialStateProperty.all(JoloboxTheme.colors.danger.withAlpha(0x30)),
                ),
              ),
            ],
          ),
        ),
      ]
      : [],
      child: ! sessionModel.isSessionActive ?
      PageLayoutDefault(
        title: 'Метки',
        children: [
          Expanded(
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
      :
      PageLayoutSliverContainer(
        title: 'Метки',
        actionButtons: [
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
        ],
        child: Padding(
          padding: EdgeInsets.all(JoloboxTheme.sizes.smallPadding),
          child: Center(
            child: SizedBox(
              width: 500,
              child: ContentSurface(
                child: Consumer<MarksModel>(
                  builder: (context, marksModel, child) {
                    int elemCount = marksModel.marksData.length;
                    int marksNotListen = marksModel.marksData.where((element) => element.notListen).length;

                    return elemCount > 0 ?
                    Column(
                      children: [
                        ...marksModel.marksData.asMap().map((index, markData) {
                          void setCheckbox(bool? isChecked) {
                            if (isChecked != null) {
                              MarkData newMarkData = markData;
                              newMarkData.value = isChecked;

                              // -- ТОЛЬКО ДЛЯ ПРИМЕРА --
                              newMarkData.notListen = !isChecked;
                              // -- РЕАЛЬНО ЭТОТ ПАРАМЕТР ВОЗВРАЩАЕТСЯ С СЕРВЕРА ПОСЛЕ ОБНОВЛЕНИЯ --

                              marksModel.updateMark(newMarkData);

                              // здесь должна быть отправка на сервер обновления
                            }
                          }

                          return MapEntry(
                              index,
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setCheckbox(! markData.value);
                                    },
                                    splashFactory: NoSplash.splashFactory,
                                    highlightColor: Colors.transparent,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: JoloboxTheme.sizes.smallPadding / 4),
                                      child: Row(
                                        children: [
                                          CustomCheckbox(
                                            title: markData.name,
                                            isDefaultChecked: markData.value,
                                            setDefaultEveryRebuild: true,
                                            onChanged: setCheckbox,
                                          ),
                                          const Spacer(),
                                          Visibility(
                                              visible: markData.notListen,
                                              child: Container(
                                                  padding: EdgeInsets.only(left: JoloboxTheme.sizes.smallPadding / 4),
                                                  child: const Icon(
                                                    Icons.priority_high_rounded,
                                                    color: Colors.amber,
                                                  )
                                              )
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                  Visibility(
                                      visible: index < elemCount - 1,
                                      child: const DividerLine()
                                  ),
                                ],
                              )
                          );
                        }).values.toList(),

                        CustomCollapse(
                            collapsed: marksNotListen <= 0,
                            msDuration: 100,
                            child: Container(
                              padding: EdgeInsets.only(top: JoloboxTheme.sizes.smallPadding / 2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.warning_rounded,
                                    color: Colors.amber,
                                  ),
                                  SizedBox(width: JoloboxTheme.sizes.themeScale(8.0)),
                                  Text(
                                    'Столов не обслуживается: $marksNotListen',
                                    style: const TextStyle(
                                        color: Colors.amber
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                      ],
                    )
                    :
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: JoloboxTheme.sizes.bigPadding),
                        child: Text(
                          'Нет существующих меток',
                          style: TextStyle(
                            fontSize: JoloboxTheme.sizes.bigTextSize,
                            color: JoloboxTheme.colors.inactiveButtonText,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
