import 'package:dartz/dartz.dart';
import 'package:searching_dataverse/services/error/failure.dart';
import 'package:searching_dataverse/services/repository/repository.dart';
import 'package:searching_dataverse/services/usecase/usecases/usecase.dart';


/// This method save auth token in local storage
/// Input: [String] auth token
/// Output : if operation successful returns true
/// if unsuccessful the response will be [Failure]

class SaveAuthToken implements UseCase<bool, String> {
  final Repository _repository;

  SaveAuthToken(this._repository);

  @override
  Future<Either<Failure, bool>> call(String params) {
    return _repository.saveAuthToken(params);
  }
}