part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LaunchApp extends AppEvent {}

class LogOut extends AppEvent {}

class ChangeAppState extends AppEvent {
  final AppStatus? status;
  ChangeAppState({required this.status});

  @override
  List<Object?> get props => [status];
}
