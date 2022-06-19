import 'package:dartz/dartz.dart';
import 'package:searching_dataverse/services/error/failure.dart';
import 'package:searching_dataverse/services/repository/repository.dart';
import 'package:searching_dataverse/services/usecase/usecases/usecase.dart';

/// This method get the auth token from local storage
/// Output: [String] returns auth token
/// if unsuccessful the response will be [Failure]
class GetAuthToken implements UseCase<String, NoParams> {
  final Repository _repository;

  GetAuthToken(this._repository);

  @override
  Future<Either<Failure, String>> call(NoParams noParams) {
    return _repository.getAuthToken();
  }
}
