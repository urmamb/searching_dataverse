import 'package:searching_dataverse/services/third_party_plugins/aad_auth/lib/helper/core_oauth.dart';
import 'package:searching_dataverse/services/third_party_plugins/aad_auth/lib/model/config.dart';

CoreOAuth getOAuthConfig(Config config) => CoreOAuth.fromConfig(config);
