import 'package:logger/logger.dart';
import 'package:searching_dataverse/app/app_strings.dart';
import 'package:searching_dataverse/services/error/failure.dart';
import 'package:searching_dataverse/services/third_party_plugins/aad_auth/lib/aad_oauth.dart';
import 'package:searching_dataverse/services/third_party_plugins/dataverse_oauth/dataverse_oauth.dart';


class AadOauthImp extends DataverseAadOauth {
  final AadOAuth _oauth;
  final Logger _log;

  AadOauthImp({required AadOAuth oauth, required Logger logger})
      : _oauth = oauth,
        _log = logger;

  @override
  Future<bool> login() async {
    return await _oauth.login().then((value) => true
    ).onError((error, stackTrace) {
      throw AccessDeniedFailure(error.toString());
    });
  }

  @override
  Future<String> getAccessToken() async {
    return await _oauth.getAccessToken().then((token) {

      if(token != null){
        _log.i('AadOauthImp | AccessToken | success: $token');
        return token;
      }
      throw AccessTokenFailure('Access token not found') ;
    });
  }

  @override
  Future<bool> logout() async {
   return await _oauth.logout().then((value) => true).onError((error, stackTrace) {
      _log.i('AadOauthImp | logout: $error');
      return false;
    });
  }
}
