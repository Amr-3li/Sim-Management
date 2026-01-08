class Failure {
  final String message;

  const Failure(this.message);
}

class PermissionFailure extends Failure {
  const PermissionFailure(String message) : super(message);
}

class SimFailure extends Failure {
  const SimFailure(String message) : super(message);
}
