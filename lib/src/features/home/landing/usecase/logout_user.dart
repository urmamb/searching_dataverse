import 'package:dartz/dartz.dart';
import 'package:searching_dataverse/services/error/failure.dart';
import 'package:searching_dataverse/services/repository/repository.dart';
import 'package:searching_dataverse/services/usecase/usecases/usecase.dart';

/// This use case will remove accessToken and logout
/// [Output] : [bool] returns true if logout is successful
class LogOutUser extends UseCase<bool, NoParams> {
  final Repository _repository;

  LogOutUser(this._repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return _repository.logOutUser();
  }
}
