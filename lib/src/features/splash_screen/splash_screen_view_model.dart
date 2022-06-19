import 'dart:async';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:searching_dataverse/app/app_usecase/clear_secure_storage.dart';
import 'package:searching_dataverse/services/error/failure.dart';
import 'package:searching_dataverse/services/usecase/usecases/usecase.dart';
import 'package:searching_dataverse/utils/constants/app_state_enum.dart';

import '../../../utils/constants/app_strings.dart';
import 'helper/splash_page_action_helper.dart';
import 'usecases/logout_user.dart';

class SplashScreenViewModel extends ChangeNotifier {
  final ClearSecureStorage _clearSecureStorage;

  // final SplashScreenViewModelDependencies _splashScreenViewModelDependencies;

  SplashScreenViewModel({required ClearSecureStorage clearSecureStorage})
      : _clearSecureStorage = clearSecureStorage;

  late ValueChanged<String> errorMessages;
  late VoidCallback showInternetSnackBar;
  VoidCallback? startConfiguration;
  VoidCallback? showPermissionDialog;

  bool shouldOnBoard = false;
  AppStateEnum appStateEnum = AppStateEnum.NONE;
  bool accessTokenExpiredNeedAuth = false;
  bool userExistsOnServer = false;
  String userStatus = 'ENABLED';

  int maxSteps = 8;

  ValueNotifier<int> currentProgressNotifier = ValueNotifier(0);


  /// This method is used for doing all the configurations needed for the app
  Future getAllConfigurations() async {
    /// Initialize remote config
    // await _splashScreenViewModelDependencies.remoteConfigService.initialise();

    currentProgressNotifier.value = 1;

    /// Check is First time user using the app
    // await isFirstTimeUsingApp();

    currentProgressNotifier.value = 2;

    /// Check app version and if needed move the user to update screen
    // if (!await checkAppLatestOrNot()) {
    //   return;
    // }
    currentProgressNotifier.value = 3;

    /// Get AppState
    // if (!await getAppState()) {
    //   return;
    // }
    currentProgressNotifier.value = 4;

    /// Get User location
    // if (!await setUpLocation()) {
    //   return;
    // }

    // await _splashScreenViewModelDependencies.tracker.getIOSTrackingAuthorization();

    currentProgressNotifier.value = 5;

    // /// Check current user exist or not
    // if (!(await checkUserExistsOrNot())) {
    //   ;
    //   return;
    // }
    //
    // currentProgressNotifier.value = 6;
    //
    // /// Check Onboarding needed or not
    // if (!await setUpOnboardingNeededOrNot()) {
    //   return;
    // }

    currentProgressNotifier.value = 7;

    /// Check if opened with dynamic link

    // if (await setUpDynamicLink()) {
    //   return;
    // }

    currentProgressNotifier.value = 8;
    // _splashScreenViewModelDependencies.appState.appStateEnum = appStateEnum;

    // _splashScreenViewModelDependencies.appState.currentAction = SplashPageActionHelper().getPageAction(
    //     shouldOnBoard: shouldOnBoard,
    //     appStateEnum: appStateEnum,
    //     accessTokenExpiredNeedAuth: accessTokenExpiredNeedAuth,
    //     userExistsOnServer: userExistsOnServer,
        // biometricAvailable: biometricAvailable,
        // userStatus: userStatus,
        // biometricEnabled: biometricEnabled,
        // /*kycStatus: KycStatus.NEW*/);

    // await getUserUsingSavingLockUpsFirstTime();
  }

  // /// Check user using first time app or not
  // Future<void> getUserUsingSavingLockUpsFirstTime() async {
  //   var resultEither = await _firstTimeUsingSavingLockUps.call(NoParams());
  //
  //   if (resultEither.isLeft()) {
  //     handleError(resultEither);
  //     return;
  //   }
  //
  //   final result = resultEither.getOrElse(() => false);
  //   userUsingFirstTimeApp = result;
  // }

  // /// This method setup Location and save user location in DI
  // /// [Output] : [bool] in order to stop further checking or not
  // @visibleForTesting
  // Future<bool> setUpLocation() async {
  //   var locationResponse = await _splashScreenViewModelDependencies.getUserCountryISO.call(NoParams());
  //
  //   if (isError(locationResponse)) {
  //     handleError(locationResponse);
  //     return false;
  //   }
  //
  //   if (isSuccessful(locationResponse)) {
  //     var isoCode = locationResponse.getOrElse(() => throw SOMETHING_WENT_WRONG);
  //
  //     GetIt.I.get<UserRuntimeConfig>().countryISO = isoCode;
  //
  //     return true;
  //   }
  //
  //   return false;
  // }

  /// This method checks the onboarding info and if onboarding needed it modified the [pageAction]
  /// [Output] : [bool] in order to stop further checking or not
  // @visibleForTesting
  // Future<bool> setUpOnboardingNeededOrNot() async {
  //   var onboardingNeeded = await _splashScreenViewModelDependencies.onBoardingNeededUseCase.call(NoParams());
  //
  //   if (isError(onboardingNeeded)) {
  //     handleError(onboardingNeeded);
  //     return false;
  //   }
  //
  //   if (isSuccessful(onboardingNeeded)) {
  //     shouldOnBoard = onboardingNeeded.getOrElse(() => throw SOMETHING_WENT_WRONG);
  //     return true;
  //   }
  //
  //   return false;
  // }

  // @visibleForTesting
  // Future<bool> getAppState() async {
  //   var appStateEither = await _splashScreenViewModelDependencies.getAppStateUseCase.call(NoParams());
  //
  //   if (isError(appStateEither)) {
  //     handleError(appStateEither);
  //     return false;
  //   }
  //
  //   if (isSuccessful(appStateEither)) {
  //     appStateEnum = appStateEither.getOrElse(() => throw SOMETHING_WENT_WRONG);
  //
  //     return true;
  //   }
  //
  //   return false;
  // }
  //
  // @visibleForTesting
  // Future<bool> setUpDynamicLink() async {
  //   var appLinkEither = await _splashScreenViewModelDependencies.getAppLinkOnAppOpened.call(NoParams());
  //
  //   if (isSuccessful(appLinkEither)) {
  //     var appLink = appLinkEither.getOrElse(() => throw SOMETHING_WENT_WRONG);
  //
  //     return await _splashScreenViewModelDependencies.appState.generateHandler(appLink);
  //   }
  //
  //   return false;
  // }

  // @visibleForTesting
  // Future<bool> checkAppLatestOrNot() async {
  //   var appInfoEither = await _splashScreenViewModelDependencies.getAppInfo.call(NoParams());
  //
  //   if (isSuccessful(appInfoEither)) {
  //     var appVersion = appInfoEither.getOrElse(() => throw SOMETHING_WENT_WRONG).getCodeForRemoteConfig;
  //     String remoteConfigVersion;
  //     if (Platform.isAndroid) {
  //       remoteConfigVersion = _splashScreenViewModelDependencies.remoteConfigService.getAndroidAppVersion();
  //     } else {
  //       remoteConfigVersion = _splashScreenViewModelDependencies.remoteConfigService.getIOSAppVersion();
  //     }
  //
  //     if (appVersion == remoteConfigVersion) {
  //       return true;
  //     }
  //
  //     _splashScreenViewModelDependencies.appState.currentAction = PageAction(state: PageState.replaceAll, page: UpdateAppConfig);
  //     return false;
  //   }
  //
  //   return true;
  // }

  void handleError(Either<Failure, dynamic> response) {
    response.fold((l) {
      if (l is NetworkFailure) {
        showInternetSnackBar.call();
      } else {
        errorMessages.call(l.message);
      }
    }, (r) => null);
  }

  // bool isError(Either<Failure, dynamic> response) => response.isLeft();
  //
  // bool isSuccessful(Either<Failure, dynamic> response) => response.isRight();
  //
  // Future getEssentialPermissions() async {
  //   var permissionEngine = GetIt.I.get<PermissionEngine>();
  //   var isGranted = await permissionEngine.hasPermission(CustomPermission.location);
  //
  //   if (isGranted) {
  //     startConfiguration?.call();
  //     return;
  //   }
  //
  //   showPermissionDialog?.call();
  // }

  // /// Checks whether the user exists or not
  // /// Outputs: [bool] true if get response from the ser
  // /// false if no internet
  // @visibleForTesting
  // Future<bool> checkUserExistsOrNot() async {
  //   var userInfoEither = await _splashScreenViewModelDependencies.getCurrentUserRemote.call('');
  //
  //   if (userInfoEither.isLeft()) {
  //     var failure = userInfoEither.swap().getOrElse(() => ServerFailure(SOMETHING_WENT_WRONG));
  //     if (isAccessTokenExpired(failure)) {
  //       accessTokenExpiredNeedAuth = true;
  //       return true;
  //     }
  //
  //     if (isNotInternetConnection(failure)) {
  //       handleError(Left(failure));
  //       return false;
  //     }
  //
  //     return true;
  //   }
  //
  //   var getCurrentUserRemoteResponse = userInfoEither.getOrElse(() => GetCurrentUserRemoteResponse.initial());
  //   await setupDataIfUserExists(getCurrentUserRemoteResponse);
  //
  //   return true;
  // }

  // Future<void> setupDataIfUserExists(GetCurrentUserRemoteResponse getCurrentUserRemoteResponse) async {
  //   GetIt.I.get<AccountProvider>().cacheUserProfileData(getCurrentUserRemoteResponse);
  //   userStatus = getCurrentUserRemoteResponse.status;
  //   userExistsOnServer = true;
  //   kycStatus = getCurrentUserRemoteResponse.kycStatus;
  //
  //   /// Check biometric available or not
  //   await checkBiometricAvailableOrNot();
  //
  //   /// Sync all the contacts
  //   unawaited(sl<ContactsProvider>().sync());
  //
  //   if (biometricAvailable) await checkBiometricEnabledOrNot();
  // }

  // @visibleForTesting
  // Future<void> isFirstTimeUsingApp() async {
  //   if (Platform.isAndroid) {
  //     return;
  //   }
  //
  //   var isFirstTimeUsingAppEither = await _splashScreenViewModelDependencies.isFirstTimeUsingTheApp.call(NoParams());
  //
  //   if (isFirstTimeUsingAppEither.isLeft()) {
  //     return;
  //   }
  //
  //   var isFirstTime = await isFirstTimeUsingAppEither.getOrElse(() => false);
  //
  //   if (!isFirstTime) {
  //     return;
  //   }
  //
  //   await clearSecureStorageData();
  //   await logoutPreviousIOSUser();
  // }

  @visibleForTesting
  Future<bool> clearSecureStorageData() async {
    var clearSecureStorageEither = await _clearSecureStorage.call(NoParams());

    if (clearSecureStorageEither.isRight()) {
      return true;
    }
    return false;
  }

  // @visibleForTesting
  // Future<bool> checkBiometricAvailableOrNot() async {
  //   var checkBiometricLocalAuthAvailableOrNotEither = await _splashScreenViewModelDependencies.checkLocalAuthAvailable.call(NoParams());
  //
  //   if (checkBiometricLocalAuthAvailableOrNotEither.isLeft()) {
  //     return false;
  //   }
  //   biometricAvailable = true;
  //   GetIt.I.get<UserRuntimeConfig>().setUpInfoFromBiometric(checkBiometricLocalAuthAvailableOrNotEither);
  //
  //   return true;
  // }

  // Future<void> checkBiometricEnabledOrNot() async {
  //   var getBiometricEnabledByUserEither = await _splashScreenViewModelDependencies.getBiometricEnabledByUser.call(NoParams());
  //
  //   if (getBiometricEnabledByUserEither.isLeft()) {
  //     return;
  //   }
  //   GetIt.I.get<UserRuntimeConfig>().userAllowedBiometric = getBiometricEnabledByUserEither.getOrElse(() => false);
  //   biometricEnabled = getBiometricEnabledByUserEither.getOrElse(() => false);
  //   return;
  // }

  // @visibleForTesting
  // Future<bool> logoutPreviousIOSUser() async {
  //   var clearSecureStorageEither = await _splashScreenViewModelDependencies.logoutUser.call(NoParams());
  //
  //   if (clearSecureStorageEither.isRight()) {
  //     return true;
  //   }
  //   return false;
  // }

  bool isNotInternetConnection(Failure failure) => failure is NetworkFailure;

  bool isAccessTokenExpired(Failure l) => l is AccessTokenFailure;
}

/*
/// All the dependency of the splashscreen
class SplashScreenViewModelDependencies {
  final GetUserCountryISO getUserCountryISO;
  final OnboardingNeeded onBoardingNeededUseCase;
  final GetAppState getAppStateUseCase;
  final GetAppLinkOnAppOpened getAppLinkOnAppOpened;
  final HandleDynamicLink handleDynamicLink;
  final RemoteConfigService remoteConfigService;
  final GetAppInfo getAppInfo;
  final GetCurrentUserDetails getCurrentUserRemote;
  final IsFirstTimeUsingTheApp isFirstTimeUsingTheApp;
  final ClearSecureStorage clearSecureStorage;
  final CheckLocalAuthAvailable checkLocalAuthAvailable;
  final AppState appState;
  final GetBiometricEnabledByUser getBiometricEnabledByUser;
  final LogoutUser logoutUser;
  final Tracker tracker;
  final RemoteNotificationsService remoteNotificationsService;

  SplashScreenViewModelDependencies(
      {required this.getUserCountryISO,
      required this.onBoardingNeededUseCase,
      required this.getAppStateUseCase,
      required this.getAppLinkOnAppOpened,
      required this.handleDynamicLink,
      required this.remoteConfigService,
      required this.getAppInfo,
      required this.getCurrentUserRemote,
      required this.isFirstTimeUsingTheApp,
      required this.clearSecureStorage,
      required this.checkLocalAuthAvailable,
      required this.appState,
      required this.getBiometricEnabledByUser,
      required this.logoutUser,
      required this.tracker,
      required this.remoteNotificationsService});
}
*/
