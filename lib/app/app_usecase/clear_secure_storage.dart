import 'package:dartz/dartz.dart';
import 'package:searching_dataverse/services/error/failure.dart';
import 'package:searching_dataverse/services/repository/repository.dart';
import 'package:searching_dataverse/services/usecase/usecases/usecase.dart';

/// This Usecase clears secure storage
class ClearSecureStorage implements UseCase<bool, NoParams> {
  final Repository _repository;

  ClearSecureStorage(this._repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return _repository.clearSecureStorage(params);
  }
}
