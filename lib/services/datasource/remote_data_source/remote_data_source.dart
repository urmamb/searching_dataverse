
abstract class RemoteDataSource {
  /// This method send otp to user phone number for sign up
  /// Input: [SignUpPhoneOtpParams] contains country code, dialing code and phone number of user
  /// Output : if operation successful returns [bool] true.
  /// if unsuccessful the response will be [Failure]
  // Future<bool> sendSignUpPhoneOtp(SignUpPhoneOtpParams params);
}