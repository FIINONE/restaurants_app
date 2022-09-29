class AppHttpResponse {
  final int statusCode;
  final dynamic map;
  final Map<String, String>? headers;

  const AppHttpResponse({
    required this.statusCode,
    required this.map,
    this.headers,
  });
}
