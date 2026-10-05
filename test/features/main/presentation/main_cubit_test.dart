import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/features/main/domain/entities/main_tab.dart';
import 'package:looks_loop/features/main/presentation/bloc/main_cubit.dart';
import 'package:looks_loop/features/main/presentation/bloc/main_state.dart';

void main() {
  group('MainCubit', () {
    late MainCubit mainCubit;

    setUp(() {
      mainCubit = MainCubit();
    });

    tearDown(() {
      mainCubit.close();
    });

    test('initial state is MainState with MainTab.home', () {
      expect(mainCubit.state, const MainState(currentTab: MainTab.home));
      expect(mainCubit.state.selectedIndex, 0);
    });

    test('emits MainState(currentTab: MainTab.shop) when changeTab is called with MainTab.shop', () {
      final expectedStates = [
        const MainState(currentTab: MainTab.shop),
      ];

      expectLater(mainCubit.stream, emitsInOrder(expectedStates));

      mainCubit.changeTab(MainTab.shop);
    });

    test('emits MainState(currentTab: MainTab.wishlist) when changeTabByIndex is called with index 3', () {
      final expectedStates = [
        const MainState(currentTab: MainTab.wishlist),
      ];

      expectLater(mainCubit.stream, emitsInOrder(expectedStates));

      mainCubit.changeTabByIndex(3);
    });

    test('does not emit new state when same tab is selected', () async {
      var emitted = false;
      final subscription = mainCubit.stream.listen((_) => emitted = true);

      mainCubit.changeTab(MainTab.home);
      await Future.delayed(Duration.zero);

      expect(emitted, isFalse);
      await subscription.cancel();
    });
  });
}
