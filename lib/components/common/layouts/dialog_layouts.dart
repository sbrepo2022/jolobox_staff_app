import 'package:flutter/material.dart';

import 'package:jolobox_staff_app/theme/theme_constants.dart';

import 'package:jolobox_staff_app/components/common/app_bars/app_bar_dialog.dart';


class DefaultDialogLayout extends StatefulWidget {
  const DefaultDialogLayout({Key? key, required this.children, this.onScrolledToTop}) : super(key: key);

  final List<Widget> children;
  final void Function(bool)? onScrolledToTop;

  @override
  State<DefaultDialogLayout> createState() => _DefaultDialogLayoutState();
}

class _DefaultDialogLayoutState extends State<DefaultDialogLayout> {
  static const double _emptySpace = 10.0;
  bool _isScrolledToTop = true;
  final ScrollController _controller = ScrollController();

  void _scrollListener() {
    if (_controller.offset <= _controller.position.minScrollExtent && !_controller.position.outOfRange) {
      if(!_isScrolledToTop) {
        _isScrolledToTop = true;
        widget.onScrolledToTop!(_isScrolledToTop);
      }
    }
    else {
      if(_controller.offset > _emptySpace && _isScrolledToTop) {
        _isScrolledToTop = false;
        widget.onScrolledToTop!(_isScrolledToTop);
      }
    }
  }

  @override
  void initState() {
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _controller,
      physics: const ClampingScrollPhysics(),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          minHeight: MediaQuery.of(context).size.height - (Scaffold.of(context).appBarMaxHeight ?? 0.0) - JoloboxTheme.sizes.bottomNavbarHeight,
        ),
        child: IntrinsicHeight(
          child: Container(
              padding: EdgeInsets.only(
                  right: JoloboxTheme.sizes.smallPadding,
                  left: JoloboxTheme.sizes.smallPadding,
                  bottom: JoloboxTheme.sizes.smallPadding,
                  top: JoloboxTheme.sizes.smallPadding + MediaQuery.of(context).padding.top
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...(widget.children),
                ],
              )
          ),
        ),
      ),
    );
  }
}


class FullSizeDialogLayout extends StatelessWidget {
  FullSizeDialogLayout({
    Key? key,
    this.title = 'Full Size Dialog',
    required this.onWillPop,
    required this.children
  }) : super(key: key);

  final String title;
  final Future<bool> Function() onWillPop;
  final List<Widget> children;

  final ValueNotifier<bool> _isScrolledToTop = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: ValueListenableBuilder<bool>(
        valueListenable: _isScrolledToTop,
        builder: (context, value, child) {
          return Scaffold(
            appBar: AppBarDialog(
              title: title,
              showElevation: !value,
            ),
            body: child!,
          );
        },
        child: DefaultDialogLayout(
          onScrolledToTop: (bool isScrolledToTop) {
            _isScrolledToTop.value = isScrolledToTop;
          },
          children: children
        ),
      ),
    );
  }
}


