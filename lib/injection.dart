import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:number_trivia_app/core/network/network_info.dart';
import 'package:number_trivia_app/core/utils/input_convertor.dart';
import 'package:number_trivia_app/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia_app/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia_app/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:number_trivia_app/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:number_trivia_app/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia_app/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivia_app/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

/// bloc should not be registered as singleton
///
/// other classes which does not hold can be registered as singleton
///
/// we cannot create an instance of the abstract class.
/// So we cannot directly register the class.
/// We can do registerLazySingleton<AbstractCLass>(() => AbstractCLassImpl())
Future<void> init() async {
  // Features - Number Trivia
  locator.registerFactory(
    () => NumberTriviaBloc(
      getConcreteNumberTrivia: locator(),
      getRandomNumberTrivia: locator(),
      inputConvertor: locator(),
    ),
  );

  // Use Cases
  locator.registerLazySingleton(() => GetConcreteNumberTrivia(locator()));
  locator.registerLazySingleton(() => GetRandomNumberTrivia(locator()));

  locator.registerLazySingleton<NumberTriviaRepository>(
      () => NumberTriviaRepositoryImpl(
            remoteDataSource: locator(),
            localDataSource: locator(),
            networkInfo: locator(),
          ));

  // Data sources
  locator.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(locator()),
  );
  locator.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(locator()),
  );

  // Core
  locator.registerLazySingleton(InputConvertor.new);
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // External Plugin/Package
  final _sharedPreference = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => _sharedPreference);
  locator.registerLazySingleton(http.Client.new);
  locator.registerLazySingleton(DataConnectionChecker.new);
}
