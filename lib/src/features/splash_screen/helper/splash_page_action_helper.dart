// import 'package:cashero/utils/constants/app_state_enum.dart';
// import 'package:cashero/utils/constants/kyc_state_enum.dart';
// import 'package:cashero/utils/router/app_state.dart';
// import 'package:cashero/utils/router/models/page_action.dart';
// import 'package:cashero/utils/router/models/page_config.dart';
//
// class SplashPageActionHelper {
//   /// Priority level
//   /// 1) Update
//   /// 2) OnBoard
//   /// 3) Access Token Expired Need Auth
//   /// 4) Logged in user
//   PageAction getPageAction(
//       {required bool shouldOnBoard,
//       required AppStateEnum appStateEnum,
//       required bool accessTokenExpiredNeedAuth,
//       required bool biometricAvailable,
//       required bool userExistsOnServer,
//       required String userStatus,
//       required KycStatus kycStatus,
//       required bool biometricEnabled}) {
//     if (shouldOnBoard) {
//       return PageAction(state: PageState.replace, page: IntroPageConfig);
//     }
//
//     if (!userExistsOnServer && getNonRegisteredUserRoute.containsKey(appStateEnum)) {
//       return getNonRegisteredUserRoute[appStateEnum]!;
//     }
//
//     if(userExistsOnServer) {
//       if (accessTokenExpiredNeedAuth) {
//         return PageAction(state: PageState.replaceAll, page: GetPhoneAuthConfig);
//       }
//
//       if (getRegisterUserRoute.containsKey(appStateEnum)) {
//         return getRegisterUserRoute[appStateEnum]!;
//       }
//
//
//       if (registeredUserKYCStatusRoute.containsKey(kycStatus)) {
//         return registeredUserKYCStatusRoute[kycStatus]!;
//       }
//
//
//       if (biometricEnabledRoute.containsKey(biometricAvailable && biometricEnabled)) {
//         return biometricEnabledRoute[biometricAvailable && biometricEnabled]!;
//       }
//
//     }
//
//
//     return PageAction(state: PageState.replace, page: IntroPageConfig);
//   }
//
//
//
//
//   Map<AppStateEnum, PageAction> getRegisterUserRoute = {
//     AppStateEnum.FORGET_PASSCODE_KYC: PageAction(state: PageState.replaceAll, page: ForgetPasscodeRequiredKYCConfig),
//     AppStateEnum.SIGN_IN_REQUIRED_KYC: PageAction(state: PageState.replaceAll, page: SignInRequiredKYCConfig),
//     AppStateEnum.UNREGISTER_USER_KYC: PageAction(state: PageState.replaceAll, page: UserRequiredKycConfig),
//     AppStateEnum.NEW_REQUIRED_KYC: PageAction(state: PageState.replaceAll, page: NewRequiredKycConfig),
//     AppStateEnum.NEW_EMAIL_VERIFICATION: PageAction(state: PageState.replaceAll, page: NewAddEmailConfig),
//     AppStateEnum.SIGN_IN_SELFIE_VERIFICATION: PageAction(state: PageState.replaceAll, page: SignInKYCLivenessConfig),
//     AppStateEnum.SIGN_IN_SELFIE_VERIFIED: PageAction(state: PageState.replaceAll, page: SignInLivenessPasscodeConfig),
//     AppStateEnum.BOD_REGISTRATION_KYC: PageAction(state: PageState.replaceAll, page: BODRegistrationRequiredKycConfig),
//
//   };
//
//   Map<AppStateEnum, PageAction> getNonRegisteredUserRoute = {
//     AppStateEnum.NONE: PageAction(state: PageState.replaceAll, page: GetPhoneAuthConfig),
//     AppStateEnum.EMAIL_VERIFICATION: PageAction(state: PageState.replace, page: AddEmailConfig),
//     AppStateEnum.CREATE_PASSCODE: PageAction(state: PageState.replace, page: RegisterPasscodeConfig),
//     AppStateEnum.REGISTRATION_DETAILS: PageAction(state: PageState.replace, page: AboutYouConfig),
//     AppStateEnum.FREELANCER_KYC_PENDING: PageAction(state: PageState.replaceAll, page: RequiredKycConfig),
//     AppStateEnum.BUSINESS_KYC_PENDING: PageAction(state: PageState.replaceAll, page: RequiredKycConfig),
//     AppStateEnum.ACCOUNT_SELECTION: PageAction(state: PageState.replace, page: AccountSelectionConfig),
//     AppStateEnum.ABOUT_YOU: PageAction(state: PageState.replace, page: AboutYouConfig),
//     AppStateEnum.EMAIL_VERIFIED: PageAction(state: PageState.replace, page: EmailVerifiedConfig),
//     AppStateEnum.ENTER_FREELANCER_DETAILS: PageAction(state: PageState.replace, page: FreelancerInfoConfig),
//     AppStateEnum.ENTER_BUSINESS_DETAILS: PageAction(state: PageState.replaceAll, page: BusinessInfoConfig),
//     AppStateEnum.BUSINESS_PROFILE: PageAction(state: PageState.replace, page: BusinessProfileConfig),
//     AppStateEnum.FREELANCER_PROFILE: PageAction(state: PageState.replace, page: FreelancerProfileConfig),
//     AppStateEnum.REQUIRED_KYC: PageAction(state: PageState.replace, page: RequiredKycConfig),
//     AppStateEnum.BOD_INVITATION_SCREEN: PageAction(state: PageState.replaceAll, page: BODInvitationConfig),
//     AppStateEnum.BOD_KYC_PENDING: PageAction(state: PageState.replaceAll, page: RequiredKycConfig)
//   };
//
//
//   Map<KycStatus, PageAction> registeredUserKYCStatusRoute = {
//    KycStatus.DOCUMENT_REQUESTED :    PageAction(state: PageState.replaceAll, page: SignInPendingKYCConfig),
//     KycStatus.IN_REVIEW :    PageAction(state: PageState.replaceAll, page: SignInPendingKYCConfig),
//     KycStatus.REJECTED :    PageAction(state: PageState.replaceAll, page: SignInRejectKYCConfig),
//   };
//
//
//   Map<bool, PageAction> biometricEnabledRoute = {
//     true :    PageAction(state: PageState.replaceAll, page: LocalLoginConfig),
//     false :    PageAction(state: PageState.replaceAll, page: EnterPasscodeConfig),
//   };
// }
