// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/main_page/presentation/bloc/main_page_bloc.dart' as _i7;
import '../api/dev/parking_api_dev.dart' as _i4;
import '../api/parking_api.dart' as _i3;
import '../api/prod/parking_api_prod.dart' as _i5;
import '../repository/impl/parking_repository.dart' as _i6;

const String _dev = 'dev';
const String _prod = 'prod';

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
    gh.factory<_i3.ParkingApi>(
      () => _i5.ParkingApiProd(),
      registerFor: {_prod},
    );
    gh.factory<_i6.ParkingRepository>(
        () => _i6.ParkingRepository(gh<_i3.ParkingApi>()));
    gh.factory<_i7.MainPageBloc>(
        () => _i7.MainPageBloc(gh<_i6.ParkingRepository>()));
    return this;
  }
}
