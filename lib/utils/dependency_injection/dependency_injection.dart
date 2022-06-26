import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
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
import 'package:searching_dataverse/src/features/home/landing/home_screen_view_model.dart';
import 'package:searching_dataverse/src/features/home/landing/usecase/get_access_token.dart';
import 'package:searching_dataverse/src/features/home/landing/usecase/login_user.dart';
import 'package:searching_dataverse/src/features/home/landing/usecase/logout_user.dart';
import 'package:searching_dataverse/src/features/home/search_screen/model/search_screen_view_model.dart';
import 'package:searching_dataverse/src/features/home/search_screen/usecase/get_accounts.dart';
import 'package:searching_dataverse/src/features/splash_screen/splash_screen_view_model.dart';
import 'package:searching_dataverse/utils/network/network_info.dart';
import 'package:searching_dataverse/utils/network/network_info_imp.dart';
import 'package:searching_dataverse/utils/router/app_state.dart';
import 'package:searching_dataverse/utils/router/back_button_dispatcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/third_party_plugins/aad_auth/lib/aad_oauth.dart';
import '../../services/third_party_plugins/aad_auth/lib/model/config.dart';
import '../../services/third_party_plugins/dataverse_oauth/dataverse_oauth.dart';
import '../../services/third_party_plugins/dataverse_oauth/dataverse_oauth_imp.dart';

/// This method is used for initializing all the dependencies
Future<void> init() async {
  registerExternalDependencies();
  registerCoreDependencies();
  registerRepository();
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
  sl.registerLazySingleton<DataverseAadOauth>(() => AadOauthImp(logger: sl(), oauth: sl()));
}

/// This method will register external dependencies
void registerExternalDependencies() {
  sl.registerLazySingleton(() => Dio(BaseOptions(receiveTimeout: 60000, connectTimeout: 60000, sendTimeout: 60000)));
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => AadOAuth(Config(
      tenant: dotenv.env["tenantid"]!,
      clientId: dotenv.env["clientid"]!,
      scope: 'openid profile offline_access User.Read',
      redirectUri: kIsWeb ? dotenv.env["redirectWebUri"]! : dotenv.env["redirectMobileUri"]!,
      navigatorKey: navigatorKeyGlobal,
      isB2C: false,
      resource: dotenv.env['resourceurl']/*,
      loginHint: dotenv.env["loginEmail"]!*/)));
  // sl.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker());
  sl.registerSingletonAsync<SharedPreferences>(() => SharedPreferences.getInstance());
  // sl.registerLazySingleton(() => LocalAuthentication());
  // sl.registerLazySingleton<CacheManager>(() => CacheManagerImp());
  // sl.registerLazySingleton<FlutterLocalNotificationsPlugin>(() => FlutterLocalNotificationsPlugin());
}

/// This method will register the repository
void registerRepository() {
  // sl.registerLazySingleton<PermissionEngine>(() => PermissionEngineImp(sl()));
  sl.registerLazySingleton<Repository>(() => RepositoryImp(localDataSource: sl(), remoteDataSource: sl(), networkInfo: sl(), log: sl(), aadOauth: sl()));
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

  sl.registerLazySingleton(() => HomeScreenViewModel(getAccessToken: sl(), logInUser: sl(), appState: sl()));
  sl.registerLazySingleton(() => SearchScreenViewModel(appState: sl(), getAccounts: sl(), logOutUser: sl()));
}

/// This method will register all the data sources
void registerDataSources() {
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImp(dio: sl(), log: sl(), webApiUrl: dotenv.env["webapiurl"]));
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
  sl.registerLazySingleton(() => GetAccessToken(sl()));
  sl.registerLazySingleton(() => LogOutUser(sl()));
  sl.registerLazySingleton(() => LogInUser(sl()));
  sl.registerLazySingleton(() => GetAccounts(sl()));
}
