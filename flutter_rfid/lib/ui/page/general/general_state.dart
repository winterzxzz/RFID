

import 'package:equatable/equatable.dart';

class GeneralState extends Equatable {
  final int currentIndex; 

  const GeneralState({
    required this.currentIndex, 
  });

  // init state
  factory GeneralState.initial() => const GeneralState(currentIndex: 0);

  // copyWith
  GeneralState copyWith({
    int? currentIndex,
  }) {
    return GeneralState(currentIndex: currentIndex ?? this.currentIndex);
  }

  @override
  List<Object?> get props => [currentIndex];
}
