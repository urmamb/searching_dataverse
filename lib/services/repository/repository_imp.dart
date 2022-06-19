import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logger/logger.dart';
import 'package:searching_dataverse/services/datasource/local_data_source/local_data_source.dart';
import 'package:searching_dataverse/services/datasource/remote_data_source/remote_data_source.dart';
import 'package:searching_dataverse/services/error/failure.dart';
import 'package:searching_dataverse/services/repository/repository.dart';
import 'package:searching_dataverse/services/usecase/usecases/usecase.dart';
import 'package:searching_dataverse/utils/constants/app_strings.dart';
import 'package:searching_dataverse/utils/network/network_info.dart';


class RepositoryImp implements Repository {
  final LocalDataSource _localDataSource;
  final Logger _log;
  final NetworkInfo _networkInfo;
  final RemoteDataSource _remoteDataSource;

  RepositoryImp({required LocalDataSource localDataSource, required NetworkInfo networkInfo, required RemoteDataSource remoteDataSource, required Logger log})
      : _localDataSource = localDataSource,
        _log = log,
        _remoteDataSource = remoteDataSource,
        _networkInfo = networkInfo;

  @override
  @override
  Future<Either<Failure, String>> getAuthToken() async {
    try {
      return right(await _localDataSource.getAuthToken());
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> saveAuthToken(String params) async {
    try {
      return Right(await _localDataSource.saveAuthToken(params));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> checkInternetConnection(NoParams params) async {
    try {
      return Right(await _networkInfo.isConnected);
    } catch (e) {
      return Left(NetworkFailure(NO_INTERNET));
    }
  }

  @override
  Future<Either<Failure, bool>> clearSecureStorage(NoParams noParams) async {
    try {
      return Right(await _localDataSource.clearsSecureStorage());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logoutUser() async {
    try {
      return Right(await _localDataSource.clearsSecureStorage());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

}
