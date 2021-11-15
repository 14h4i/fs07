part of 'authentication_bloc.dart';

enum AuthenticationStatus { success, newUser, fail, cancel }

class AuthenticationState extends Equatable {
  final AuthenticationStatus? status;
  final Object? error;

  const AuthenticationState({
    this.status,
    this.error,
  });

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    Object? error,
  }) =>
      AuthenticationState(
        status: this.status,
        error: this.error,
      );

  @override
  List<Object?> get props => [];
}
