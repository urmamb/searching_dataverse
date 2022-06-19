import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:searching_dataverse/utils/constants/app_paths.dart';

import 'models/page_config.dart';
import 'ui_pages.dart';

class CasheroParser extends RouteInformationParser<PageConfiguration> {

  @override
  Future<PageConfiguration> parseRouteInformation(RouteInformation routeInformation) {
    final uri = Uri.parse(routeInformation.location ?? '');

    if (uri.pathSegments.isEmpty) {
      return SynchronousFuture(SplashPageConfig);
    }

    final path = '/' + uri.pathSegments[0];

    switch (path) {
      case SplashPath:
        return SynchronousFuture(SplashPageConfig);

      // case AddEmailPath:
      //   return SynchronousFuture(AddEmailConfig);
      // case ResendEmailPath:
      //   return SynchronousFuture(ResendEmailConfig);
      // case AboutYouPath:
      //   return SynchronousFuture(AboutYouConfig);
      // case BasicInfoPath:
      //   return SynchronousFuture(BasicInfoConfig);
      // case AccountSelectionPath:
      //   return SynchronousFuture(AccountSelectionConfig);
      // case RegisterPasscodePath:
      //   return SynchronousFuture(RegisterPasscodeConfig);
      // case ConfirmPasscodePath:
      //   return SynchronousFuture(ConfirmPasscodeConfig);
      // case UpdateAppPath:
      //   return SynchronousFuture(UpdateAppConfig);
      // case CheckEmailPath:
      //   return SynchronousFuture(CheckEmailConfig);
      // case EmailVerifiedPath:
      //   return SynchronousFuture(EmailVerifiedConfig);
      // case InvalidTokenPath:
      //   return SynchronousFuture(InvalidTokenConfig);
      // case InvalidDevicePath:
      //   return SynchronousFuture(InvalidDeviceConfig);
      // case FreelancerInfoPath:
      //   return SynchronousFuture(FreelancerInfoConfig);
      // case HomeScreenPath:
      //   return SynchronousFuture(HomeScreenConfig);
      // case BusinessVerificationUnsuccessfulPath:
      //   return SynchronousFuture(BusinessVerificationUnsuccessfulConfig);
      // case LocalLoginPath:
      //   return SynchronousFuture(LocalLoginConfig);
      // case BODInvitationPath:
      //   return SynchronousFuture(BODInvitationConfig);
      // case BODWelcomePath:
      //   return SynchronousFuture(BODWelcomeConfig);
      // case QRInvitationPath:
      //   return SynchronousFuture(QRInvitationConfig);
      // case ForgetVerifyOtpPath:
      //   return SynchronousFuture(ForgetVerifyOtpConfig);
      // case ForgetPhoneAuthPath:
      //   return SynchronousFuture(ForgetPhoneAuthConfig);
      // case UserDetailsPath:
      //   return SynchronousFuture(UserDetailsConfig);
      // case ChangePasscodePasscodePath:
      //   return SynchronousFuture(ChangeVerificationPasscodeConfig);
      // case ChangePasscodeBiometricPath:
      //   return SynchronousFuture(ChangeVerificationBiometricConfig);
      //
      // case ChangeCreatePasscodePath:
      //   return SynchronousFuture(ChangeCreatePasscodeConfig);
      // case ChangeConfirmPasscodePath:
      //   return SynchronousFuture(ChangeConfirmPasscodeConfig);

      default:
        return SynchronousFuture(SplashPageConfig);
    }
  }

  @override
  RouteInformation restoreRouteInformation(PageConfiguration configuration) {
    switch (configuration.uiPage) {
      case Pages.Splash:
        return const RouteInformation(location: SplashPath);

      case Pages.HomeScreen:
        return const RouteInformation(location: HomeScreenPath);

      case Pages.NoInternetScreen:
        return const RouteInformation(location: NoInternetScreenPath);
    }
  }
}
