import 'package:flutter/material.dart';
import 'package:todo_app/common/error/exception.dart';
import 'package:todo_app/generated/l10n.dart';

class Utils{
  static String getErrorMsg(exception,BuildContext context) {
    switch (exception.runtimeType) {
      case ServerInternal:
        return S.of(context).serverInternalError;
      case Forbidden:
        return S.of(context).forbiddenError;
      case NotFound:
        return S.of(context).noFound;
        case BadRequest:
      return S.of(context).badRequest;
      default:
      return S.of(context).unknownError;
    }
  }
}