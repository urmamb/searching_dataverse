import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:searching_dataverse/app/globals.dart';
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
}

/// This method will register core dependencies
void registerCoreDependencies() {
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp());
  sl.registerLazySingleton(() => AppState());
  sl.registerLazySingleton(() => AppBackButtonDispatcher(sl()));
  sl.registerLazySingleton<DataverseAadOauth>(() => DataverseAadOauthImp(logger: sl(), oauth: sl()));
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
      resource: dotenv.env['resourceurl'])));
}

/// This method will register the repository
void registerRepository() {
  sl.registerLazySingleton<Repository>(() => RepositoryImp(remoteDataSource: sl(), log: sl(), aadOauth: sl()));
}

/// This method will register all the view models
void registerViewModels() {
  sl.registerLazySingleton(
    () => SplashScreenViewModel(appState: sl()),
  );

  sl.registerLazySingleton(() => HomeScreenViewModel(getAccessToken: sl(), logInUser: sl(), appState: sl()));
  sl.registerLazySingleton(() => SearchScreenViewModel(appState: sl(), getAccounts: sl(), logOutUser: sl()));
}

/// This method will register all the data sources
void registerDataSources() {
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImp(dio: sl(), log: sl(), webApiUrl: dotenv.env["webapiurl"]));
}

/// This method will register all the use cases
void registerUseCases() {
  sl.registerLazySingleton(() => GetAccessToken(sl()));
  sl.registerLazySingleton(() => LogOutUser(sl()));
  sl.registerLazySingleton(() => LogInUser(sl()));
  sl.registerLazySingleton(() => GetAccounts(sl()));
}
