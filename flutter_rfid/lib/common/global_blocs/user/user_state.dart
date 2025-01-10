

import 'package:equatable/equatable.dart';
import 'package:flutter_rfid/data/models/entities/user_entity.dart';

class UserState extends Equatable {
  final UserEntity? user;

  const UserState({this.user});

  // initial state
  factory UserState.initial() => const UserState(user: null);

  UserState copyWith({UserEntity? user}) {
    return UserState(user: user ?? this.user);
  }

  @override
  List<Object?> get props => [user];
}
