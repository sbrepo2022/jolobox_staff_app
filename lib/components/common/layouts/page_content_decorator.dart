import 'package:flutter/material.dart';

import 'package:jolobox_staff_app/theme/theme_constants.dart';

class PageContentDecorator extends StatelessWidget {
  const PageContentDecorator({Key? key, this.before, this.after, required this.child}) : super(key: key);

  final List<Widget>? before;
  final List<Widget>? after;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...?before,

        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: constraints.maxWidth,
                      minHeight: constraints.maxHeight
                  ),
                  child: IntrinsicHeight(
                    child: child,
                  ),
                ),
              );
            }
          ),
        ),

        ...?after
      ],
    );
  }
}