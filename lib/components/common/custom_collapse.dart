import 'package:flutter/material.dart';
import 'package:jolobox_staff_app/theme/theme_constants.dart';


class CustomCollapse extends StatefulWidget {
  const CustomCollapse({
    Key? key,
    required this.collapsed,
    required this.child,
    this.msDuration = 250,
  }) : super(key: key);

  final bool collapsed;
  final Widget child;
  final int msDuration;

  @override
  State<CustomCollapse> createState() => _CustomCollapseState();
}

class _CustomCollapseState extends State<CustomCollapse> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  late bool _closed;

  late bool _oldCollapsed;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: widget.msDuration), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOutCubic
      ),
    );
    _closed = widget.collapsed;
    _oldCollapsed = widget.collapsed;
    if (widget.collapsed == false) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateAnimation() {
    if (_oldCollapsed != widget.collapsed) {
      _controller.reset();
      if (!widget.collapsed) {
        _closed = false;
        _controller.forward();
      }
      else {
        _controller.forward().then((value) => _closed = true);
      }
      _oldCollapsed = widget.collapsed;
    }
  }

  @override
  void didUpdateWidget(CustomCollapse oldWidget) {
    _updateAnimation();
    super.didUpdateWidget(oldWidget);
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller.view,
      builder: (context, child) {
        return Offstage(
          offstage: _closed,
          child: TickerMode(
            enabled: !_closed,
            child: ClipRect(
              child: Align(
                alignment: Alignment.topLeft,
                heightFactor: widget.collapsed ? 1.0 - _animation.value : _animation.value,
                child: child,
              ),
            ),
          ),
        );
      },
      child: widget.child
    );
  }
}

class CollapseDecorationLine extends StatelessWidget {
  const CollapseDecorationLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4.0,
      margin: const EdgeInsets.only(
        left: 8.0,
        right: 6.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(JoloboxTheme.sizes.themeScale(4.0))),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color> [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary
          ]
        ),
      ),
    );
  }
}

