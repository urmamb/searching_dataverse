
abstract class LocalDataSource {
  /// This method save auth token in local storage
  /// Input: [String] auth token
  /// Output : if operation successful returns true
  /// if unsuccessful the response will be [Failure]
  Future<bool> saveAuthToken(String params);

  /// This method get the auth token from local storage
  /// Output : [String] returns auth token
  /// if unsuccessful the response will be [Failure]
  Future<String> getAuthToken();

  /// This method clears the secure storage
  /// [Output] : [bool] specifies whether the saving operation is successful or not
  Future<bool> clearsSecureStorage();

}
