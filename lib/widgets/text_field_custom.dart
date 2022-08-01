import 'package:flutter/material.dart';

import '../common/res/theme/theme.dart';
import '../common/res/theme/todo_text_theme.dart';

class TextFieldCustom extends StatelessWidget {
  String hintText;
  Widget? prefixIcon;
  ValueChanged<String>? onChanged;
  TextEditingController? controller;
  String? errorText;

  TextFieldCustom({
    Key? key,
    required this.hintText,
    this.prefixIcon,
    this.onChanged,
    this.controller,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ColorsTheme>();
    final textStyles = Theme.of(context).extension<TodoTextTheme>();
    return TextField(
      onChanged: onChanged,
      style: textStyles!.body!.copyWith(color: colors!.primaryColor),
      controller: controller,
      decoration: InputDecoration(
        errorText: errorText,
        fillColor: colors.whiteColor,
        filled: true,
        hintText: hintText,
        hintStyle: textStyles.body!.copyWith(color: colors.tertiaryColor),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: colors.whiteColor!,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colors.whiteColor!,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colors.whiteColor!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colors.whiteColor!,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: prefixIcon,
      ),
    );
  }
}
