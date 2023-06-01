import 'package:flutter/foundation.dart';

@immutable
abstract class ResponseState<T> {
  const ResponseState();

  T? getValueOrNull() {
    if (this is Success) return (this as Success<T>).data;
    return null;
  }

  // Call this fun only in success cases
  T get successValue => (this as Success<T>).data;

  Object? get errorValue => (this as Fail).error;

}

class Success<T> extends ResponseState<T> {
  final T data;

  const Success({required this.data});
}

class Fail<T> extends ResponseState<T> {
  final Object? error;

  const Fail({required this.error});
}

class NoConnection<T> extends ResponseState<T> {}

class Empty<T> extends ResponseState<T> {}
