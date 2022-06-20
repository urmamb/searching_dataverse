import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:searching_dataverse/app/app_usecase/clear_secure_storage.dart';
import 'package:searching_dataverse/app/app_usecase/get_auth_token.dart';
import 'package:searching_dataverse/app/app_usecase/save_auth_token.dart';
import 'package:searching_dataverse/app/globals.dart';
import 'package:searching_dataverse/services/datasource/local_data_source/local_data_source.dart';
import 'package:searching_dataverse/services/datasource/local_data_source/local_data_source_imp.dart';
import 'package:searching_dataverse/services/datasource/remote_data_source/remote_data_source.dart';
import 'package:searching_dataverse/services/datasource/remote_data_source/remote_data_source_imp.dart';
import 'package:searching_dataverse/services/repository/repository.dart';
import 'package:searching_dataverse/services/repository/repository_imp.dart';
import 'package:searching_dataverse/src/features/splash_screen/splash_screen_view_model.dart';
import 'package:searching_dataverse/utils/network/network_info.dart';
import 'package:searching_dataverse/utils/network/network_info_imp.dart';
import 'package:searching_dataverse/utils/router/app_state.dart';
import 'package:searching_dataverse/utils/router/back_button_dispatcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This method is used for initializing all the dependencies
Future<void> init() async {
  registerCoreDependencies();
  registerRepository();
  registerExternalDependencies();
  registerUseCases();
  registerViewModels();
  registerDataSources();
  registerConfigs();
}

/// This method will register core dependencies
void registerCoreDependencies() {
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp());
  sl.registerLazySingleton(() => AppState());
  sl.registerLazySingleton(() => AppBackButtonDispatcher(sl()));
}

/// This method will register external dependencies
void registerExternalDependencies() {
  sl.registerLazySingleton(() => Dio(BaseOptions(receiveTimeout: 60000, connectTimeout: 60000, sendTimeout: 60000)));
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  // sl.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker());
  sl.registerSingletonAsync<SharedPreferences>(() => SharedPreferences.getInstance());
  sl.registerLazySingleton(() => LocalAuthentication());
  // sl.registerLazySingleton<CacheManager>(() => CacheManagerImp());
  // sl.registerLazySingleton<FlutterLocalNotificationsPlugin>(() => FlutterLocalNotificationsPlugin());
}

/// This method will register the repository
void registerRepository() {
  // sl.registerLazySingleton<PermissionEngine>(() => PermissionEngineImp(sl()));
  sl.registerLazySingleton<Repository>(() => RepositoryImp(localDataSource: sl(), remoteDataSource: sl(), networkInfo: sl(), log: sl()));
}

/// This method will register config
void registerConfigs() {
  // sl.registerLazySingleton(() => UserRuntimeConfig.initial());
  // sl.registerLazySingleton(() => UserAccountBloc());
}

/// This method will register all the view models
void registerViewModels() {

  sl.registerLazySingleton(
        () => SplashScreenViewModel(clearSecureStorage: sl(), appState: sl()),
  );

}

/// This method will register all the data sources
void registerDataSources() {
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImp(dio: sl(), log: sl(), url: dotenv.env["url"]));
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImp(
    flutterSecureStorage: sl(),
    sharedPreferences: sl(),
  ));

}

/// This method will register all the use cases
void registerUseCases() {
  sl.registerLazySingleton(() => GetAuthToken(sl()));
  sl.registerLazySingleton(() => SaveAuthToken(sl()));
  sl.registerLazySingleton(() => ClearSecureStorage(sl()));

}
