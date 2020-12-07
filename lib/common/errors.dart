class GenericError extends Error {
  final String message;
  GenericError(this.message);
}

class ApiResponseError extends GenericError {
  ApiResponseError(String message) : super(message);
}

class EloadProcessingError extends GenericError {
  EloadProcessingError(String message) : super(message);
}
