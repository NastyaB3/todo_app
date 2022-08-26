import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/common/firebase_analytics.dart';
import 'package:todo_app/navigation/page_configuration.dart';
import 'package:todo_app/navigation/ui_pages.dart';
import 'package:todo_app/screens/detail_screen/detail_screen.dart';
import 'package:todo_app/screens/list_todo_screen/main_screen.dart';

class TodoRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  final List<MaterialPage> _pages = [];

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  List<MaterialPage> get pages => List.unmodifiable(_pages);

  int numPages() => _pages.length;

  @override
  PageConfiguration? get currentConfiguration =>
      _pages.isNotEmpty ? _pages.last.arguments as PageConfiguration : null;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _onPopPage,
      pages: pages,
      observers: [
        AppFirebaseAnalytics().appAnalyticsObserver(),
      ],
    );
  }

  bool _onPopPage(Route<dynamic> route, result) {
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }
    _pages.remove(route.settings);
    notifyListeners();

    return true;
  }

  // @override
  // Future<bool> popRoute() {
  //   if (canPop()) {
  //     _removePage(_pages.last);
  //     return Future.value(true);
  //   }
  //   return Future.value(false);
  // }
  //
  // void _removePage(MaterialPage page) {
  //   if (page != null) {
  //     _pages.remove(page);
  //   }
  //   notifyListeners();
  // }
  //
  // bool canPop() {
  //   return _pages.length > 1;
  // }

  MaterialPage _createPage(Widget child, PageConfiguration pageConfig) {
    return MaterialPage(
      child: child,
      key: ValueKey(pageConfig.key),
      name: pageConfig.path,
      arguments: pageConfig,
    );
  }

  void _addPageData(Widget child, PageConfiguration pageConfig) {
    _pages.add(
      _createPage(child, pageConfig),
    );
  }

  void addPage(PageConfiguration pageConfig) {
    final shouldAddPage = _pages.isEmpty ||
        (_pages.last.arguments as PageConfiguration).uiPage !=
            pageConfig.uiPage;
    if (shouldAddPage) {
      switch (pageConfig.uiPage) {
        case Pages.listTodo:
          _addPageData(ListTodoScreen.newInstance(), ListTodoScreen.newPage());
          break;
        case Pages.detail:
          _addPageData(pageConfig.createPage(), pageConfig);
          break;
        default:
          break;
      }
    }
    notifyListeners();
  }

  void replace(PageConfiguration newRoute) {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
    }
    addPage(newRoute);
  }

  void setPath(List<MaterialPage> path) {
    _pages.clear();
    _pages.addAll(path);
  }

  void replaceAll(PageConfiguration newRoute) {
    setNewRoutePath(newRoute);
  }

  void push(PageConfiguration newRoute) {
    addPage(newRoute);
  }

  void pushWidget(Widget child, PageConfiguration newRoute) {
    _addPageData(child, newRoute);
  }

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) {
    final shouldAddPage = _pages.isEmpty ||
        (_pages.last.arguments as PageConfiguration).uiPage !=
            configuration.uiPage;
    if (shouldAddPage) {
      _pages.clear();
      addPage(configuration);
      notifyListeners();
    }
    notifyListeners();
    return SynchronousFuture(null);
  }

  void parseRoute(Uri uri) {
    if (uri.pathSegments.isEmpty) {
      setNewRoutePath(ListTodoScreen.newPage());
      return;
    }

    if (uri.pathSegments.length == 2) {
    } else if (uri.pathSegments.length == 1) {
      final path = uri.pathSegments[0];

      switch (path) {
        case 'listTodoPath':
          setPath([
            _createPage(ListTodoScreen.newInstance(), ListTodoScreen.newPage()),
          ]);
          break;
        case 'detailPath':
          setPath([
            _createPage(DetailScreen.newInstance(), DetailScreen.newPage()),
          ]);
          break;
        case 'detailPathTask':
          setPath([
            _createPage(ListTodoScreen.newInstance(), ListTodoScreen.newPage()),
          ]);
          setPath([
            _createPage(DetailScreen.newInstance(), DetailScreen.newPage()),
          ]);
          break;
      }
    }
  }
}
