import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:todo_app/common/res/images.dart';
import 'package:todo_app/data/models/todo_table.dart';
import 'package:todo_app/domain/todo_actions/todo_actions_cubit.dart';
import 'package:todo_app/navigation/routes.dart';
import 'package:todo_app/widgets/text_field_custom.dart';
import 'package:uuid/uuid.dart';
import '../common/di/app_config.dart';
import '../common/res/theme/theme.dart';
import '../common/res/theme/todo_text_theme.dart';
import '../data/repositories/todo_repository.dart';
import '../database/database.dart';
import '../domain/details_cubit/detail_cubit.dart';
import '../domain/todo_list_cubit/todo_list_cubit.dart';
import '../generated/l10n.dart';
import '../navigation/controller.dart';
import '../widgets/retry_widget.dart';

class MainScreen extends StatefulWidget {
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
      child: const MainScreen._(),
    );
  }

  const MainScreen._();

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _controller = TextEditingController();
  bool hideCompleted = false;

  TodoCubit get _todoCubit => BlocProvider.of<TodoCubit>(context);

  DetailCubit get _detailCubit => BlocProvider.of<DetailCubit>(context);

  TodoActionsCubit get _todoActionCubit =>
      BlocProvider.of<TodoActionsCubit>(context);
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> _initConfig() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(seconds: 10),
      ),
    );

    await _remoteConfig.fetchAndActivate();
  }

  @override
  void initState() {
    super.initState();
    _todoCubit.fetch(
      hideCompleted: hideCompleted,
      refresh: true,
    );
    _initConfig();
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
      backgroundColor: colors?.backPrimaryColor,
      floatingActionButton: !keyboardVisible
          ? FloatingActionButton(
              backgroundColor: colors!.blueColor,
              onPressed: () {
                context
                    .read<NavigationController>()
                    .navigateTo(Routes.detailScreen);
              },
              child: const Icon(Icons.add),
            )
          : null,
      body: GestureDetector(
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
                message: state.err.toString(),
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
                                        lastUpdatedBy: await PlatformDeviceId
                                                .getDeviceId ??
                                            '',
                                      ),
                                    );
                                    _controller.clear();
                                  },
                                  hintText: S.of(context).newDeal,
                                  prefixIcon: Container(
                                    padding: const EdgeInsets.only(left: 21),
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
                        return Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: colors!.whiteColor,
                            borderRadius: index == 0
                                ? const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  )
                                : index == state.todos.length
                                    ? const BorderRadius.only(
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      )
                                    : null,
                          ),
                          child: Slidable(
                            key: ValueKey(task),
                            startActionPane: ActionPane(
                                extentRatio: 0.18,
                                motion: const ScrollMotion(),
                                dismissible: DismissiblePane(
                                  onDismissed: () {
                                    _todoActionCubit.toggleDone(
                                      task,
                                    );
                                  },
                                ),
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: InkWell(
                                        onTap: () {
                                          _todoActionCubit.toggleDone(
                                            task,
                                          );
                                        },
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(right: 27),
                                          alignment: Alignment.centerRight,
                                          width: 72,
                                          color: colors.greenColor!,
                                          child: Icon(
                                            Icons.check,
                                            size: 24,
                                            color: colors.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                            endActionPane: ActionPane(
                              extentRatio: 0.18,
                              motion: const ScrollMotion(),
                              dismissible: DismissiblePane(
                                onDismissed: () {
                                  _todoActionCubit.delete(
                                    task,
                                  );
                                },
                              ),
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: InkWell(
                                      onTap: () {
                                        _todoActionCubit.delete(
                                          task,
                                        );
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 72,
                                        color: colors.redColor!,
                                        child: Icon(
                                          Icons.delete,
                                          size: 24,
                                          color: colors.whiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            child: ListTile(
                              minLeadingWidth: 10,
                              title: Row(
                                children: [
                                  if (task.importance == Importance.important)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 3.0),
                                      child: SvgPicture.asset(
                                        Images.icPriority,
                                        color: _remoteConfig
                                                .getString('color_importance')
                                                .isNotEmpty
                                            ? const Color(0xff793cd8)
                                            : colors.redColor,
                                      ),
                                    ),
                                  if (task.importance == Importance.low)
                                    Icon(
                                      Icons.arrow_downward_sharp,
                                      color: colors.grayColor,
                                      size: 20,
                                    ),
                                  Expanded(
                                    child: Text(
                                      task.title,
                                      style: task.done == true
                                          ? textStyles?.body!.copyWith(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: colors.tertiaryColor,
                                            )
                                          : textStyles?.body,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: (task.deadline != null)
                                  ? Text(
                                      DateFormat('d MMMM yyyy', 'ru_RU')
                                          .format(task.deadline!)
                                          .toString(),
                                      style: textStyles?.button!.copyWith(
                                          color: colors.tertiaryColor),
                                    )
                                  : null,
                              trailing: InkWell(
                                child: Icon(
                                  Icons.info_outline,
                                  color: colors.tertiaryColor,
                                ),
                                onTap: () {
                                  context
                                      .read<NavigationController>()
                                      .navigateTo(
                                        Routes.detailScreen,
                                        arguments: task,
                                      );
                                },
                              ),
                              leading: Container(
                                color: (task.importance == Importance.important)
                                    ? _remoteConfig
                                            .getString('color_importance')
                                            .isNotEmpty
                                        ? const Color(0xff793cd8)
                                            .withOpacity(0.16)
                                        : colors.redColor?.withOpacity(0.16)
                                    : Colors.transparent,
                                height: 18,
                                width: 18,
                                child: Checkbox(
                                  fillColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return colors.greenColor;
                                      }
                                      if (task.importance ==
                                              Importance.important &&
                                          (_remoteConfig
                                              .getString('color_importance')
                                              .isEmpty)) {
                                        return colors.redColor;
                                      }
                                      if (_remoteConfig
                                              .getString('color_importance')
                                              .isNotEmpty &&
                                          task.importance ==
                                              Importance.important) {
                                        return const Color(0xff793cd8);
                                      }
                                      return colors.separatorColor;
                                    },
                                  ),
                                  checkColor: colors.whiteColor,
                                  activeColor: colors.greenColor,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _todoActionCubit.toggleDone(task);
                                    });
                                  },
                                  value: task.done,
                                ),
                              ),
                            ),
                          ),
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
    );
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

class StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double topPadding;
  final int countDone;
  final VoidCallback onToggleHideCompleted;
  final bool hideCompleted;

  StickyHeaderDelegate({
    required this.topPadding,
    required this.countDone,
    required this.onToggleHideCompleted,
    required this.hideCompleted,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final colors = Theme.of(context).extension<ColorsTheme>()!;
    if (shrinkOffset > 40 &&
        MediaQuery.of(context).orientation == Orientation.portrait) {
      return Container(
        decoration: BoxDecoration(
          color: colors.backPrimaryColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 4),
              blurRadius: 5,
            )
          ],
        ),
        padding: EdgeInsets.only(
          left: 16,
          top: topPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                S.of(context).appBar,
                style: Theme.of(context).extension<TodoTextTheme>()?.title,
              ),
            ),
            InkWell(
              onTap: onToggleHideCompleted,
              child: Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: hideCompleted
                      ? Icon(
                          Icons.visibility_off,
                          color: colors.blueColor,
                        )
                      : Icon(
                          Icons.remove_red_eye,
                          color: colors.blueColor,
                        )),
            ),
          ],
        ),
      );
    }

    if (shrinkOffset < 40 &&
        MediaQuery.of(context).orientation == Orientation.portrait) {
      return Container(
        padding: EdgeInsets.only(
          left: 60,
          top: MediaQuery.of(context).padding.top +
              kToolbarHeight -
              shrinkOffset,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).appBar,
              style: Theme.of(context).extension<TodoTextTheme>()?.largeTitle,
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${S.of(context).done} —  $countDone',
                  style: Theme.of(context)
                      .extension<TodoTextTheme>()
                      ?.body
                      ?.copyWith(
                        color: Theme.of(context)
                            .extension<ColorsTheme>()
                            ?.tertiaryColor,
                      ),
                ),
                InkWell(
                  onTap: onToggleHideCompleted,
                  child: Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: hideCompleted
                          ? Icon(
                              Icons.visibility_off,
                              color: colors.blueColor,
                            )
                          : Icon(
                              Icons.remove_red_eye,
                              color: colors.blueColor,
                            )),
                ),
              ],
            ),
          ],
        ),
      );
    }
    return Container(
      padding: EdgeInsets.only(
          left: 60, top: MediaQuery.of(context).padding.top + kToolbarHeight),
      child: Text(
        S.of(context).appBar,
        style: Theme.of(context).extension<TodoTextTheme>()?.largeTitle,
      ),
    );
  }

  @override
  double get maxExtent => 140 + topPadding;

  @override
  double get minExtent => kToolbarHeight + topPadding;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
