import 'package:flutter/material.dart';
import 'package:todo_app/common/res/theme/theme.dart';
import 'package:todo_app/common/res/theme/todo_text_theme.dart';


class TextFieldCustom extends StatelessWidget {
  final String hintText;
  final Widget? prefixIcon;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? errorText;
  final ValueChanged<String>? onSubmitted;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final FocusNode? focusNode;

  const TextFieldCustom({
    Key? key,
    required this.hintText,
    this.prefixIcon,
    this.onChanged,
    this.onSubmitted,
    this.controller,
    this.errorText,
    this.keyboardType,
    this.maxLines,
    this.focusNode,
    this.minLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ColorsTheme>();
    final textStyles = Theme.of(context).extension<TodoTextTheme>();
    return TextField(
      onChanged: onChanged,
      focusNode: focusNode,
      keyboardType: keyboardType,
      maxLines: maxLines,
      onSubmitted: onSubmitted,
      style: textStyles!.body!.copyWith(color: colors!.primaryColor),
      controller: controller,
      minLines: minLines,
      decoration: InputDecoration(
        errorText: errorText,
        fillColor: colors.backSecondaryColor,
        filled: true,
        hintText: hintText,
        hintStyle: textStyles.body!.copyWith(color: colors.tertiaryColor),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: colors.backSecondaryColor!,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colors.backSecondaryColor!,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:colors.backSecondaryColor!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colors.backSecondaryColor!,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: prefixIcon,
      ),
    );
  }
}
