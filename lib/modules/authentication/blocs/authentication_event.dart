part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignIn extends AuthenticationEvent {
  final Future<LoginData?>? signInMethod;
  SignIn({required this.signInMethod});

  @override
  List<Object?> get props => [signInMethod];
}

class LoginWithGmail extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}
