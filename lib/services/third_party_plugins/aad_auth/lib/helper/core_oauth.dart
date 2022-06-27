
import 'package:searching_dataverse/services/third_party_plugins/aad_auth/lib/helper/mobile_oauth.dart' as mobile_oauth;
// import 'package:searching_dataverse/services/third_party_plugins/aad_auth/lib/helper/web_oauth.dart' as web_oauth;
import 'package:searching_dataverse/services/third_party_plugins/aad_auth/lib/model/config.dart';

class CoreOAuth {
  CoreOAuth();

  Future<void> login({bool refreshIfAvailable = false}) async {}

  Future<void> logout() async {}

  Future<String?> getAccessToken() async => 'ACCESS_TOKEN';

  Future<String?> getIdToken() async => 'ID_TOKEN';

  factory CoreOAuth.fromConfig(Config config) =>
      config.isStub ? CoreOAuth() : mobile_oauth.getOAuthConfig(config);
}
