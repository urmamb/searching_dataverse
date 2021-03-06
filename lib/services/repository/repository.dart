import 'package:dartz/dartz.dart';
import 'package:searching_dataverse/services/error/failure.dart';
import 'package:searching_dataverse/services/usecase/usecases/usecase.dart';
import 'package:searching_dataverse/src/features/home/search_screen/usecase/get_accounts.dart';

abstract class Repository {

  /// This use case will get accessToken from server
  /// [Input]: contains query parameters
  /// [Output] : [String] contains accessToken.
  Future<Either<Failure, String>> getAccessToken();

  /// This use case will remove accessToken and logout
  /// [Output] : [bool] returns true if logout is successful
  Future<Either<Failure, bool>> logOutUser();

  /// This use case will prompt user to login screen
  /// [Output] : [bool] returns true if logout is successful
  Future<Either<Failure, bool>> logInUser();

  /// This use case will get accessToken from server
  /// [Input] : contains query parameters
  /// [Output] : List<[Account]> contains information about account.
  Future<Either<Failure, List<Account>>> getAccounts();

  /// This use case will check accessToken availablity in web only
  /// Output: [bool] returns true if accessToken is available else false
  Future<Either<Failure, bool>> checkAccessToken();


}
