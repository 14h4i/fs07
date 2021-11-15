import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fs07/modules/authentication/wrapper/models/login_data.dart';
import 'package:fs07/modules/authentication/wrapper/service/auth_service.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this.auth) : super(const AuthenticationState()) {
    on<SignIn>(_signIn);
    on<LoginWithGmail>(_loginWithGmail);
  }

  final AuthService auth;

  // AuthenticationBloc(this.auth);

  // Future<LoginStatus> _signIn(Future<LoginData?> signInMethod) async {
  Future<void> _signIn(SignIn event, Emitter<AuthenticationState> emit) async {
    try {
      final loginData = await event.signInMethod;
      if (loginData != null) {
        // return loginData.isNew ? LoginState.newUser : LoginState.success;
        emit(state.copyWith(status: AuthenticationStatus.success));
      } else {
        emit(state.copyWith(status: AuthenticationStatus.fail));
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _loginWithGmail(
      LoginWithGmail event, Emitter<AuthenticationState> emit) async {
    // return _signIn(auth.loginWithGmail());
  }
}
