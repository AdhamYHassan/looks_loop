import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/main/domain/entities/main_tab.dart';

class MainState extends Equatable {
  final MainTab currentTab;

  const MainState({
    this.currentTab = MainTab.home,
  });

  int get selectedIndex => currentTab.index;

  MainState copyWith({
    MainTab? currentTab,
  }) {
    return MainState(
      currentTab: currentTab ?? this.currentTab,
    );
  }

  @override
  List<Object?> get props => [currentTab];
}
