import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fs07/providers/log_provider.dart';
import 'package:fs07/utils/prefs_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Bloc
class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState(status: AppStatus.loading)) {
    on<LaunchApp>(_launchApp);
    on<LogOut>(_logout);
  }

  // final _appState = BehaviorSubject<AppState>.seeded(AppState.loading);

  // Stream<AppState> get appState => _appState.stream;

  // AppState get appStateValue => _appState.stream.value;

  // AppState get initState => AppState.loading;

  // String langCode = 'en';

  // LogProvider get logger => const LogProvider('⚡️ AppStateBloc');

  // AppStateBloc() {
  //   launchApp();
  // }

  Future<void> _launchApp(LaunchApp event, Emitter<AppState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final authorLevel = prefs.getInt(PrefsKey.authorLevel) ?? 0;
    // logger.log('authorLevel $authorLevel');
    //langCode = prefs.getString('langCode') ?? 'vi';

    switch (authorLevel) {
      case 2:
        await changeAppState(event, emit, AppStatus.authorized);
        break;
      default:
        await changeAppState(event, emit, AppStatus.unAuthorized);
    }
  }

  Future<void> changeAppState(
      AppEvent event, Emitter<AppState> emit, AppStatus status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(PrefsKey.authorLevel, status.index);
    // logger.log('changeAppState $status');
    emit(AppState(status: status));
  }

  Future<void> _logout(LogOut event, Emitter<AppState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();

    await changeAppState(event, emit, AppStatus.unAuthorized);
  }

  // @override
  // void dispose() {
  //   _appState.close();
  // }
}

//Event
abstract class AppEvent {}

class LaunchApp extends AppEvent {}

class LogOut extends AppEvent {}

//State
enum AppStatus { loading, unAuthorized, authorized }

class AppState {
  final Object? error;
  final AppStatus? status;

  AppState({
    required this.status,
    this.error,
  });

  static AppState get authorized => AppState(status: AppStatus.authorized);
  static AppState get unAuthorized => AppState(status: AppStatus.unAuthorized);
  static AppState get loading => AppState(status: AppStatus.loading);

  AppState copyWith({
    Object? error,
    AppStatus? status,
  }) =>
      AppState(
        error: error ?? this.error,
        status: status ?? this.status,
      );
}
