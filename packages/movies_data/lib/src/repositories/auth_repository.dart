import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

const userStatus = 'user_status';

enum AuthenticationStatus { unknown, unauthenticated, authenticated }

class AuthRepository {
  final SharedPreferences sharedPreferences;

  AuthRepository(this.sharedPreferences);

  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    final status = sharedPreferences.getBool(userStatus) ?? false;
    print(status);
    if (status) {
      yield AuthenticationStatus.authenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }
    yield* _controller.stream;
  }

  Future<bool> logout() async {
    final state = await sharedPreferences.setBool(userStatus, false);
    _controller.sink.add(AuthenticationStatus.unauthenticated);
    return state;
  }

  Future<bool> login() async {
    final state = await sharedPreferences.setBool(userStatus, true);
    _controller.sink.add(AuthenticationStatus.authenticated);
    return state;
  }

  void dispose() => _controller.close();
}
