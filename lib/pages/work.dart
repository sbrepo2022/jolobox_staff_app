import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:jolobox_staff_app/components/common/layouts/page_content_decorator.dart';
import 'package:jolobox_staff_app/theme/theme_constants.dart';

class WorkPage extends StatefulWidget {
  const WorkPage({Key? key}) : super(key: key);

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  @override
  Widget build(BuildContext context) {
    return const PageContentDecorator(
      child: Center(
        child: Text('WorkPage'),
      ),
    );
  }
}
