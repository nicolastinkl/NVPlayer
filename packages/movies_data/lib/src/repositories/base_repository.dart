import 'dart:io';

import 'package:movies_data/movies_data.dart';

typedef ResultCallback<T> = Future<T> Function();

class BaseRepository {
  Future<ResponseState<T>> launchWithCatchError<T>(
      ResultCallback<T> callback) async {
    try {
      return Success<T>(data: await callback());
    } on IOException {
      return NoConnection<T>();
    } catch (error) {
      return Fail<T>(error: error);
    }
  }
}
