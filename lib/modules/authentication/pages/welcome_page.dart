import 'package:flutter/material.dart';
import 'package:fs07/blocs/app_state_bloc.dart';
import 'package:fs07/providers/bloc_provider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  AppBloc? get appStateBloc => BlocProvider.of<AppBloc>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: const Text('Login'),
          onPressed: _changeAppState,
        ),
      ),
    );
  }

  void _changeAppState() {
    appStateBloc!.changeAppState(AppStatus.authorized);
  }
}
