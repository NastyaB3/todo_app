import 'package:flutter/material.dart';
import 'package:todo_app/navigation/page_configuration.dart';
import 'package:todo_app/navigation/ui_pages.dart';
import 'package:todo_app/screens/detail_screen/detail_screen.dart';
import 'package:todo_app/screens/list_todo_screen/main_screen.dart';

class AppRouteInformationParser
    extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final uri = Uri.parse(routeInformation.location ?? '');

    if (uri.pathSegments.isEmpty) {
      return ListTodoScreen.newPage();
    }

    final path = uri.pathSegments[0];

    switch (path) {
      case listTodoPath:
        return ListTodoScreen.newPage();
      case detailsPath:
        return DetailScreen.newPage();
      default:
        return ListTodoScreen.newPage();
    }
  }

  @override
  RouteInformation restoreRouteInformation(PageConfiguration configuration) {
    switch (configuration.uiPage) {
      case Pages.listTodo:
        return const RouteInformation(location: listTodoPath);
      case Pages.detail:
        return const RouteInformation(location: detailsPath);


      default:
        return const RouteInformation(location: listTodoPath);
    }
  }
}
