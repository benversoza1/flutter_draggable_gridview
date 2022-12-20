import 'package:connector_openapi/api_client.dart' as connector;
import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart' as core;

class PiecesApi {
  static final PiecesApi _instance = PiecesApi._internal();

  static const String base = 'http://localhost:1000';

  static final core.ApiClient _coreClient = core.ApiClient(
    basePath: base,
  );
  static final connector.ApiClient _connectorClient = connector.ApiClient(
    basePath: base,
  );

  factory PiecesApi() {
    return _instance;
  }

  PiecesApi._internal();

  /// ================================== General API Access ======================== ///
  ///

  /// Asset API
  static AssetApi get assetApi {
    return AssetApi(_coreClient);
  }

  /// Assets API
  static AssetsApi get assetsApi {
    return AssetsApi(_coreClient);
  }

  /// WellKnown API
  static WellKnownApi get wellKnownApi {
    return WellKnownApi(_coreClient);
  }

  /// People API
  static UserApi get userApi {
    return UserApi(_coreClient);
  }

  /// Activities API
  static ActivitiesApi get activitiesApi {
    return ActivitiesApi(_coreClient);
  }

  /// Activity API
  static ActivityApi get activityApi {
    return ActivityApi(_coreClient);
  }
}
