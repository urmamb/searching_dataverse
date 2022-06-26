

import 'package:dartz/dartz.dart';
import 'package:searching_dataverse/app/app_strings.dart';
import 'package:searching_dataverse/services/error/failure.dart';
import 'package:searching_dataverse/services/repository/repository.dart';
import 'package:searching_dataverse/services/usecase/usecases/usecase.dart';
import 'package:searching_dataverse/src/features/home/search_screen/usecase/get_accounts.dart';

class MockErrorRepository implements Repository {
  @override
  Future<Either<Failure, bool>> checkInternetConnection(NoParams params) async{
    return Left(ServerFailure(SOMETHING_WENT_WRONG));
  }

  @override
  Future<Either<Failure, bool>> clearSecureStorage(NoParams noParams) async{
    return Left(ServerFailure(SOMETHING_WENT_WRONG));
  }

  @override
  Future<Either<Failure, String>> getAccessToken() async{
    return Left(ServerFailure(SOMETHING_WENT_WRONG));
  }

  @override
  Future<Either<Failure, List<Account>>> getAccounts() async{
    return Left(ServerFailure(SOMETHING_WENT_WRONG));
  }

  @override
  Future<Either<Failure, String>> getAuthToken() async{
    return Left(ServerFailure(SOMETHING_WENT_WRONG));
  }

  @override
  Future<Either<Failure, bool>> logInUser() async{
    return Left(ServerFailure(SOMETHING_WENT_WRONG));
  }

  @override
  Future<Either<Failure, bool>> logOutUser() async{
    return Left(ServerFailure(SOMETHING_WENT_WRONG));
  }

  @override
  Future<Either<Failure, bool>> saveAuthToken(String params) async{
    return Left(ServerFailure(SOMETHING_WENT_WRONG));
  }
}