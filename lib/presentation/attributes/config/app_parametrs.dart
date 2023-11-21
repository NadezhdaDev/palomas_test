import 'package:flutter/material.dart';

GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

BuildContext? globalContext() => globalKey.currentContext;