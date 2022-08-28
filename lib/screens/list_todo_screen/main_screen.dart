import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/common/di/app_config.dart';
import 'package:todo_app/common/firebase_analytics.dart';
import 'package:todo_app/common/res/theme/theme.dart';
import 'package:todo_app/common/res/theme/todo_text_theme.dart';
import 'package:todo_app/common/utils.dart';
import 'package:todo_app/data/models/todo_table.dart';
import 'package:todo_app/data/repositories/todo_repository.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/domain/details_cubit/detail_cubit.dart';
import 'package:todo_app/domain/todo_actions/todo_actions_cubit.dart';
import 'package:todo_app/domain/todo_list_cubit/todo_list_cubit.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/main_core.dart';
import 'package:todo_app/navigation/page_configuration.dart';
import 'package:todo_app/navigation/ui_pages.dart';
import 'package:todo_app/common/remote_config.dart';
import 'package:todo_app/screens/detail_screen/detail_screen.dart';
import 'package:todo_app/screens/list_todo_screen/header_delegate.dart';
import 'package:todo_app/screens/list_todo_screen/task_widget.dart';
import 'package:todo_app/widgets/retry_widget.dart';
import 'package:todo_app/widgets/text_field_custom.dart';
import 'package:uuid/uuid.dart';

class ListTodoScreen extends StatefulWidget {
  static PageConfiguration newPage() {
    return PageConfiguration(
      key: 'ListTodoScreen',
      path: listTodoPath,
      uiPage: Pages.listTodo,
      createPage: () {
        return ListTodoScreen.newInstance();
      },
    );
  }

  static Widget newInstance() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return TodoCubit(
              getIt.get<TodoRepository>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return DetailCubit(
              getIt.get<TodoRepository>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return TodoActionsCubit(
              getIt.get<TodoRepository>(),
            );
          },
        ),
      ],
      child: const ListTodoScreen._(),
    );
  }

  const ListTodoScreen._();

  @override
  State<ListTodoScreen> createState() => _ListTodoScreenState();
}

class _ListTodoScreenState extends State<ListTodoScreen> {
  final _controller = TextEditingController();
  bool hideCompleted = false;

  TodoCubit get _todoCubit => BlocProvider.of<TodoCubit>(context);

  DetailCubit get _detailCubit => BlocProvider.of<DetailCubit>(context);

  TodoActionsCubit get _todoActionCubit =>
      BlocProvider.of<TodoActionsCubit>(context);

  @override
  void initState() {
    super.initState();
    _todoCubit.fetch(
      hideCompleted: hideCompleted,
      refresh: true,
    );
    AppRemoteConfig().initConfig();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ColorsTheme>();
    final textStyles = Theme.of(context).extension<TodoTextTheme>();
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 100;
    return Scaffold(
      key: const ValueKey('todo_screen'),
      backgroundColor: colors?.backPrimaryColor,
      floatingActionButton: !keyboardVisible
          ? FloatingActionButton(
              backgroundColor: colors!.blueColor,
              foregroundColor: colors.whiteColor,
              heroTag: null,
              onPressed: () {
                router.push(
                  DetailScreen.newPage(),
                );
                AppFirebaseAnalytics().addTask();
                AppFirebaseAnalytics().logScreens(name: 'Detail Screen');
              },
              child: const Icon(Icons.add),
            )
          : null,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: BlocBuilder<TodoCubit, TodoState>(
              builder: (context, state) {
                if (state is TodoListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is TodoListError) {
                  return RetryWidget.withMessage(
                    message: Utils.getErrorMsg(state.err, context),
                    style: textStyles!.body,
                    callback: () {
                      _todoCubit.fetch(
                        hideCompleted: hideCompleted,
                        refresh: true,
                      );
                    },
                  );
                }
                if (state is TodoListSuccess) {
                  return CustomScrollView(
                    slivers: [
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: StickyHeaderDelegate(
                          topPadding: MediaQuery.of(context).padding.top,
                          countDone: state.contDone,
                          onToggleHideCompleted: () {
                            toggleHideCompleted();
                          },
                          hideCompleted: hideCompleted,
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: state.todos.length + 1,
                          (context, index) {
                            if (index == state.todos.length) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: BlocBuilder<DetailCubit, DetailState>(
                                  builder: (context, state) {
                                    return TextFieldCustom(
                                      maxLines: 1,
                                      controller: _controller,
                                      onSubmitted: (text) async {
                                        _detailCubit.add(
                                          task: TodoTableData(
                                            id: const Uuid().v4(),
                                            title: _controller.text,
                                            importance: Importance.basic,
                                            done: false,
                                            createdAt: DateTime.now(),
                                            changedAt: DateTime.now(),
                                            lastUpdatedBy: Platform.isAndroid
                                                ? (await DeviceInfoPlugin()
                                                            .androidInfo)
                                                        .id ??
                                                    ''
                                                : (await DeviceInfoPlugin()
                                                            .iosInfo)
                                                        .identifierForVendor ??
                                                    '',
                                          ),
                                        );
                                        AppFirebaseAnalytics().addTask();
                                        _controller.clear();
                                      },
                                      hintText: S.of(context).newDeal,
                                      prefixIcon: Container(
                                        padding:
                                            const EdgeInsets.only(left: 21),
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.transparent,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                            final task = state.todos[index];
                            return TaskWidget(
                              task: task,
                              index: index,
                              length: state.todos.length,
                              toggleDone: (task) {
                                _todoActionCubit.toggleDone(
                                  task,
                                );
                                AppFirebaseAnalytics().doneTask();
                              },
                              toggleDelete: (task) {
                                _todoActionCubit.delete(task);
                                AppFirebaseAnalytics().deleteTask();
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
          if (Config.appFlavor != Flavor.release)
            Align(
              alignment: Alignment.topRight,
              child: Banner(
                location: BannerLocation.topEnd,
                message: getFlavor(),
              ),
            ),
        ],
      ),
    );
  }

  String getFlavor() {
    switch (Config.appFlavor) {
      case Flavor.dev:
        return 'Dev';
      case Flavor.release:
        return 'Release';
      default:
        return 'Dev';
    }
  }

  void toggleHideCompleted() {
    setState(() {
      hideCompleted = !hideCompleted;
      _todoCubit.fetch(
        hideCompleted: hideCompleted,
        refresh: false,
      );
    });
  }
}
