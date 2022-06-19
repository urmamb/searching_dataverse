import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  Failure(this.message);
}

// General failures

class ServerFailure extends Failure {
  ServerFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {
  CacheFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class DynamicLinkFailure extends Failure {
  DynamicLinkFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

// Failure for KYC
class TokenExpireFailure extends Failure {
  TokenExpireFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

// Failure for underlying platform
class PlatformFailure extends Failure {
  PlatformFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

// Failure for underlying platform
class LocationFailure extends Failure {
  LocationFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

// RemoteConfig Failure
class RemoteConfigFailure extends Failure {
  RemoteConfigFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

// RemoteConfig Failure
class UDIDGnerationFailure extends Failure {
  UDIDGnerationFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

// RemoteConfig Failure
class NetworkFailure extends Failure {
  NetworkFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

// AccessToken  Failure
class AccessTokenFailure extends Failure {
  AccessTokenFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

// No User Found  Failure
class NoUserFoundFailure extends Failure {
  NoUserFoundFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}
/*
// No User Found  Failure
class InvalidAccountTypeFailure extends Failure {
  InvalidAccountTypeFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

// No User Found  Failure
class InvalidInputFailure extends Failure {
  InvalidInputFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

// No User Found  Failure
class UserAlreadyExistsFailure extends Failure {
  UserAlreadyExistsFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

// AccessToken  Failure
class FcmTokenRetrivalError extends Failure {
  FcmTokenRetrivalError(message) : super(message);

  @override
  List<Object> get props => [message];
}

// No User Found  Failure
class WrongPasscodeFailure extends Failure {
  WrongPasscodeFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

// Inappropriate Image
class InappropriateImageFailure extends Failure {
  InappropriateImageFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class BusinessTagNameAlreadyExistsFailure extends Failure {
  BusinessTagNameAlreadyExistsFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class BusinessAlreadyExistsFailure extends Failure {
  BusinessAlreadyExistsFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class MultipleFreelancerFailure extends Failure {
  MultipleFreelancerFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class KYBUnknownBusinessFailure extends Failure {
  KYBUnknownBusinessFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class InvalidTokenIdFailure extends Failure {
  InvalidTokenIdFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class InvalidBusinessIdFailure extends Failure {
  InvalidBusinessIdFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class AlreadyRegisteredAsBODFailure extends Failure {
  AlreadyRegisteredAsBODFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class NotFoundInBODFailure extends Failure {
  NotFoundInBODFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class KYBFailedToGetCompanyFailure extends Failure {
  KYBFailedToGetCompanyFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class KYBInvalidKYCFailure extends Failure {
  KYBInvalidKYCFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class KYBInvalidBODFailure extends Failure {
  KYBInvalidBODFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class FreelancerBusinessAlreadyExists extends Failure {
  FreelancerBusinessAlreadyExists(message) : super(message);

  @override
  List<Object> get props => [message];
}

class BODInvalidKYBFailure extends Failure {
  BODInvalidKYBFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class EmailAlreadyExistsFailure extends Failure {
  EmailAlreadyExistsFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class EmailAlreadySentFailure extends Failure {
  EmailAlreadySentFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class LanguageChangedFailure extends Failure {
  LanguageChangedFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class NoResultsFoundFailure extends Failure {
  NoResultsFoundFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class GPSOffFailure extends Failure {
  GPSOffFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class KYCNotFoundFailure extends Failure {
  KYCNotFoundFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class KYCNotCompleteFailure extends Failure {
  KYCNotCompleteFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class KYCFinalRejectFailure extends Failure {
  KYCFinalRejectFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class NotEnoughBalanceFailure extends Failure {
  NotEnoughBalanceFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class GetAccountBalanceFailure extends Failure {
  GetAccountBalanceFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class PhoneNumberAlreadyExistsFailure extends Failure {
  PhoneNumberAlreadyExistsFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class PhoneNumberNotAuthorized extends Failure {
  PhoneNumberNotAuthorized(message) : super(message);

  @override
  List<Object> get props => [message];
}

class BusinessNotFoundFailure extends Failure {
  BusinessNotFoundFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class InvalidUDIDFailure extends Failure {
  InvalidUDIDFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class InvalidUInputFailure extends Failure {
  InvalidUInputFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class ExchangeCurrencyMinAmountFailure extends Failure {
  ExchangeCurrencyMinAmountFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class UserNotExistsFailure extends Failure {
  UserNotExistsFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class ChangeUsernameLimitReachFailure extends Failure {
  ChangeUsernameLimitReachFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class UsernameAlreadyExistsFailure extends Failure {
  UsernameAlreadyExistsFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class CustomTokenFailure extends Failure {
  CustomTokenFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class PhoneNumberMismatchFailure extends Failure {
  PhoneNumberMismatchFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class MinAmountFailure extends Failure {
  MinAmountFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class InsufficientBalanceFailure extends Failure {
  InsufficientBalanceFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class InvalidOTPFailure extends Failure {
  InvalidOTPFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class PaymentNotFoundFailure extends Failure {
  PaymentNotFoundFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class NotAllowedToCancelPaymentFailure extends Failure {
  NotAllowedToCancelPaymentFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class InvalidPaymentIdFailure extends Failure {
  InvalidPaymentIdFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class UserNotParticipatedFailure extends Failure {
  UserNotParticipatedFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class PaymentFeeNotFoundFailure extends Failure {
  PaymentFeeNotFoundFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class UnRegisteredPaymentFeeNotFoundFailure extends Failure {
  UnRegisteredPaymentFeeNotFoundFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class BalancePositiveFailure extends Failure {
  BalancePositiveFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class BusinessExistsWithPersonalFailure extends Failure {
  BusinessExistsWithPersonalFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class AlreadyClosedAccountFailure extends Failure {
  AlreadyClosedAccountFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class BusinessClosureInitiatedFailure extends Failure {
  BusinessClosureInitiatedFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class BusinessClosureAlreadyInitiatedFailure extends Failure {
  BusinessClosureAlreadyInitiatedFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class AlreadyApprovedClosedAccountFailure extends Failure {
  AlreadyApprovedClosedAccountFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class PaymentAlreadyCanceledFailure extends Failure {
  PaymentAlreadyCanceledFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class ClosureNotInitiatedFailure extends Failure {
  ClosureNotInitiatedFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class KYCLivenessFailure extends Failure {
  KYCLivenessFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class AttemptExceededFailure extends Failure {
  AttemptExceededFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class NameNotMatchedWithKycFailure extends Failure {
  NameNotMatchedWithKycFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class LiveNessNotVerifiedFailure extends Failure {
  LiveNessNotVerifiedFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class LiveNessRecheckedRequiredFailure extends Failure {
  LiveNessRecheckedRequiredFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class InvalidEmailFailure extends Failure {
  InvalidEmailFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class BODNotFoundFailure extends Failure {
  BODNotFoundFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class SenderAndReceiverBothFailure extends Failure {
  SenderAndReceiverBothFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class LoginTokenExpiredFailure extends Failure {
  LoginTokenExpiredFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class RefreshTokenNeeded extends Failure {
  RefreshTokenNeeded(message) : super(message);

  @override
  List<Object> get props => [message];
}

class TooManyAttemptsFailure extends Failure {
  TooManyAttemptsFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class PaymentLimitFailure extends Failure {
  PaymentLimitFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

// Payment Limit Not Set  Failure
class PaymentLimitNotSetFailure extends Failure {
  PaymentLimitNotSetFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class TradeLimitNotSetFailure extends Failure {
  TradeLimitNotSetFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class NoBusinessFoundFailure extends Failure {
  NoBusinessFoundFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class NoAPYFoundFailure extends Failure {
  NoAPYFoundFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class DepositAmountNotFoundFailure extends Failure {
  DepositAmountNotFoundFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class InterestNotFountFailure extends Failure {
  InterestNotFountFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class InvestmentNotFoundFailure extends Failure {
  InvestmentNotFoundFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class InvalidPaymentCategoryFailure extends Failure {
  InvalidPaymentCategoryFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class UnInvestExceedThanInvestmentFailure extends Failure {
  UnInvestExceedThanInvestmentFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class KYCNotVerifiedFailure extends Failure {
  KYCNotVerifiedFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class CountryNotSupportedFailure extends Failure {
  CountryNotSupportedFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}*/
