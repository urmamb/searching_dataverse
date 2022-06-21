import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:searching_dataverse/services/datasource/remote_data_source/remote_data_source.dart';

import '../../error/failure.dart';

class RemoteDataSourceImp implements RemoteDataSource {
  final Dio _dio;
  final Logger _log;
  final String _loginUrl;
  final String _resourceUrl;
  final String _apiVersion;
  final String _clientId;
  final String _tenantId;
  final String _redirectUri;

  RemoteDataSourceImp({required Dio dio, required Logger log, required loginUrl, required resourceUrl, required apiVersion, required clientId, required tenantId, required redirectUri})
      : _dio = dio,
        _log = log,
        _loginUrl = loginUrl,
        _resourceUrl = resourceUrl,
        _apiVersion = apiVersion,
        _clientId = clientId,
        _tenantId = tenantId,
        _redirectUri = redirectUri;

  String getOauthUrl() {
    var loginUrl = _loginUrl;
    var resource = _resourceUrl;
    var tenantId = _tenantId;

    return '$loginUrl$tenantId/oauth2/authorize?resource=$resource';
  }

  @override
  Future<String> getAccessToken() async {
    var oAuthUrl = getOauthUrl();

    _dio.options.headers = {'Access-Control-Allow-Origin': '*'};
    final response = await _dio.get(oAuthUrl);

    _log.i('[remote data source : getAccessToken] $response');

    if (response.statusCode == 200 && response.data != null && response.data['code'] == 1000) {
      return response.data;
    }

    // if (response.statusCode == 200 && response.data != null && response.data['code'] == 2011) {
    //   throw AccessTokenFailure('Access Token Failure');
    // }

    throw AccessTokenFailure('Access Token Failure');
    ;
  }
}
