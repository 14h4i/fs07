enum LoginStatus { success, newUser, fail, cancel }

class LoginState {
  final LoginStatus? status;
  final Object? error;

  LoginState({
    required this.status,
    this.error,
  });
}
