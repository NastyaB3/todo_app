import 'package:todo_app/navigation/ui_pages.dart';

class PageConfiguration {
  final String key;
  final String path;
  final Pages uiPage;
  final Function createPage;

  PageConfiguration({
    required this.key,
    required this.path,
    required this.uiPage,
    required this.createPage,
  });
}
