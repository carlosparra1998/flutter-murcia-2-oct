class HttpResponse<T> {
  final T? data;
  final String? errorMessage;
  final bool hasError;

  HttpResponse({
    this.data,
    this.errorMessage,
    this.hasError = false,
  });
}

class EndpointCallError implements Exception {
  String cause;
  EndpointCallError(this.cause);
}