

import 'package:searching_dataverse/app/app_strings.dart';
import 'package:searching_dataverse/services/datasource/remote_data_source/remote_data_source.dart';
import 'package:searching_dataverse/src/features/home/search_screen/usecase/get_accounts.dart';

class MockRemoteDataSourceError implements RemoteDataSource {

  @override
  Future<List<Account>> getAccounts(String accessToken) async{
    throw SOMETHING_WENT_WRONG;
  }
}