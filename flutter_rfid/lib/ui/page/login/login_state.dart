import 'package:equatable/equatable.dart';
import 'package:flutter_rfid/data/models/enums/load_status.dart';

class LoginState extends Equatable {
  final LoadStatus loadStatus;
  final String errorMessage;

  const LoginState({required this.loadStatus, required this.errorMessage});

  // initial state
  factory LoginState.initial() {
    return const LoginState(loadStatus: LoadStatus.initial, errorMessage: '');
  }

  LoginState copyWith({
    LoadStatus? loadStatus,
    String? errorMessage,
  }) {
    return LoginState(
        loadStatus: loadStatus ?? this.loadStatus,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [loadStatus, errorMessage];
}
