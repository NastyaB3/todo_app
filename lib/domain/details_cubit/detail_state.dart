part of 'detail_cubit.dart';

@immutable
abstract class DetailState {}

class DetailInitial extends DetailState {}

class DetailSuccess extends DetailState {}

class DetailLoading extends DetailState {}

class DetailError extends DetailState {
  String error;

  DetailError(this.error);
}
