
import 'package:searching_dataverse/src/features/home/search_screen/usecase/get_accounts.dart';

abstract class RemoteDataSource {

  /// This use case will get accessToken from server
  /// [Input] : [String ]contains accessToken
  /// [Output] : List<[Account]> contains information about account.
  Future<List<Account>> getAccounts(String accessToken);

}