import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:searching_dataverse/services/third_party_plugins/aad_auth/lib/helper/core_oauth.dart';
import 'package:searching_dataverse/services/third_party_plugins/aad_auth/lib/model/config.dart';
import 'package:searching_dataverse/services/third_party_plugins/aad_auth/lib/model/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../request_code.dart';
import '../request_token.dart';
import 'auth_storage.dart';

class MobileOAuth extends CoreOAuth {
  final AuthStorage _authStorage;
  final RequestCode _requestCode;

  /// Instantiating MobileAadOAuth authentication.
  /// [config] Parameters according to official Microsoft Documentation.
  MobileOAuth(Config config)
      : _authStorage = AuthStorage(
          tokenIdentifier: config.tokenIdentifier,
          aOptions: config.aOptions,
        ),
        _requestCode = RequestCode(config);

  /// Perform Azure AD login.
  ///
  /// Setting [refreshIfAvailable] to `true` will attempt to re-authenticate
  /// with the existing refresh token, if any, even though the access token may
  /// still be valid. If there's no refresh token the existing access token
  /// will be returned, as long as we deem it still valid. In the event that
  /// both access and refresh tokens are invalid, the web gui will be used.
  @override
  Future<void> login({bool refreshIfAvailable = false}) async {
    await _removeOldTokenOnFirstLogin();
    await _authorization(refreshIfAvailable: refreshIfAvailable);
  }

  /// Retrieve cached OAuth Access Token.
  @override
  Future<String?> getAccessToken() async {

    var token = (await _authStorage.loadTokenFromCache()).accessToken;
    if(token != null && JwtDecoder.isExpired(token)){
      return null;
    }
    return token;
  }


  /// Retrieve cached OAuth Id Token.
  @override
  Future<String?> getIdToken() async =>
      (await _authStorage.loadTokenFromCache()).idToken;

  /// Perform Azure AD logout.
  @override
  Future<void> logout() async {
    await _authStorage.clear();
    await _requestCode.clearCookies();
  }

  /// Authorize user via refresh token or web gui if necessary.
  ///
  /// Setting [refreshIfAvailable] to [true] will attempt to re-authenticate
  /// with the existing refresh token, if any, even though the access token may
  /// still be valid. If there's no refresh token the existing access token
  /// will be returned, as long as we deem it still valid. In the event that
  /// both access and refresh tokens are invalid, the web gui will be used.
  Future<Token> _authorization({bool refreshIfAvailable = false}) async {
    var token = await _authStorage.loadTokenFromCache();

    if (!refreshIfAvailable) {
      if (token.hasValidAccessToken()) {
        return token;
      }
    }

    // if (token.hasRefreshToken()) {
    //   token = await _requestToken.requestRefreshToken(token.refreshToken!);
    // }

    if (!token.hasValidAccessToken()) {
      token = await _performFullAuthFlow();
    }

    await _authStorage.saveTokenToCache(token);
    return token;
  }

  /// Authorize user via refresh token or web gui if necessary.
  Future<Token> _performFullAuthFlow() async {
    var code = await _requestCode.requestCode();
    if (code == null) {
      throw Exception('Access denied or authentication canceled.');
    }

    var map = {
      'access_token': code,
      'token_type': 'Bearer',
      'expires_in': JwtDecoder.getRemainingTime(code),
      'refresh_token': '',
      'id_token': ''

    };
    var token = Token.fromJson(map);
    return token;
  }

  Future<void> _removeOldTokenOnFirstLogin() async {
    var prefs = await SharedPreferences.getInstance();
    final _keyFreshInstall = 'freshInstall';
    if (!prefs.getKeys().contains(_keyFreshInstall)) {
      await logout();
      await prefs.setBool(_keyFreshInstall, false);
    }
  }
}

CoreOAuth getOAuthConfig(Config config) => MobileOAuth(config);
