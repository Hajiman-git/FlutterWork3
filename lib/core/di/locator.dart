import 'package:get_it/get_it.dart';
import '../network/dio_client.dart';
import '../../data/repositories/jokes_repository.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  const apiKey = String.fromEnvironment(
    'API_NINJAS_KEY',
    defaultValue: 'Ct3qDMZD6ZJOcoOPfYoQBMk8LlibleXd84jyWkBV',
  );

  getIt.registerLazySingleton<DioClient>(
    () => DioClient(apiKey: apiKey),
  );

  getIt.registerLazySingleton<JokesRepository>(
    () => JokesRepository(getIt<DioClient>().dio),
  );
}