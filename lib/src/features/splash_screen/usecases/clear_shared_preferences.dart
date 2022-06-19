import 'package:dartz/dartz.dart';
import 'package:searching_dataverse/services/error/failure.dart';
import 'package:searching_dataverse/services/repository/repository.dart';
import 'package:searching_dataverse/services/usecase/usecases/usecase.dart';

///This usecase will clear all the sharedpreferences on device.
class ClearSharedPreferences implements UseCase<bool, NoParams> {
  Repository repository;

  ClearSharedPreferences(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams noParams) {
    return repository.clearSecureStorage(noParams);
  }
}
