/// Microsoft identity platform authentication library.
/// @nodoc
@JS('aadOauth')
library msauth;

import 'dart:async';

import 'package:js/js.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:searching_dataverse/services/third_party_plugins/aad_auth/lib/helper/core_oauth.dart';
import 'package:searching_dataverse/services/third_party_plugins/aad_auth/lib/model/config.dart';
import 'package:searching_dataverse/services/third_party_plugins/aad_auth/lib/model/msalconfig.dart';

@JS('init')
external void jsInit(MsalConfig config);

@JS('login')
external void jsLogin(
  bool refreshIfAvailable,
  void Function() onSuccess,
  void Function(dynamic) onError,
);

@JS('logout')
external void jsLogout(
  void Function() onSuccess,
  void Function(dynamic) onError,
);

@JS('getAccessToken')
external String? jsGetAccessToken();

@JS('checkAccessToken')
external String? jsCheckAccessToken();


// @JS('getIdToken')
// external String? jsGetIdToken();

class WebOAuth extends CoreOAuth {
  WebOAuth(Config config) {
    jsInit(MsalConfig.construct(
        tenant: config.tenant,
        policy: config.policy,
        clientId: config.clientId,
        responseType: config.responseType,
        redirectUri: config.redirectUri,
        scope: config.scope,
        responseMode: config.responseMode,
        state: config.state,
        prompt: config.prompt,
        codeChallenge: config.codeChallenge,
        codeChallengeMethod: config.codeChallengeMethod,
        nonce: config.nonce,
        tokenIdentifier: config.tokenIdentifier,
        clientSecret: config.clientSecret,
        resource: config.resource,
        isB2C: config.isB2C,
        loginHint: config.loginHint,
        domainHint: config.domainHint,
        codeVerifier: config.codeVerifier,
        authorizationUrl: config.authorizationUrl,
        tokenUrl: config.tokenUrl));
  }

  @override
  Future<String?> getAccessToken() async {
    return jsGetAccessToken();
  }

  @override
  Future<bool> checkAccessToken() async {

    var token = jsCheckAccessToken();
    if(token == null || JwtDecoder.isExpired(token)){
      return false;
    }
    if(token.isNotEmpty && !JwtDecoder.isExpired(token)){
      return true;
    }
    return false;
  }

  @override
  Future<String?> getIdToken() async {
    // return jsGetIdToken();
    return '';
  }

  @override
  Future<void> login({bool refreshIfAvailable = false}) async {
    final completer = Completer<void>();

    jsLogin(
      refreshIfAvailable,
      allowInterop(completer.complete),
      allowInterop(
        (_error) => completer.completeError(
          Exception('Access denied or authentication canceled.'),
        ),
      ),
    );

    return completer.future;
  }

  @override
  Future<void> logout() async {
    final completer = Completer<void>();

    jsLogout(
      allowInterop(completer.complete),
      allowInterop((error) => completer.completeError(error)),
    );

    return completer.future;
  }
}

CoreOAuth getOAuthConfig(Config config) => WebOAuth(config);
