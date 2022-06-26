abstract class DataverseAadOauth {
  /// This method will present the login screen to user
  Future<bool> login();

  /// This method will get the access token from microsoftonline
  Future<String> getAccessToken();

  /// This method will logout user
  Future<bool> logout();
}
