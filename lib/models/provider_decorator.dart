import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jolobox_staff_app/models/auth_model.dart';
import 'package:jolobox_staff_app/models/session_model.dart';
import 'package:jolobox_staff_app/models/staff_model.dart';
import 'package:jolobox_staff_app/models/marks_model.dart';
import 'package:jolobox_staff_app/models/orders_model.dart';


class ProviderDecorator extends StatelessWidget {
  const ProviderDecorator({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthModel(),
        ),
        ChangeNotifierProxyProvider<AuthModel, SessionModel>(
          create: (context) => SessionModel(),
          update: (context, authModel, prevSessionModel) {
            if (prevSessionModel == null) {
              return SessionModel();
            }
            else {
              if (! authModel.isUserAuth) {
                prevSessionModel.isSessionActive = false;
              }
            }
            return prevSessionModel;
          },
        ),
        ChangeNotifierProxyProvider<SessionModel, StaffModel>(
          create: (context) => StaffModel(),
          update: (context, sessionModel, prevStaffModel) {
            if (prevStaffModel == null) {
              return StaffModel();
            }
            else {
              if (! sessionModel.isSessionActive) {
                prevStaffModel.employeeData = [];
              }
            }
            return prevStaffModel;
          },
        ),
        ChangeNotifierProxyProvider<SessionModel, MarksModel>(
          create: (context) => MarksModel(),
          update: (context, sessionModel, prevMarksModel) {
            if (prevMarksModel == null) {
              return MarksModel();
            }
            else {
              if (! sessionModel.isSessionActive) {
                prevMarksModel.marksData = [];
              }
            }
            return prevMarksModel;
          },
        ),
        ChangeNotifierProxyProvider<SessionModel, OrdersModel>(
          create: (context) => OrdersModel(),
          update: (context, sessionModel, prevOrdersModel) {
            if (prevOrdersModel == null) {
              return OrdersModel();
            }
            else {
              if (! sessionModel.isSessionActive) {
                prevOrdersModel.ordersData = [];
              }
            }
            return prevOrdersModel;
          },
        ),
      ],
      child: child,
    );
  }
}
