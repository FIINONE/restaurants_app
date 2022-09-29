//объект запроса к апи
import 'http_method.dart';

class AppHttpRequest {
  final String path;
  final Map<String, dynamic>? queryParams;
  final String queryPath;
  final Map<String, dynamic>? body;
  final AppHttpMethod method;
  final List<String>? filePaths;
  final String? token;

  AppHttpRequest({
    required this.path,
    this.queryParams,
    this.queryPath = '',
    this.body,
    required this.method,
    this.filePaths,
    required this.token,
  });
}
