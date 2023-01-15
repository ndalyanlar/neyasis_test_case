import 'package:dio/dio.dart';

class NetworkManager {
  static final NetworkManager _instance = NetworkManager._init();
  static NetworkManager get instance => _instance;
  NetworkManager._init() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }
  String baseUrl = "https://63bff73ba177ed68abbc768b.mockapi.io";

  late Dio dio;
}

//* use for lazy singleton
class NetworkManagerLazy {
  static NetworkManagerLazy? _instance;
  static NetworkManagerLazy get instance {
    _instance ??= NetworkManagerLazy._init();
    return _instance!;
  }

  NetworkManagerLazy._init() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  String baseUrl = "https://63bff73ba177ed68abbc768b.mockapi.io";

  late Dio dio;
}
