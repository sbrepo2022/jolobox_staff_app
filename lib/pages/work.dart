import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import 'package:jolobox_staff_app/theme/theme_constants.dart';

import 'package:jolobox_staff_app/components/common/custom_tab_bar.dart';
import 'package:jolobox_staff_app/components/common/layouts/page_content_decorator.dart';
import 'package:jolobox_staff_app/components/common/layouts/page_layouts.dart';
import 'package:jolobox_staff_app/components/common/content_surface.dart';

class WorkPage extends StatefulWidget {
  const WorkPage({Key? key}) : super(key: key);

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  ValueNotifier<int> workTabIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return PageContentDecorator(
      child: PageLayoutCustomSlivers(
        title: 'Работа',
        slivers: <Widget>[
          SliverStickyHeader.builder(
            builder: (context, state) {
              return AnimatedContainer(
                padding: EdgeInsets.symmetric(vertical: JoloboxTheme.sizes.smallPadding / 2),
                decoration: BoxDecoration(
                    color: JoloboxTheme.colors.background.withOpacity(state.isPinned ? 1.0 : 0.0),
                    border: Border(
                        bottom: BorderSide(
                          color: JoloboxTheme.colors.buttonSurface.withOpacity(state.isPinned ? 1.0 : 0.0),
                        )
                    )
                ),
                duration: const Duration(milliseconds: 100),
                child: Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ValueListenableBuilder<int>(
                      valueListenable: workTabIndex,
                      builder: (context, value, child) {
                        return CustomTabBar(
                          currentIndex: workTabIndex.value,
                          tabData: const[
                            CustomTabData(
                              title: 'Моя работа',
                            ),
                            CustomTabData(
                              title: 'Приглашения',
                            ),
                          ],
                          onIndexChanged: (index) {
                            workTabIndex.value = index;
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
            },
            sliver: SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                  left: JoloboxTheme.sizes.smallPadding,
                  right: JoloboxTheme.sizes.smallPadding,
                  bottom: JoloboxTheme.sizes.smallPadding,
                ),
                child: Center(
                  child: SizedBox(
                    width: 500,
                    child: ContentSurface(
                      child: Column(
                        children: const [
                          Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),
                          Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),
                          Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),
                          Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),
                          Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),
                          Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),
                          Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),
                          Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),
                          Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),
                          Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),
                          Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),
                          Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),Text('HELLO WORLD!'),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
