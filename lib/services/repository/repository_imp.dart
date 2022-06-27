import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:searching_dataverse/services/datasource/remote_data_source/remote_data_source.dart';
import 'package:searching_dataverse/services/error/failure.dart';
import 'package:searching_dataverse/services/repository/repository.dart';
import 'package:searching_dataverse/services/third_party_plugins/dataverse_oauth/dataverse_oauth.dart';
import 'package:searching_dataverse/src/features/home/search_screen/usecase/get_accounts.dart';
import 'package:searching_dataverse/utils/constants/app_strings.dart';

class RepositoryImp implements Repository {
  final RemoteDataSource _remoteDataSource;
  final DataverseAadOauth _aadOauth;

  RepositoryImp({required RemoteDataSource remoteDataSource, required Logger log, required DataverseAadOauth aadOauth})
      : _remoteDataSource = remoteDataSource,
        _aadOauth = aadOauth;

  @override
  Future<Either<Failure, String>> getAccessToken() async {
    try {
      return Right(await _aadOauth.getAccessToken());
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logOutUser() async{
    try {
      return Right(await _aadOauth.logout());
    } on Failure catch (e) {
    return Left(e);
    } catch (e) {
    return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logInUser() async{
    try {
      return Right(await _aadOauth.login());
    } on Failure catch (e) {
    return Left(e);
    } catch (e) {
    return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Account>>> getAccounts() async{
    try {
      final accessTokenEither = await getAccessToken();
      if (accessTokenEither.isLeft()) {
        return Left(accessTokenEither.swap().toOption().toNullable()!);
      }
      var accessToken = accessTokenEither.getOrElse(() => '');
      return Right(await _remoteDataSource.getAccounts(accessToken));
    } on Failure catch (e) {
      return Left(e);
    } on DioError catch (_) {
      return Left(ServerFailure(SOMETHING_WENT_WRONG));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
