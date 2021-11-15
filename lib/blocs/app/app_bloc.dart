import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fs07/utils/prefs_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_state.dart';
part 'app_event.dart';

//Bloc
class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState(status: AppStatus.loading)) {
    on<LaunchApp>(_launchApp);
    on<LogOut>(_logout);
    on<ChangeAppState>(_changeAppState);
  }

  Future<void> _launchApp(LaunchApp event, Emitter<AppState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final authorLevel = prefs.getInt(PrefsKey.authorLevel) ?? 0;

    switch (authorLevel) {
      case 2:
        add(ChangeAppState(status: AppStatus.authorized));
        break;
      default:
        add(ChangeAppState(status: AppStatus.unAuthorized));
    }
  }

  Future<void> _changeAppState(
      ChangeAppState event, Emitter<AppState> emit) async {
    final status = event.status;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(PrefsKey.authorLevel, status!.index);
    emit(state.copyWith(status: status));
  }

  Future<void> _logout(LogOut event, Emitter<AppState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();

    add(ChangeAppState(status: AppStatus.unAuthorized));
  }
}
