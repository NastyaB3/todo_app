import 'package:flutter/material.dart';

class ColorsTheme extends ThemeExtension<ColorsTheme> {
  final Color? separatorColor;
  final Color? overlayColor;
  final Color? primaryColor;
  final Color? secondaryColor;
  final Color? tertiaryColor;
  final Color? disableColor;
  final Color? redColor;
  final Color? greenColor;
  final Color? blueColor;
  final Color? grayColor;
  final Color? grayLightColor;
  final Color? whiteColor;
  final Color? backPrimaryColor;
  final Color? backSecondaryColor;
  final Color? backElevatedColor;

  ColorsTheme({
    required this.separatorColor,
    required this.overlayColor,
    required this.primaryColor,
    required this.secondaryColor,
    required this.tertiaryColor,
    required this.disableColor,
    required this.redColor,
    required this.greenColor,
    required this.blueColor,
    required this.grayColor,
    required this.grayLightColor,
    required this.whiteColor,
    required this.backPrimaryColor,
    required this.backSecondaryColor,
    required this.backElevatedColor,
  });

  @override
  ColorsTheme copyWith({
    Color? separatorColor,
    Color? overlayColor,
    Color? primaryColor,
    Color? secondaryColor,
    Color? tertiaryColor,
    Color? disableColor,
    Color? redColor,
    Color? greenColor,
    Color? blueColor,
    Color? grayColor,
    Color? grayLightColor,
    Color? whiteColor,
    Color? backPrimaryColor,
    Color? backSecondaryColor,
    Color? backElevatedColor,
  }) {
    return ColorsTheme(
      separatorColor: separatorColor ?? this.separatorColor,
      overlayColor: overlayColor ?? this.overlayColor,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      tertiaryColor: tertiaryColor ?? this.tertiaryColor,
      disableColor: disableColor ?? this.disableColor,
      redColor: redColor ?? this.redColor,
      greenColor: greenColor ?? this.greenColor,
      blueColor: blueColor ?? this.blueColor,
      grayColor: grayColor ?? this.grayColor,
      grayLightColor: grayLightColor ?? this.grayLightColor,
      whiteColor: whiteColor ?? this.whiteColor,
      backPrimaryColor: backPrimaryColor ?? this.backPrimaryColor,
      backSecondaryColor: backSecondaryColor ?? this.backSecondaryColor,
      backElevatedColor: backElevatedColor ?? this.backElevatedColor,
    );
  }

  @override
  ColorsTheme lerp(ThemeExtension? other, double t) {
    if (other is! ColorsTheme) {
      return this;
    }
    return ColorsTheme(
      separatorColor: Color.lerp(separatorColor, other.separatorColor, t),
      overlayColor: Color.lerp(overlayColor, other.overlayColor, t),
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t),
      tertiaryColor: Color.lerp(tertiaryColor, other.tertiaryColor, t),
      disableColor: Color.lerp(disableColor, other.disableColor, t),
      redColor: Color.lerp(redColor, other.redColor, t),
      greenColor: Color.lerp(greenColor, other.greenColor, t),
      blueColor: Color.lerp(blueColor, other.blueColor, t),
      grayColor: Color.lerp(grayColor, other.grayColor, t),
      grayLightColor: Color.lerp(grayLightColor, other.grayLightColor, t),
      whiteColor: Color.lerp(whiteColor, other.whiteColor, t),
      backPrimaryColor: Color.lerp(backPrimaryColor, other.backPrimaryColor, t),
      backSecondaryColor:
          Color.lerp(backSecondaryColor, other.backSecondaryColor, t),
      backElevatedColor:
          Color.lerp(backElevatedColor, other.backElevatedColor, t),
    );
  }
}


