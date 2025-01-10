

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rfid/ui/page/general/general_state.dart';


class GeneralCubit extends Cubit<GeneralState> {
  late PageController pageController;
  GeneralCubit() : super(GeneralState.initial()) {
    pageController = PageController(initialPage: 0);
  }

  void changeCurrentIndex(int index) {
    pageController.jumpToPage(index);
    emit(state.copyWith(currentIndex: index));
  }
}
