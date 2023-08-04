// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'feature/image_search/data/repository/image_repository.dart' as _i5;
import 'feature/image_search/di_module.dart' as _i6;
import 'feature/image_search/domain/repository/image_repository.dart' as _i4;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final imageSearchModule = _$ImageSearchModule();
    gh.factory<_i3.Dio>(
      () => imageSearchModule.dioProd,
      instanceName: 'UnsplashClientModule',
    );
    gh.lazySingleton<_i4.ImageRepositoryBase>(() => _i5.ImageRepositoryImpl());
    return this;
  }
}

class _$ImageSearchModule extends _i6.ImageSearchModule {}
