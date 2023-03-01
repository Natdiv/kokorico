import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]) : super();
}

// General failures
class FirebaseFailure extends Failure {
  final String _message;

  String get message => _message;

  const FirebaseFailure(this._message);

  @override
  List<Object?> get props => [_message];
}

class NetworkFailure extends Failure {
  final String _message;
  const NetworkFailure(this._message);

  String get message => _message;
  @override
  List<Object?> get props => [_message];
}
