import 'package:equatable/equatable.dart';

enum StartupStatus { initial, loading, success, failure }

class StartupState extends Equatable {
  const StartupState({
    this.status = StartupStatus.initial,
    this.errorMessage,
  });

  final StartupStatus status;
  final String? errorMessage;

  StartupState copyWith({
    StartupStatus? status,
    String? errorMessage,
  }) {
    return StartupState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  StartupStatus? get getStatus => status;

  String? get getErrorMessage => errorMessage;

  @override
  List<Object?> get props => [status, errorMessage];
}
