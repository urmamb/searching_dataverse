import 'package:logger/logger.dart';
import 'package:searching_dataverse/app/app_strings.dart';
import 'package:searching_dataverse/services/error/failure.dart';
import 'package:searching_dataverse/services/third_party_plugins/aad_auth/lib/aad_oauth.dart';
import 'package:searching_dataverse/services/third_party_plugins/dataverse_oauth/dataverse_oauth.dart';


class DataverseAadOauthImp extends DataverseAadOauth {
  final AadOAuth _oauth;
  final Logger _log;

  DataverseAadOauthImp({required AadOAuth oauth, required Logger logger})
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
    return await _oauth.getAccessToken().then((token) async{

      if(token != null){

        await _oauth.getIdToken().then((idToken) {
          if(idToken != null){
            _log.i('AadOauthImp | IdToken | success: $idToken');
          }

        });

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

  @override
  Future<bool> checkAccessToken() async{
    return await _oauth.checkAccessToken().then((res) async{

      if(res){
        _log.i('AadOauthImp | checkAccessToken | success: $res');
        return true;
      }
      throw AccessTokenFailure('Access token not found') ;
    });
  }
}
