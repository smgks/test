import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

const testEnv = Environment('test');
const prodEnv = Environment('prod');

final getIt = GetIt.instance;


@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies([String? env]) => getIt.init(environment: env);
