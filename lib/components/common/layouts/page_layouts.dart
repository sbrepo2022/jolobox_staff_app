import 'package:flutter/material.dart';

import 'package:jolobox_staff_app/theme/theme_constants.dart';
import 'package:jolobox_staff_app/components/common/page_title.dart';


class PageLayoutDefault extends StatelessWidget {
  const PageLayoutDefault({
    Key? key,
    required this.title,
    required this.children,
    this.actionButtons
  }) : super(key: key);

  final String title;
  final List<Widget> children;
  final List<Widget>? actionButtons;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                PageTitle(label: title),
                const Spacer(),
                ...?actionButtons
              ],
            ),
            SizedBox(height: JoloboxTheme.sizes.bigPadding),
            ...children
          ],
        )
      ),
    );
  }
}


class PageLayoutSliverList extends StatelessWidget {
  const PageLayoutSliverList({
    Key? key,
    required this.title,
    this.actionButtons,
    required this.delegate,
  }) : super(key: key);

  final String title;
  final List<Widget>? actionButtons;
  final SliverChildDelegate delegate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: PageSliverBar(
              expandedHeightFactor: 1.7,
              title: title,
              actionButtons: actionButtons,
            ),
          ),
          SliverList(
            delegate: delegate,
          ),
        ],
      ),
    );
  }
}

class PageLayoutSliverContainer extends StatelessWidget {
  const PageLayoutSliverContainer({
    Key? key,
    required this.title,
    this.actionButtons,
    required this.child,
  }) : super(key: key);

  final String title;
  final List<Widget>? actionButtons;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: PageSliverBar(
              expandedHeightFactor: 1.7,
              title: title,
              actionButtons: actionButtons,
            ),
          ),
          SliverToBoxAdapter(
            child: child,
          ),
        ],
      )
    );
  }
}


class PageLayoutCustomSlivers extends StatelessWidget {
  const PageLayoutCustomSlivers({
    Key? key,
    required this.title,
    this.actionButtons,
    required this.slivers,
  }) : super(key: key);

  final String title;
  final List<Widget>? actionButtons;
  final List<Widget> slivers;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: PageSliverBar(
              expandedHeightFactor: 1.7,
              title: title,
              actionButtons: actionButtons,
            ),
          ),
          ...slivers
        ],
      ),
    );
  }
}


class PageSliverBar extends SliverPersistentHeaderDelegate {
  PageSliverBar({
    required this.expandedHeightFactor,
    required this.title,
    this.actionButtons,
  });

  final double expandedHeightFactor;
  final String title;
  final List<Widget>? actionButtons;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    double maxShrinkOffset = maxExtent - minExtent;
    double calcShrinkOffset = shrinkOffset < maxShrinkOffset ? shrinkOffset : maxShrinkOffset;
    double expandFactor = 1.0 - calcShrinkOffset / (maxShrinkOffset);

    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Material(
          color: JoloboxTheme.colors.background.withOpacity(1.0 - expandFactor),
          elevation: expandFactor == 0.0 ? JoloboxTheme.sizes.surfaceElevation : 0.0,
          shadowColor: JoloboxTheme.colors.shadowColor,
          animationDuration: Duration.zero,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: JoloboxTheme.sizes.smallPadding * expandFactor + 16.0 * (1.0 - expandFactor)),
            child: Row(
              children: [
                PageTitle(
                  label: title,
                  expandFactor: expandFactor,
                ),
                const Spacer(),
                ...?actionButtons
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => kToolbarHeight * expandedHeightFactor;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

