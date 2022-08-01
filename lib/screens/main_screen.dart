import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/res/images.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/domain/todo_actions/todo_actions_cubit.dart';
import 'package:todo_app/navigation/routes.dart';
import 'package:todo_app/widgets/text_field_custom.dart';

import '../common/di/app_config.dart';
import '../common/res/theme/theme.dart';
import '../common/res/theme/todo_text_theme.dart';
import '../data/repositories/todo_repository.dart';
import '../domain/todo_list_cubit/todo_list_cubit.dart';
import '../generated/l10n.dart';
import '../navigation/controller.dart';

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
  late ScrollController controller;
  bool _chekbox = false;

  TodoCubit get _todoCubit => BlocProvider.of<TodoCubit>(context);

  TodoActionsCubit get _todoActionCubit =>
      BlocProvider.of<TodoActionsCubit>(context);

  Color getColor(Set<MaterialState> states) {
    return Theme.of(context).extension<ColorsTheme>()!.separatorColor!;
  }

  @override
  void initState() {
    super.initState();
    _todoCubit.fetch();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ColorsTheme>();
    final textStyles = Theme.of(context).extension<TodoTextTheme>();
    return Scaffold(
      backgroundColor: colors?.backPrimaryColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: colors!.blueColor,
        onPressed: () {
          context.read<NavigationController>().navigateTo(Routes.detailScreen);
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state is TodoListLoading) {
            return const CircularProgressIndicator();
          }
          if (state is TodoListSuccess) {
            return CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: StickyHeaderDelegate(
                    topPadding: MediaQuery.of(context).padding.top,
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.todos.length + 1,
                    (context, index) {
                      if (index == state.todos.length) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextFieldCustom(
                            hintText: 'Новое',
                            prefixIcon: Container(
                              padding: const EdgeInsets.only(left: 21),
                              child: const Icon(
                                Icons.add,
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        );
                      }
                      final task = state.todos[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: colors.whiteColor,
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
                          startActionPane: ActionPane(
                              extentRatio: 0.18,
                              motion: const ScrollMotion(),
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: InkWell(
                                      onTap: () {
                                        _todoActionCubit.toggleDone(task);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(right: 27),
                                        alignment: Alignment.centerRight,
                                        width: 72,
                                        color: colors.greenColor!,
                                        child: Icon(
                                          Icons.check,
                                          size: 17,
                                          color: colors.whiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              CustomSlidableAction(
                                onPressed: (context) {
                                  setState(() {
                                    _todoActionCubit.delete(task);
                                  });
                                },
                                backgroundColor: colors.redColor!,
                                child: SvgPicture.asset(
                                  Images.icTrash,
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task.title,
                                  style: textStyles?.body,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                                task.deadline != null
                                    ? Text(
                                        task.deadline.toString(),
                                        style: textStyles?.body,
                                      )
                                    : Container(),
                              ],
                            ),
                            trailing: InkWell(
                              child: Icon(
                                Icons.info_outline,
                                color: colors.tertiaryColor,
                              ),
                              onTap: () {},
                            ),
                            leading: Checkbox(
                              checkColor: colors.whiteColor,
                              activeColor: colors.greenColor,
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                              onChanged: (bool? value) {
                                setState(() {
                                  _todoActionCubit.toggleDone(task);
                                });
                              },
                              value: task.done,
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
    );
  }
}

class StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  double topPadding;

  StickyHeaderDelegate({required this.topPadding});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final colors = Theme.of(context).extension<ColorsTheme>()!;
    print(shrinkOffset);
    if (shrinkOffset > 40 &&
        MediaQuery.of(context).orientation == Orientation.portrait) {
      return Container(
        height: kToolbarHeight + topPadding,
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
        child: Center(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              S.of(context).appBar,
              style: Theme.of(context).extension<TodoTextTheme>()?.title,
            ),
          ),
        ),
      );
    }

    if (shrinkOffset < 40 &&
        MediaQuery.of(context).orientation == Orientation.portrait) {
      return Positioned(
        top: MediaQuery.of(context).padding.top + kToolbarHeight,
        child: Container(
          // color: Theme.of(context).backgroundColor,
          padding: EdgeInsets.only(
            left: 60,
            top: MediaQuery.of(context).padding.top + kToolbarHeight,
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
                    S.of(context).done,
                    style: Theme.of(context)
                        .extension<TodoTextTheme>()
                        ?.body
                        ?.copyWith(
                          color: Theme.of(context)
                              .extension<ColorsTheme>()
                              ?.tertiaryColor,
                        ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: Icon(
                        Icons.remove_red_eye,
                        color: colors.blueColor,
                      )),
                ],
              ),
            ],
          ),
        ),
      );
    }
    return Container(
      // color: Theme.of(context).backgroundColor,
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
  // double get minExtent => kToolbarHeight + topPadding;
  double get minExtent => 0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
