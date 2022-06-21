
abstract class RemoteDataSource {

  /// This use case will get accessToken from server
  /// [Input] : contains query parameters
  /// [Output] : [String] contains accessToken.
  Future<String> getAccessToken();

}