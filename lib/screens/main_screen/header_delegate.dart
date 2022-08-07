import 'package:flutter/material.dart';
import 'package:todo_app/common/res/theme/theme.dart';
import 'package:todo_app/common/res/theme/todo_text_theme.dart';
import 'package:todo_app/generated/l10n.dart';

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