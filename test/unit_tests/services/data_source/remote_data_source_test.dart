
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mockito/mockito.dart';
import 'package:searching_dataverse/services/datasource/remote_data_source/remote_data_source_imp.dart';
import 'package:searching_dataverse/services/error/failure.dart';

import '../../mocks/mock_constants.dart';
import '../../mocks/mock_dio.dart';
import '../../mocks/mock_logger.dart';

// @GenerateMocks([Dio])
// @GenerateMocks([Logger])

void main() {
  late Dio dio;
  late Logger logger;
  late RemoteDataSourceImp remoteDataSourceImp;


  setUp(() {
  dio = MockDio();
  logger = MockLogger();
  remoteDataSourceImp = RemoteDataSourceImp(dio: dio, log: logger, webApiUrl: MOCK_WEB_API_URL);

  });


  test('should get accounts', () async {
    when(dio.options).thenAnswer((realInvocation) => BaseOptions(headers: {}));
    when(dio.get(
      '$MOCK_WEB_API_URL/accounts',
    )).thenAnswer((realInvocation) async => Response(
        statusCode: 200,
        data: {'code': 1000, 'value': MOCK_ACCOUNT_JSON},
        requestOptions: RequestOptions(path: ''))
    );

    var response = await remoteDataSourceImp.getAccounts(MOCK_ACCESSTOKEN_TOKEN);
    expect(MOCK_ACCOUNT_LIST, response);
  });

  test('should throw error on get accounts', () async {
    when(dio.options).thenAnswer((realInvocation) => BaseOptions(headers: {}));
    when(dio.get(
      '$MOCK_WEB_API_URL/accounts',
    )).thenAnswer((realInvocation) async => Response(
        statusCode: 401,
        data: {},
        requestOptions: RequestOptions(path: ''))
    );

    expect(() async => await remoteDataSourceImp.getAccounts(MOCK_ACCESSTOKEN_TOKEN), throwsA(isA<AccessTokenFailure>()));

  });
}