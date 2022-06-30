


import 'package:dartz/dartz.dart';
import 'package:searching_dataverse/services/error/failure.dart';
import 'package:searching_dataverse/services/repository/repository.dart';
import 'package:searching_dataverse/services/usecase/usecases/usecase.dart';

/// This use case will check accessToken availablity in web only
/// Output: [bool] returns true if accessToken is available else false
class CheckAccessToken implements UseCase<bool, NoParams>{
  final Repository _repository;

  CheckAccessToken(this._repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return _repository.checkAccessToken();
  }

}