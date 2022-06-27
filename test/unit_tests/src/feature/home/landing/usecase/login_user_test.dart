import 'package:flutter_test/flutter_test.dart';
import 'package:searching_dataverse/services/repository/repository.dart';
import 'package:searching_dataverse/services/usecase/usecases/usecase.dart';
import 'package:searching_dataverse/src/features/home/landing/usecase/login_user.dart';

import '../../../../../mocks/mock_error_repository.dart';
import '../../../../../mocks/mock_repository.dart';

void main() {
  late Repository repository;
  late Repository errorRepository;
  late LogInUser usecase;

  setUp(() {
    repository = MockRepository();
    errorRepository = MockErrorRepository();
  });

  test('Should return true on successful login from repository', () async {
    // Arrange
    usecase = LogInUser(repository);
    // Act
    var result = await usecase.call(NoParams());

    // assert
    expect(true, result.isRight());
  });

  test('Should return error from repository', () async {
    // Arrange
    usecase = LogInUser(errorRepository);
    // Act
    var result = await usecase.call(NoParams());

    // assert
    expect(true, result.isLeft());

  });
}
