class Failure {
  final Object? exception;
  final StackTrace? stackTrace;
  Failure([this.exception, this.stackTrace]);

  factory Failure.empty() {
    return Failure();
  }
}
