abstract class BaseNetworkError extends Error {
  final int statusCode;
  final String message;

  BaseNetworkError({
    required this.statusCode,
    required this.message,
  });
}

class DownloadError extends BaseNetworkError {
  DownloadError({
    required super.statusCode,
    required super.message,
  });
}

class NetworkError extends BaseNetworkError {
  NetworkError({
    required super.statusCode,
    required super.message,
  });
}