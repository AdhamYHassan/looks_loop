import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/features/main/presentation/bloc/nav_bar_scroll_state.dart';

class NavBarScrollCubit extends Cubit<NavBarScrollState> {
  NavBarScrollCubit() : super(const NavBarScrollState());

  /// Scroll distance threshold in logical pixels before morphing
  /// the bottom nav bar into the floating frosted glass capsule.
  static const double scrollThreshold = 25.0;

  void onScrollOffsetChanged(double pixels) {
    final shouldBeScrolled = pixels > scrollThreshold;
    if (shouldBeScrolled != state.isScrolled) {
      emit(state.copyWith(isScrolled: shouldBeScrolled));
    }
  }

  void reset() {
    if (state.isScrolled) {
      emit(const NavBarScrollState(isScrolled: false));
    }
  }
}
