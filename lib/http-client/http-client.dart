import 'package:dio/dio.dart';
final backendUrl = 'https://localhost:7184/';
final dioOptions = BaseOptions(
  baseUrl: backendUrl,
  connectTimeout: const Duration(seconds: 3),
  receiveTimeout: const Duration(seconds: 5),
  responseType: ResponseType.json,
  headers: {
    'Accept': 'application/json',
  },
);
final dio = Dio(dioOptions);

class HttpClient {
  static Future<Object?> makeGetRequest<T>(
    String subUrl,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final response = await dio.get(subUrl);
      final statusCode = response.statusCode;

      if (statusCode == 200) {
        final data = response.data;
        if (data is List) {
          return data.map((item) => fromJson(item)).toList();
        } else if (data is Map<String, dynamic>) {
          return fromJson(data);
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception('Failed to load data: Status code $statusCode');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  static Future<Response> post(url, object) async {
    return dio.post('$backendUrl$url', data: object,
        onSendProgress: (int sent, int total) {
      print('$sent $total');
    });
  }

  static getHttp(url, [token]) async {
    if (token?.length != 0) {
      dio.options.headers = {'Authorization': token};
    }
    final response = await dio.get(backendUrl + url);
  }
}
