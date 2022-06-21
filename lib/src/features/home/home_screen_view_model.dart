import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:searching_dataverse/services/error/failure.dart';
import 'package:searching_dataverse/services/usecase/usecases/usecase.dart';
import 'package:searching_dataverse/src/features/home/usecase/get_access_token.dart';

class HomeScreenViewModel {
  final GetAccessToken _getAccessToken;

  HomeScreenViewModel({required GetAccessToken getAccessToken}) : _getAccessToken = getAccessToken;

  ValueChanged<String>? errorMessageNotifier;

  void handleError(Either<Failure, dynamic> either) {
    either.fold((l) => errorMessageNotifier?.call(l.message), (r) => null);
  }

  Future<void> getAccessToken() async {
    var getAccessTokenEither = await _getAccessToken.call(NoParams());

    if (getAccessTokenEither.isLeft()) {
      handleError(getAccessTokenEither);
      return;
    }

    var accessToken = getAccessTokenEither.getOrElse(() => '');
    print(accessToken);
  }
}
