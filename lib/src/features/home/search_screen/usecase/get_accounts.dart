import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:searching_dataverse/services/error/failure.dart';
import 'package:searching_dataverse/services/repository/repository.dart';
import 'package:searching_dataverse/services/usecase/usecases/usecase.dart';

/// This use case will get accessToken from server
/// [Input] : contains query parameters
/// [Output] : List<[Account]> contains information about account.
class GetAccounts extends UseCase<List<Account>, NoParams> {
  final Repository _repository;

  GetAccounts(this._repository);

  @override
  Future<Either<Failure, List<Account>>> call(NoParams params) {
    return _repository.getAccounts();
  }
}

class Account extends Equatable {
  final String accountid;
  final String accountnumber;
  final String name;
  final String emailaddress1;
  final String address1_composite;
  final String address1_postalcode;
  final String address1_city;
  final String address1_stateorprovince;
  final String address1_country;
  final int statecode;

  const Account(
      {required this.accountid,
      required this.accountnumber,
      required this.name,
      required this.emailaddress1,
      required this.address1_composite,
      required this.address1_postalcode,
      required this.address1_city,
      required this.address1_stateorprovince,
      required this.address1_country,
      required this.statecode});

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
        accountid: json['accountid'],
        accountnumber: json['accountnumber'],
        name: json['name'],
        emailaddress1: json['emailaddress1'],
        address1_composite: json['address1_composite'],
        address1_postalcode: json['address1_postalcode'],
        address1_city: json['address1_city'],
        address1_stateorprovince: json['address1_stateorprovince'],
        address1_country: json['address1_country'],
        statecode: json['statecode']);
  }

  factory Account.empty(){
    return const Account(accountid: '', accountnumber: '', name: '', emailaddress1: '', address1_composite: '', address1_postalcode: '', address1_city: '', address1_stateorprovince: '', address1_country: '', statecode: 0);
  }

  @override
  List<Object?> get props => [accountid, accountnumber, name, emailaddress1, address1_composite, address1_postalcode, address1_city, address1_stateorprovince, address1_country, statecode];
}
