import 'package:flutter/material.dart';
import 'package:todo_app/navigation/router_delegate.dart';

class BackDispatcher extends RootBackButtonDispatcher {
  final TodoRouterDelegate _routerDelegate;

  BackDispatcher(this._routerDelegate);

  @override
  Future<bool> didPopRoute() {
    return _routerDelegate.popRoute();
  }
}

