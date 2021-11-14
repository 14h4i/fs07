import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fs07/modules/authentication/enum/login_state.dart';
import 'package:fs07/modules/authentication/wrapper/models/login_data.dart';
import 'package:fs07/modules/authentication/wrapper/service/auth_service.dart';
import 'package:fs07/providers/bloc_provider.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, LoginState> {
  final AuthService auth;

  AuthenticationBloc(this.auth);

  Future<LoginStatus> _signIn(Future<LoginData?> signInMethod) async {
    try {
      final loginData = await signInMethod;
      if (loginData != null) {
        // return loginData.isNew ? LoginState.newUser : LoginState.success;
        return LoginStatus.success;
      }
      return LoginStatus.fail;
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginStatus> loginWithGmail() async {
    return _signIn(auth.loginWithGmail());
  }

  @override
  void dispose() {}
}

//Event
abstract class AuthenticationEvent {}

class SignIn extends AuthenticationEvent {}
