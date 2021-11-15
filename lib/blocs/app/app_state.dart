part of 'app_bloc.dart';

enum AppStatus { loading, unAuthorized, authorized }

class AppState extends Equatable {
  final Object? error;
  final AppStatus? status;

  const AppState({
    required this.status,
    this.error,
  });

  AppState copyWith({
    Object? error,
    AppStatus? status,
  }) =>
      AppState(
        error: error ?? this.error,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [];
}
