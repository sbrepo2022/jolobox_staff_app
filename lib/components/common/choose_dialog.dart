import 'package:flutter/material.dart';
import 'package:expand_tap_area/expand_tap_area.dart';

import 'package:jolobox_staff_app/theme/theme_constants.dart';
import 'package:jolobox_staff_app/components/common/custom_buttons.dart';


class ChooseDialog extends StatefulWidget {
  const ChooseDialog({
    Key? key,
    this.title = 'Choose dialog',
    this.acceptButtonLabel = 'Accept',
    this.acceptButtonEnabled = true,
    required this.itemBuilder,
    required this.itemCount,
    required this.onChoose
  }) : super(key: key);

  final String title;
  final String acceptButtonLabel;
  final bool acceptButtonEnabled;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final int itemCount;
  final Function() onChoose;

  @override
  State<ChooseDialog> createState() => ChooseDialogState();
}

class ChooseDialogState extends State<ChooseDialog> {
  final ValueNotifier<bool> _isScrolledToTop = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _isScrolledToBottom = ValueNotifier<bool>(true);
  late ValueNotifier<bool> _acceptButtonEnabled;
  final ScrollController _scrollController = ScrollController();

  void _scrollListener() {

    if (_scrollController.position.atEdge) {
      bool isTop = _scrollController.offset == 0;
      if (isTop) {
        _isScrolledToTop.value = true;
      } else {
        _isScrolledToBottom.value = true;
      }
    }
    else {
      if (_isScrolledToTop.value) {
        _isScrolledToTop.value = false;
      }
      if (_isScrolledToBottom.value) {
        _isScrolledToBottom.value = false;
      }
    }
  }

  void acceptButtonEnable(bool state) {
    _acceptButtonEnabled.value = state;
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);

    _acceptButtonEnabled = ValueNotifier<bool>(widget.acceptButtonEnabled);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Material(
        color: JoloboxTheme.colors.background,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.all(Radius.circular(JoloboxTheme.sizes.borderRadius)),
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ValueListenableBuilder<bool>(
                valueListenable: _isScrolledToTop,
                builder: (context, value, child) {
                  return Material(
                    elevation: value ? 0.0 : 4.0,
                    color: JoloboxTheme.colors.background,
                    child: child!,
                  );
                },

                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(JoloboxTheme.sizes.smallPadding),
                        child: Text(
                          widget.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          )
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(JoloboxTheme.sizes.smallPadding / 2),
                      child: InkResponse(
                        radius: JoloboxTheme.sizes.themeScale(24.0),
                        onTap: () {
                          Navigator.of(context).pop(null);
                        },
                        child: Container(
                          padding: EdgeInsets.all(JoloboxTheme.sizes.smallPadding / 2),
                          child: const Icon(
                            Icons.close_rounded,
                          ),
                        ),
                      ),
                    ),
                  ]
                ),
              ),

              Flexible(
                child: ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemBuilder: widget.itemBuilder,
                  itemCount: widget.itemCount,
                ),
              ),

              ValueListenableBuilder<bool>(
                valueListenable: _isScrolledToBottom,
                builder: (context, value, child) {
                  return Material(
                    elevation: value ? 0.0 : 4.0,
                    color: JoloboxTheme.colors.background,
                    child: child!,
                  );
                },

                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: JoloboxTheme.sizes.smallPadding / 2,
                    horizontal: JoloboxTheme.sizes.smallPadding,
                  ),
                  child: Center(
                    child: ValueListenableBuilder<bool>(
                      valueListenable: _acceptButtonEnabled,
                      builder: (context, value, child) {
                        return CustomDialogButton(
                          enable: value,
                          label: widget.acceptButtonLabel,
                          onPressed: widget.onChoose,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
