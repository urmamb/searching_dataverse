
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:searching_dataverse/app/globals.dart';
import 'package:searching_dataverse/services/repository/repository.dart';
import 'package:searching_dataverse/services/third_party_plugins/aad_auth/lib/aad_oauth.dart';
import 'package:searching_dataverse/services/third_party_plugins/dataverse_oauth/dataverse_oauth.dart';
import 'package:searching_dataverse/utils/dependency_injection/dependency_injection.dart';
import 'package:searching_dataverse/utils/network/network_info.dart';
import 'package:searching_dataverse/utils/router/app_state.dart';

void main() {
  tearDown(() {
    GetIt.I.reset();
  });

  test('should contains all dependencies', () async {
    await TestWidgetsFlutterBinding.ensureInitialized();

    final log = <MethodCall>[];
    var channel = const MethodChannel('plugins.flutter.io/shared_preferences');

    // Register the mock handler.
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      log.add(methodCall);
    });

    await init();


    expect(true, sl.isRegistered<DataverseAadOauth>());

    expect(true, sl.isRegistered<Repository>());
    expect(true, sl.isRegistered<AadOAuth>());
    expect(true, sl.isRegistered<Dio>());
    expect(true, sl.isRegistered<FlutterSecureStorage>());

    expect(true, sl.isRegistered<NetworkInfo>());
    expect(true, sl.isRegistered<AppState>());

    channel.setMockMethodCallHandler(null);
  });
}
