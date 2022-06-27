

import 'package:searching_dataverse/services/third_party_plugins/dataverse_oauth/dataverse_oauth_imp.dart';

import 'mock_constants.dart';

class MockDataversAadOauth implements DataverseAadOauthImp{
  @override
  Future<String> getAccessToken() async{
    return MOCK_ACCESSTOKEN_TOKEN;
  }

  @override
  Future<bool> login() async{
    return true;
  }

  @override
  Future<bool> logout() async{
    return true;
  }

}