
import 'package:dartz/dartz.dart';
import 'package:searching_dataverse/services/error/failure.dart';
import 'package:searching_dataverse/services/repository/repository.dart';
import 'package:searching_dataverse/services/usecase/usecases/usecase.dart';
import 'package:searching_dataverse/src/features/home/search_screen/usecase/get_accounts.dart';

import 'mock_constants.dart';

class MockRepository implements Repository {
  @override
  Future<Either<Failure, bool>> checkInternetConnection(NoParams params) async{
    return const Right(true);
  }

  @override
  Future<Either<Failure, bool>> clearSecureStorage(NoParams noParams) async{
    return const Right(true);
  }

  @override
  Future<Either<Failure, String>> getAccessToken() async{
    return const Right(MOCK_ACCESSTOKEN_TOKEN);
  }

  @override
  Future<Either<Failure, List<Account>>> getAccounts() async{
    return Right(MOCK_ACCOUNT_LIST);
  }

  @override
  Future<Either<Failure, String>> getAuthToken() async{
    return const Right(MOCK_ACCESSTOKEN_TOKEN);
  }

  @override
  Future<Either<Failure, bool>> logInUser() async{
    return const Right(true);
  }

  @override
  Future<Either<Failure, bool>> logOutUser() async{
    return const Right(true);
  }

  @override
  Future<Either<Failure, bool>> saveAuthToken(String params) async{
    return const Right(true);
  }
}