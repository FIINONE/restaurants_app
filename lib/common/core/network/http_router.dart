import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'network.dart';

class AppApiRouter {
  static final instance = AppApiRouter._();
  AppApiRouter._();

  Future<AppHttpResponse> sendRequest({
    required AppHttpRequest request,
  }) async {
    const String host = AppHttpPath.host;

    final client = http.Client();

    Uri uri;
    http.Response? response;

    final Map<String, String> headers = {'Content-Type': 'application/json; charset=utf-8'};

    if (request.token != null) {
      headers.addAll({
        'Authorization': 'Bearer ${request.token}',
      });
    }

    switch (request.method) {
      case AppHttpMethod.post:
        uri = Uri.http(host, request.path, request.queryParams);

        response = await client.post(
          uri,
          headers: headers,
          body: json.encode(request.body),
        );
        break;
      case AppHttpMethod.get:
        uri = Uri.http(host, request.path + request.queryPath, request.queryParams);

        response = await client.get(
          uri,
          headers: headers,
        );
        break;
      case AppHttpMethod.put:
        uri = Uri.http(host, request.path, request.queryParams);

        response = await client.put(
          uri,
          headers: headers,
          body: json.encode(request.body),
        );
        break;
      case AppHttpMethod.patch:
        uri = Uri.http(host, request.path, request.queryParams);

        response = await client.patch(
          uri,
          headers: headers,
          body: json.encode(request.body),
        );
        break;
      case AppHttpMethod.delete:
        uri = Uri.http(host, request.path, request.queryParams);

        response = await client.delete(
          uri,
          headers: headers,
          body: json.encode(request.body),
        );
        break;
      default:
        break;
    }
    try {
      log('╔════Network: Response═══───');
      log('║ request.uri ${host + request.path}');
      log('║ request.headers $headers');
      log('║ request.data ${request.body}');
      log('║ request.method ${request.method}');
      log('╠════════Response════════───');
      log('║ response.data ${jsonDecode(response!.body)}');
      log('║ response.code ${response.statusCode}');
      log('╚═══════════════════════───');

      ///
      if (response.statusCode == 200 || response.statusCode == 201) {
        return AppHttpResponse(
          statusCode: response.statusCode,
          map: jsonDecode(response.body),
          headers: response.headers,
        );
      }

      throw AppHttpException(
        statusCode: response.statusCode,
        map: jsonDecode(response.body),
      );
    } catch (e) {
      log('╔════Network: Error═══───');
      log('║ request.headers $headers');
      log('║ request.uri ${host + request.path}');
      log('║ request.data ${request.body}');
      log('║ request.method ${request.method}');
      log('╠════════Error════════───');
      log('║ $e');
      log('╚═══════════════════════───');
      rethrow;
    }
  }
}
