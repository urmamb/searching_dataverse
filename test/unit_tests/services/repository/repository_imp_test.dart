


import 'package:flutter_test/flutter_test.dart';
import 'package:searching_dataverse/app/app_strings.dart';
import 'package:searching_dataverse/services/repository/repository_imp.dart';

import '../../mocks/mock_constants.dart';
import '../../mocks/mock_dataverse_oauth.dart';
import '../../mocks/mock_logger.dart';
import '../../mocks/mock_remote_datasource.dart';

void main() {
  runTestOnlineWithNoError();
}


void runTestOnlineWithNoError() {

  var remoteDataSource = MockRemoteDataSource();
  var log = MockLogger();
  var dataverseAadOauth = MockDataversAadOauth();
  var repositoryImpOnline = RepositoryImp(remoteDataSource: remoteDataSource, log: log, aadOauth: dataverseAadOauth);



  test('should return true on user login', () async {
    var response = await repositoryImpOnline.logInUser();

    expect(true, response.isRight());
    response.fold((l) => throw SOMETHING_WENT_WRONG, (r) => expect(true, r));
  });

  test('should return true on user logout', () async {
    var response = await repositoryImpOnline.logOutUser();

    expect(true, response.isRight());
    response.fold((l) => throw SOMETHING_WENT_WRONG, (r) => expect(true, r));
  });

  test('should return access token', () async {
    var response = await repositoryImpOnline.getAccessToken();

    expect(true, response.isRight());
    response.fold((l) => throw SOMETHING_WENT_WRONG, (r) => expect(MOCK_ACCESSTOKEN_TOKEN, r));
  });

  test('should return list of accounts', () async {
    var response = await repositoryImpOnline.getAccounts();

    expect(true, response.isRight());
    response.fold((l) => throw SOMETHING_WENT_WRONG, (r) => expect(MOCK_ACCOUNT_LIST, r));
  });
}