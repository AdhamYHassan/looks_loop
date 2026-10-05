import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/features/main/presentation/bloc/nav_bar_scroll_cubit.dart';
import 'package:looks_loop/features/main/presentation/bloc/nav_bar_scroll_state.dart';

void main() {
  group('NavBarScrollCubit', () {
    late NavBarScrollCubit cubit;

    setUp(() {
      cubit = NavBarScrollCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is NavBarScrollState with isScrolled false', () {
      expect(cubit.state, const NavBarScrollState(isScrolled: false));
    });

    test('does not emit when scroll offset is below threshold', () async {
      var emitted = false;
      final sub = cubit.stream.listen((_) => emitted = true);

      cubit.onScrollOffsetChanged(15.0);
      await Future.delayed(Duration.zero);

      expect(emitted, isFalse);
      expect(cubit.state.isScrolled, isFalse);
      await sub.cancel();
    });

    test('emits isScrolled true when scroll offset exceeds threshold', () {
      expectLater(
        cubit.stream,
        emitsInOrder([
          const NavBarScrollState(isScrolled: true),
        ]),
      );

      cubit.onScrollOffsetChanged(30.0);
    });

    test('does not emit redundant states when scrolling continuously above threshold', () async {
      var emitCount = 0;
      final sub = cubit.stream.listen((_) => emitCount++);

      cubit.onScrollOffsetChanged(30.0);
      cubit.onScrollOffsetChanged(60.0);
      cubit.onScrollOffsetChanged(120.0);
      await Future.delayed(Duration.zero);

      expect(emitCount, 1);
      expect(cubit.state.isScrolled, isTrue);
      await sub.cancel();
    });

    test('emits isScrolled false when scrolling back below threshold', () async {
      final expectedStates = [
        const NavBarScrollState(isScrolled: true),
        const NavBarScrollState(isScrolled: false),
      ];

      expectLater(cubit.stream, emitsInOrder(expectedStates));

      cubit.onScrollOffsetChanged(40.0);
      cubit.onScrollOffsetChanged(10.0);
    });

    test('reset() sets isScrolled to false if currently scrolled', () async {
      cubit.onScrollOffsetChanged(50.0);
      expect(cubit.state.isScrolled, isTrue);

      cubit.reset();
      expect(cubit.state.isScrolled, isFalse);
    });
  });
}
