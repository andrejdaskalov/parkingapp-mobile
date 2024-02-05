import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injectable_config.config.dart';

final getIt = GetIt.instance;

const dev = Environment('dev');
const prod = Environment('prod');

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies(String environment) => getIt.init(environment: environment);