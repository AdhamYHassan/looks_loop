import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/features/main/domain/entities/main_tab.dart';
import 'package:looks_loop/features/main/presentation/bloc/main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState());

  void changeTab(MainTab tab) {
    if (state.currentTab != tab) {
      emit(state.copyWith(currentTab: tab));
    }
  }

  void changeTabByIndex(int index) {
    final tab = MainTabX.fromIndex(index);
    changeTab(tab);
  }
}
