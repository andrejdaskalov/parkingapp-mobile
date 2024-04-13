import 'package:injectable/injectable.dart';
import 'package:parkingapp/core/service/shared_prefs_service.dart';

@injectable
class PaymentService {
  final SharedPrefsService _sharedPrefsService;
  PaymentService(this._sharedPrefsService);

  static const String _key = 'currentlyPayingParking';

  Future<String?> getCurrentlyPayingParking() async {
    return await _sharedPrefsService.getPreference(_key);
  }

  Future<void> setCurrentlyPayingParking(String value) async {
    return await _sharedPrefsService.setPreference(_key, value);
  }

  Future<void> clearCurrentlyPayingParking() async {
    return await _sharedPrefsService.clearPreference(_key);
  }


}