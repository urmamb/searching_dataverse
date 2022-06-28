
import 'package:flutter/foundation.dart';
import 'package:searching_dataverse/services/third_party_plugins/aad_auth/lib/helper/choose_oauth.dart'
// ignore: uri_does_not_exist
if (dart.library.io) 'package:searching_dataverse/services/third_party_plugins/aad_auth/lib/helper/mobile_oauth.dart'
// ignore: uri_does_not_exist
if (dart.library.html) 'package:searching_dataverse/services/third_party_plugins/aad_auth/lib/helper/web_oauth.dart';

// 'package:searching_dataverse/services/third_party_plugins/aad_auth/lib/helper/web_oauth.dart' as web_oauth;
// import 'package:searching_dataverse/services/third_party_plugins/aad_auth/lib/helper/mobile_oauth.dart' as mobile_oauth;
import 'package:searching_dataverse/services/third_party_plugins/aad_auth/lib/model/config.dart';

class CoreOAuth {
  CoreOAuth();

  Future<void> login({bool refreshIfAvailable = false}) async {}

  Future<void> logout() async {}

  Future<String?> getAccessToken() async => 'ACCESS_TOKEN';

  Future<String?> getIdToken() async => 'ID_TOKEN';

  factory CoreOAuth.fromConfig(Config config) =>
      config.isStub ? CoreOAuth() : getOAuthConfig(config);
}
