// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/main_page/presentation/bloc/main_page_bloc.dart' as _i11;
import '../../features/parking_payment/presentation/bloc/payment_bloc.dart'
    as _i13;
import '../../features/parking_payment/service/payment_service.dart' as _i12;
import '../api/dev/parking_api_dev.dart' as _i4;
import '../api/parking_api.dart' as _i3;
import '../api/prod/parking_api_prod.dart' as _i5;
import '../repository/parking_repository.dart' as _i6;
import '../service/dev/sms_dev.dart' as _i8;
import '../service/prod/sms_prod.dart' as _i9;
import '../service/shared_prefs_service.dart' as _i10;
import '../service/sms.dart' as _i7;

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
    gh.factory<_i7.SMSService>(
      () => _i8.SMSDev(),
      registerFor: {_dev},
    );
    gh.factory<_i7.SMSService>(
      () => _i9.SMSProd(),
      registerFor: {_prod},
    );
    gh.factory<_i10.SharedPrefsService>(() => _i10.SharedPrefsService());
    gh.factory<_i11.MainPageBloc>(
        () => _i11.MainPageBloc(gh<_i6.ParkingRepository>()));
    gh.factory<_i12.PaymentService>(
        () => _i12.PaymentService(gh<_i10.SharedPrefsService>()));
    gh.factory<_i13.PaymentBloc>(() => _i13.PaymentBloc(
          gh<_i12.PaymentService>(),
          gh<_i6.ParkingRepository>(),
          gh<_i7.SMSService>(),
        ));
    return this;
  }
}
