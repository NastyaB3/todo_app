part of 'detail_cubit.dart';

@immutable
abstract class DetailState {}

class DetailInitial extends DetailState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailInitial && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class DetailSuccess extends DetailState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailSuccess && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class DetailLoading extends DetailState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailLoading && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class DetailError extends DetailState {
  final String error;

  DetailError(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailError &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;
}
