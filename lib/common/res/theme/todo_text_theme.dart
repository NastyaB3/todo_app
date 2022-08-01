import 'package:flutter/material.dart';

class TodoTextTheme extends ThemeExtension<TodoTextTheme> {
  final TextStyle? largeTitle;
  final TextStyle? title;
  final TextStyle? button;
  final TextStyle? body;
  final TextStyle? subhead;

  TodoTextTheme({
    required this.largeTitle,
    required this.title,
    required this.button,
    required this.body,
    required this.subhead,
  });

  @override
  ThemeExtension<TodoTextTheme> copyWith({
    TextStyle? largeTitle,
    TextStyle? title,
    TextStyle? button,
    TextStyle? body,
    TextStyle? subhead,
  }) {
    return TodoTextTheme(
      largeTitle: largeTitle ?? this.largeTitle,
      title: title ?? this.title,
      button: button ?? this.button,
      body: body ?? this.body,
      subhead: subhead ?? this.subhead,
    );
  }

  @override
  ThemeExtension<TodoTextTheme> lerp(
      ThemeExtension<TodoTextTheme>? other, double t) {
    if (other is! TodoTextTheme) {
      return this;
    }
    return TodoTextTheme(
      largeTitle: TextStyle.lerp(largeTitle, other.largeTitle, t),
      title: TextStyle.lerp(title, other.title, t),
      button: TextStyle.lerp(button, other.button, t),
      body: TextStyle.lerp(body, other.body, t),
      subhead: TextStyle.lerp(subhead, other.subhead, t),
    );
  }
}
