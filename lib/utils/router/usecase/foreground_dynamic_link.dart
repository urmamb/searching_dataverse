
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

// class ForegroundDynamicLink
  //   implements InstantUseCase<NoParams, DynamicLinkCallbacks> {
  // Repository repository;
  //
  // ForegroundDynamicLink(this.repository);
  //
  // @override
  // Either<Failure, NoParams> call(DynamicLinkCallbacks params) {
  //   repository.onGetLinkWhenAppInForeground(params);
  //   return Right(NoParams());
  // }
// }

class DynamicLinkCallbacks {
  ValueChanged<Uri> onGetLink;
  ValueChanged<String> onError;
  DynamicLinkCallbacks(this.onGetLink, this.onError);
}
