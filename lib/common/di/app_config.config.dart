// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/repositories/todo_repository.dart' as _i5;
import '../../data/repositories/todos_dao.dart' as _i4;
import '../../database/database.dart' as _i3;
import 'todo_module.dart' as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final todoModule = _$TodoModule();
  gh.singleton<_i3.AppDb>(todoModule.provideAppDb());
  gh.singleton<_i4.TodosDao>(todoModule.provideToDoDao(get<_i3.AppDb>()));
  gh.singleton<_i5.TodoRepository>(
      todoModule.provideRepository(get<_i4.TodosDao>()));
  return get;
}

class _$TodoModule extends _i6.TodoModule {}
