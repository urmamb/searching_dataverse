

import 'package:flutter_test/flutter_test.dart';
import 'package:searching_dataverse/services/repository/repository.dart';
import 'package:searching_dataverse/services/usecase/usecases/usecase.dart';
import 'package:searching_dataverse/src/features/home/landing/usecase/get_access_token.dart';

import '../../../../../mocks/mock_constants.dart';
import '../../../../../mocks/mock_error_repository.dart';
import '../../../../../mocks/mock_repository.dart';



void main() {
  late Repository repository;
  late Repository errorRepository;
  late GetAccessToken usecase;

  setUp(() {
    repository = MockRepository();
    errorRepository = MockErrorRepository();
  });

  test('Should return accessToken from repository', () async {
    // Arrange
    usecase = GetAccessToken(repository);
    // Act
    var result = await usecase.call(NoParams());

    // assert
    expect(true, result.isRight());
    expect(MOCK_ACCESSTOKEN_TOKEN, result.getOrElse(() => MOCK_ACCESSTOKEN_TOKEN));
  });

  test('Should return error from repository', () async {
    // Arrange
    usecase = GetAccessToken(errorRepository);
    // Act
    var result = await usecase.call(NoParams());

    // assert
    expect(true, result.isLeft());

  });
}
