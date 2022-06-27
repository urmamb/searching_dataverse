

import 'package:searching_dataverse/services/datasource/remote_data_source/remote_data_source.dart';
import 'package:searching_dataverse/src/features/home/search_screen/usecase/get_accounts.dart';

import 'mock_constants.dart';

class MockRemoteDataSource implements RemoteDataSource {

  @override
  Future<List<Account>> getAccounts(String accessToken) async{
    return MOCK_ACCOUNT_LIST;
  }

}