import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:searching_dataverse/services/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class InstantUseCase<Type, Params> {
  Either<Failure, Type> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class SendInviteParam extends Equatable {
  final String message;
  final List<String> contacts;
  const SendInviteParam(this.message, this.contacts);

  @override
  List<Object> get props => [message, contacts];
}