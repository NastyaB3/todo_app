import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/common/res/images.dart';
import 'package:todo_app/common/res/theme/theme.dart';
import 'package:todo_app/common/res/theme/todo_text_theme.dart';
import 'package:todo_app/data/models/todo_table.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/common/remote_config.dart';
import 'package:todo_app/screens/detail_screen/detail_screen.dart';

class TaskWidget extends StatelessWidget {
  final TodoTableData task;
  final int index;
  final int length;
  final Function(TodoTableData task) toggleDone;
  final Function(TodoTableData task) toggleDelete;

  const TaskWidget({
    Key? key,
    required this.task,
    required this.index,
    required this.length,
    required this.toggleDone,
    required this.toggleDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ColorsTheme>();
    final textStyles = Theme.of(context).extension<TodoTextTheme>();
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: colors!.backSecondaryColor,
        borderRadius: index == 0
            ? const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              )
            : index == length
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
              toggleDone(task);
            },
          ),
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    toggleDone(task);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right: 27),
                    alignment: Alignment.centerRight,
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
          ],
        ),
        endActionPane: ActionPane(
          extentRatio: 0.18,
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(
            onDismissed: () {
              toggleDelete(task);
            },
          ),
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    toggleDelete(task);
                  },
                  child: Container(
                    alignment: Alignment.center,
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
                  padding: const EdgeInsets.only(right: 3.0),
                  child: SvgPicture.asset(
                    Images.icPriority,
                    color: AppRemoteConfig().getColor(context),
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
                          decoration: TextDecoration.lineThrough,
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
                  style:
                      textStyles?.button!.copyWith(color: colors.tertiaryColor),
                )
              : null,
          trailing: InkWell(
            child: Icon(
              Icons.info_outline,
              color: colors.tertiaryColor,
            ),
            onTap: () {
              router.push(DetailScreen.newPage(todoTableData: task));
            },
          ),
          leading: Container(
            color: (task.importance == Importance.important)
                ? AppRemoteConfig().getColor(context).withOpacity(0.16)
                : Colors.transparent,
            height: 18,
            width: 18,
            child: Checkbox(
              fillColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return colors.greenColor;
                  }
                  if (task.importance == Importance.important) {
                    return AppRemoteConfig().getColor(context);
                  }
                  return colors.separatorColor;
                },
              ),
              checkColor: colors.backSecondaryColor,
              activeColor: colors.greenColor,
              onChanged: (bool? value) {
                toggleDone(task);
              },
              value: task.done,
            ),
          ),
        ),
      ),
    );
  }
}
