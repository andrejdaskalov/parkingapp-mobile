// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/main_page/presentation/bloc/main_page_bloc.dart' as _i15;
import '../../features/parking_payment/presentation/bloc/payment_bloc.dart'
    as _i13;
import '../../features/parking_payment/service/payment_service.dart' as _i4;
import '../api/dev/parking_api_dev.dart' as _i8;
import '../api/parking_api.dart' as _i7;
import '../api/prod/parking_api_prod.dart' as _i10;
import '../repository/impl/parking_repository_prod.dart' as _i12;
import '../repository/impl/user_input_repository.dart' as _i14;
import '../repository/parking_repository.dart' as _i11;
import '../service/dev/sms_dev.dart' as _i6;
import '../service/prod/sms_prod.dart' as _i9;
import '../service/shared_prefs_service.dart' as _i3;
import '../service/sms.dart' as _i5;

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
    gh.factory<_i3.SharedPrefsService>(() => _i3.SharedPrefsService());
    gh.factory<_i4.PaymentService>(
        () => _i4.PaymentService(gh<_i3.SharedPrefsService>()));
    gh.factory<_i5.SMSService>(
      () => _i6.SMSDev(),
      registerFor: {_dev},
    );
    gh.factory<_i7.ParkingApi>(
      () => _i8.ParkingApiDev(),
      registerFor: {_dev},
    );
    gh.factory<_i5.SMSService>(
      () => _i9.SMSProd(),
      registerFor: {_prod},
    );
    gh.factory<_i7.ParkingApi>(
      () => _i10.ParkingApiProd(),
      registerFor: {_prod},
    );
    gh.factory<_i11.ParkingRepository>(
      () => _i12.ParkingRepositoryProd(gh<_i7.ParkingApi>()),
      registerFor: {_prod},
    );
    gh.factory<_i13.PaymentBloc>(() => _i13.PaymentBloc(
          gh<_i4.PaymentService>(),
          gh<_i11.ParkingRepository>(),
          gh<_i5.SMSService>(),
        ));
    gh.factory<_i14.UserInputRepository>(() => _i14.UserInputRepository(
          gh<_i7.ParkingApi>(),
          gh<_i11.ParkingRepository>(),
        ));
    gh.factory<_i15.MainPageBloc>(() => _i15.MainPageBloc(
          gh<_i11.ParkingRepository>(),
          gh<_i14.UserInputRepository>(),
        ));
    return this;
  }
}
