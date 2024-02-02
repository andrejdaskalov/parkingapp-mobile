// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../api/dev/parking_api_dev.dart' as _i4;
import '../api/parking_api.dart' as _i3;
import '../repository/parking_repository.dart' as _i5;

const String _dev = 'dev';

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
    gh.factory<_i3.ParkingApi>(
      () => _i4.ParkingApiDev(),
      registerFor: {_dev},
    );
    gh.factory<_i5.ParkingRepository>(
        () => _i5.ParkingRepository(gh<_i3.ParkingApi>()));
    return this;
  }
}
