// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Мои дела`
  String get appBar {
    return Intl.message(
      'Мои дела',
      name: 'appBar',
      desc: '',
      args: [],
    );
  }

  /// `Новое`
  String get newDeal {
    return Intl.message(
      'Новое',
      name: 'newDeal',
      desc: '',
      args: [],
    );
  }

  /// `Выполнено`
  String get done {
    return Intl.message(
      'Выполнено',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `СОХРАНИТЬ`
  String get save {
    return Intl.message(
      'СОХРАНИТЬ',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Что надо сделать..`
  String get needToDo {
    return Intl.message(
      'Что надо сделать..',
      name: 'needToDo',
      desc: '',
      args: [],
    );
  }

  /// `Важность`
  String get importance {
    return Intl.message(
      'Важность',
      name: 'importance',
      desc: '',
      args: [],
    );
  }

  /// `Сделать до`
  String get needToBeDoneBefore {
    return Intl.message(
      'Сделать до',
      name: 'needToBeDoneBefore',
      desc: '',
      args: [],
    );
  }

  /// `Удалить`
  String get delete {
    return Intl.message(
      'Удалить',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `ГОТОВО`
  String get ready {
    return Intl.message(
      'ГОТОВО',
      name: 'ready',
      desc: '',
      args: [],
    );
  }

  /// `Низкий`
  String get low {
    return Intl.message(
      'Низкий',
      name: 'low',
      desc: '',
      args: [],
    );
  }

  /// `Нет`
  String get basic {
    return Intl.message(
      'Нет',
      name: 'basic',
      desc: '',
      args: [],
    );
  }

  /// `!! Высокий`
  String get important {
    return Intl.message(
      '!! Высокий',
      name: 'important',
      desc: '',
      args: [],
    );
  }

  /// `Ошибка`
  String get errorText {
    return Intl.message(
      'Ошибка',
      name: 'errorText',
      desc: '',
      args: [],
    );
  }

  /// `Попробовать снова`
  String get retry {
    return Intl.message(
      'Попробовать снова',
      name: 'retry',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ru', countryCode: 'RU'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
