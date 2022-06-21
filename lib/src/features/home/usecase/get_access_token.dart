import 'package:dartz/dartz.dart';
import 'package:searching_dataverse/services/error/failure.dart';
import 'package:searching_dataverse/services/repository/repository.dart';
import 'package:searching_dataverse/services/usecase/usecases/usecase.dart';

/// This use case will get accessToken from server
/// [Input] : contains query parameters
/// [Output] : [String] contains accessToken.
class GetAccessToken extends UseCase<String, NoParams> {
  final Repository _repository;

  GetAccessToken(this._repository);

  @override
  Future<Either<Failure, String>> call(NoParams params) {
    return _repository.getAccessToken();
  }
}
