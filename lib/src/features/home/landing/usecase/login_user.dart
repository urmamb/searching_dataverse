import 'package:dartz/dartz.dart';
import 'package:searching_dataverse/services/error/failure.dart';
import 'package:searching_dataverse/services/repository/repository.dart';
import 'package:searching_dataverse/services/usecase/usecases/usecase.dart';

/// This use case will prompt user to login screen
/// [Output] : [bool] returns true if logout is successful
class LogInUser extends UseCase<bool, NoParams> {
  final Repository _repository;

  LogInUser(this._repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return _repository.logInUser();
  }
}
