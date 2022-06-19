import 'package:dartz/dartz.dart';
import 'package:searching_dataverse/services/error/failure.dart';
import 'package:searching_dataverse/services/repository/repository.dart';
import 'package:searching_dataverse/services/usecase/usecases/usecase.dart';

class LogoutUser implements UseCase<bool, NoParams> {
  Repository repository;

  LogoutUser(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return repository.logoutUser();
  }
}
