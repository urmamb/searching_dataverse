import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  Failure(this.message);
}

// General failures

class ServerFailure extends Failure {
  ServerFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {
  CacheFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}
// Failure for KYC
class TokenExpireFailure extends Failure {
  TokenExpireFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

// Failure for underlying platform
class PlatformFailure extends Failure {
  PlatformFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}


// RemoteConfig Failure
class NetworkFailure extends Failure {
  NetworkFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}

// AccessToken  Failure
class AccessTokenFailure extends Failure {
  AccessTokenFailure(message) : super(message);

  @override
  List<Object> get props => [message];
}
