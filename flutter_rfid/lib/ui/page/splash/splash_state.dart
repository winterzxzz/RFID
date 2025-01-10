import 'package:equatable/equatable.dart';
import 'package:flutter_rfid/data/models/enums/load_status.dart';

class SplashState extends Equatable {
  final LoadStatus loadStatus;
  final String message;

  const SplashState({
    required this.loadStatus,
    required this.message,
  });

  // initial state
  factory SplashState.initial() => const SplashState(
        loadStatus: LoadStatus.initial,
        message: '',
      );

  SplashState copyWith({
    LoadStatus? loadStatus,
    String? message,
  }) =>
      SplashState(
        loadStatus: loadStatus ?? this.loadStatus,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [loadStatus, message];
}
