import 'package:flutter/material.dart';
import 'package:todo_app/navigation/ui_pages.dart';

class PageConfiguration {
  final String key;
  final String path;
  final Pages uiPage;
  final Widget Function() createPage;

  PageConfiguration({
    required this.key,
    required this.path,
    required this.uiPage,
    required this.createPage,
  });
}
