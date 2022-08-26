import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/common/res/theme/theme.dart';
import 'package:todo_app/common/res/theme/todo_text_theme.dart';
import 'package:todo_app/data/models/todo_table.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/common/remote_config.dart';

class DropdownButtonDetail extends StatelessWidget {
  final ValueChanged<Importance?>? onChanged;
  final Importance dropdownValue;

  const DropdownButtonDetail({
    Key? key,
    required this.onChanged,
    required this.dropdownValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ColorsTheme>();
    final textStyles = Theme.of(context).extension<TodoTextTheme>();
    return DropdownButton(
      iconEnabledColor: Colors.transparent,
      underline: Container(
        color: colors!.separatorColor,
        height: 0.5,
      ),
      isExpanded: true,
      onChanged: onChanged,
      hint: dropdownValue == Importance.basic
          ? Text(
              getLabel(Importance.basic, context),
              style: textStyles?.button!.copyWith(
                color: colors.tertiaryColor,
              ),
            )
          : Text(
              getLabel(dropdownValue, context),
              style: textStyles?.body!.copyWith(
                color: colors.primaryColor,
              ),
            ),
      items: [
        DropdownMenuItem(
          value: Importance.basic,
          child: Text(
            getLabel(Importance.basic, context),
            style: textStyles?.body!.copyWith(
              color: colors.primaryColor,
            ),
          ),
        ),
        DropdownMenuItem(
          value: Importance.low,
          child: Text(
            getLabel(Importance.low, context),
            style: textStyles?.body!.copyWith(
              color: colors.primaryColor,
            ),
          ),
        ),
        DropdownMenuItem(
          value: Importance.important,
          child: Text(
            getLabel(Importance.important, context),
            style: textStyles?.body!.copyWith(
              color: AppRemoteConfig().getColor(context),
            ),
          ),
        ),
      ],
    );
  }

  String getLabel(
    Importance importance,
    BuildContext context,
  ) {
    switch (importance) {
      case Importance.low:
        return S.of(context).low;

      case Importance.basic:
        return S.of(context).basic;

      case Importance.important:
        return S.of(context).important;

      default:
        return S.of(context).basic;
    }
  }
}
