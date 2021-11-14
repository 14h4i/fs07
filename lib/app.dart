import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fs07/blocs/app_state_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appStateBloc = AppBloc();
  late AuthenticationBloc _authenticationBloc;
  static final GlobalKey<State> key = GlobalKey();

  @override
  void initState() {
    super.initState();
    appStateBloc.add(LaunchApp());
    _authenticationBloc = AuthenticationBloc(AppAuthService());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => appStateBloc,
      child: BlocBuilder<AppBloc, AppState>(
          // stream: appStateBloc.appState,
          // initialData: appStateBloc.initState,
          bloc: appStateBloc,
          builder: (context, state) {
            if (state.status == AppStatus.loading) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Container(
                  color: Colors.white,
                ),
              );
            }
            if (state.status == AppStatus.unAuthorized) {
              return BlocProvider(
                bloc: _authenticationBloc,
                child: MaterialApp(
                  key: const ValueKey('UnAuthorized'),
                  themeMode: ThemeMode.light,
                  builder: _builder,
                  // initialRoute: RouteName.welcomePage,
                  onGenerateRoute: Routes.unAuthorizedRoute,
                  debugShowCheckedModeBanner: false,
                ),
              );
            }

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: '/',
              onGenerateRoute: Routes.authorizedRoute,
              key: key,
              builder: _builder,
              navigatorKey: MyApp.navigatorKey,
            );
          }),
    );
  }

  Widget _builder(BuildContext context, Widget? child) {
    final data = MediaQuery.of(context);
    return MediaQuery(
      data: data.copyWith(textScaleFactor: 1),
      child: child!,
    );
  }
}
