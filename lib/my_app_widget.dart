import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_app/common/res/theme/theme.dart';
import 'package:todo_app/common/res/theme/todo_text_theme.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/main_core.dart';

//TODO:
//ссылка на загрузку .apk
//testing
// Доп. критерий: есть распространение через какой-то сервис вроде Firebase App Distribution

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorsLightTheme = ColorsTheme(
      separatorColor: const Color(0xff000000).withOpacity(0.2),
      overlayColor: const Color(0xff000000).withOpacity(0.06),
      primaryColor: const Color(0xff000000),
      secondaryColor: const Color(0xff000000).withOpacity(0.6),
      tertiaryColor: const Color(0xff000000).withOpacity(0.3),
      disableColor: const Color(0xff000000).withOpacity(0.15),
      redColor: const Color(0xffFF3B30),
      greenColor: const Color(0xff34C759),
      blueColor: const Color(0xff007AFF),
      grayColor: const Color(0xff8E8E93),
      grayLightColor: const Color(0xffD1D1D6),
      whiteColor: const Color(0xffFFFFFF),
      backPrimaryColor: const Color(0xffF7F6F2),
      backSecondaryColor: const Color(0xffFFFFFF),
      backElevatedColor: const Color(0xffFFFFFF),
    );
    final colorsBlackTheme = ColorsTheme(
      separatorColor: const Color(0xffFFFFFF).withOpacity(0.2),
      overlayColor: const Color(0xff000000).withOpacity(0.32),
      primaryColor: const Color(0xffFFFFFF),
      secondaryColor: const Color(0xffFFFFFF).withOpacity(0.6),
      tertiaryColor: const Color(0xffFFFFFF).withOpacity(0.4),
      disableColor: const Color(0xffFFFFFF).withOpacity(0.15),
      redColor: const Color(0xffFF453A),
      greenColor: const Color(0xff32D74B),
      blueColor: const Color(0xff0A84FF),
      grayColor: const Color(0xff8E8E93),
      grayLightColor: const Color(0xff48484A),
      whiteColor: const Color(0xffFFFFFF),
      backPrimaryColor: const Color(0xff161618),
      backSecondaryColor: const Color(0xff252528),
      backElevatedColor: const Color(0xff3C3C3F),
    );
    final textThemeLight = TodoTextTheme(
      largeTitle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 32,
        height: 37.5 / 32,
        color: colorsLightTheme.primaryColor,
        fontFamily: 'Roboto',
      ),
      title: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20,
        letterSpacing: 0.5,
        height: 32 / 20,
        color: colorsLightTheme.primaryColor,
        fontFamily: 'Roboto',
      ),
      button: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        letterSpacing: 0.16,
        height: 24 / 14,
        color: colorsLightTheme.primaryColor,
        fontFamily: 'Roboto',
      ),
      body: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 20 / 16,
        color: colorsLightTheme.primaryColor,
        fontFamily: 'Roboto',
      ),
      subhead: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 20 / 14,
        color: colorsLightTheme.primaryColor,
        fontFamily: 'Roboto',
      ),
    );
    final textThemeBlack = TodoTextTheme(
      largeTitle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 32,
        height: 37.5 / 32,
        color: colorsBlackTheme.primaryColor,
        fontFamily: 'Roboto',
      ),
      title: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20,
        letterSpacing: 0.5,
        height: 32 / 20,
        color: colorsBlackTheme.primaryColor,
        fontFamily: 'Roboto',
      ),
      button: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        letterSpacing: 0.16,
        height: 24 / 14,
        color: colorsBlackTheme.primaryColor,
        fontFamily: 'Roboto',
      ),
      body: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 20 / 16,
        color: colorsBlackTheme.primaryColor,
        fontFamily: 'Roboto',
      ),
      subhead: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 20 / 14,
        color: colorsBlackTheme.primaryColor,
        fontFamily: 'Roboto',
      ),
    );

    return MaterialApp.router(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData.light().copyWith(
        extensions: <ThemeExtension<dynamic>>[
          colorsLightTheme,
          textThemeLight,
        ],
      ),
      darkTheme: ThemeData.dark().copyWith(
        extensions: <ThemeExtension<dynamic>>[
          colorsBlackTheme,
          textThemeBlack,
        ],
      ),
      routeInformationParser: parser,
      routerDelegate: router,
    );
  }
}
