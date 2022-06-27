import 'package:flutter_test/flutter_test.dart';
import 'package:searching_dataverse/services/repository/repository.dart';
import 'package:searching_dataverse/services/usecase/usecases/usecase.dart';
import 'package:searching_dataverse/src/features/home/search_screen/usecase/get_accounts.dart';

import '../../../../../mocks/mock_constants.dart';
import '../../../../../mocks/mock_error_repository.dart';
import '../../../../../mocks/mock_repository.dart';

void main() {
  late Repository repository;
  late Repository errorRepository;
  late GetAccounts usecase;

  setUp(() {
    repository = MockRepository();
    errorRepository = MockErrorRepository();
  });

  test('Should return list of accounts from repository', () async {
    // Arrange
    usecase = GetAccounts(repository);
    // Act
    var result = await usecase.call(NoParams());

    // assert
    expect(true, result.isRight());
    expect(MOCK_ACCOUNT_LIST, result.getOrElse(() => MOCK_ACCOUNT_LIST));
  });

  test('Should return error from repository', () async {
    // Arrange
    usecase = GetAccounts(errorRepository);
    // Act
    var result = await usecase.call(NoParams());

    // assert
    expect(true, result.isLeft());
  });

  test('Should return two instance equal', () async {
    //Arrange
    var params = const Account(
        accountid: MOCK_ACCOUNT_ID,
        accountnumber: MOCK_ACCOUNT_NUMBER,
        name: MOCK_NAME,
        emailaddress1: MOCK_EMAIL,
        address1_composite: MOCK_ADDRESS,
        address1_postalcode: MOCK_POST_CODE,
        address1_city: MOCK_CITY,
        address1_stateorprovince: MOCK_STATE_PROVINCE,
        address1_country: MOCK_COUNTRY,
        statecode: MOCK_STATE_CODE);
    var params2 = const Account(
        accountid: MOCK_ACCOUNT_ID,
        accountnumber: MOCK_ACCOUNT_NUMBER,
        name: MOCK_NAME,
        emailaddress1: MOCK_EMAIL,
        address1_composite: MOCK_ADDRESS,
        address1_postalcode: MOCK_POST_CODE,
        address1_city: MOCK_CITY,
        address1_stateorprovince: MOCK_STATE_PROVINCE,
        address1_country: MOCK_COUNTRY,
        statecode: MOCK_STATE_CODE);

    var map = {
      'accountid': MOCK_ACCOUNT_ID,
      'accountnumber': MOCK_ACCOUNT_NUMBER,
      'name': MOCK_NAME,
      'emailaddress1': MOCK_EMAIL,
      'address1_composite': MOCK_ADDRESS,
      'address1_postalcode': MOCK_POST_CODE,
      'address1_city': MOCK_CITY,
      'address1_stateorprovince': MOCK_STATE_PROVINCE,
      'address1_country': MOCK_COUNTRY,
      'statecode': MOCK_STATE_CODE
    };

    // assert
    expect(params, params2);
    expect(Account.fromJson(map), Account.fromJson(map));
  });
}
