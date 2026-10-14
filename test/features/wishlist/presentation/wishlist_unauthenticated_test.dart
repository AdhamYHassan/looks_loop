import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';
import 'package:looks_loop/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/add_to_wishlist_usecase.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/get_wishlist_usecase.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/remove_from_wishlist_usecase.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/watch_wishlist_usecase.dart';
import 'package:looks_loop/features/wishlist/presentation/bloc/wishlist_cubit.dart';
import 'package:looks_loop/features/wishlist/presentation/bloc/wishlist_state.dart';
import 'package:looks_loop/features/wishlist/presentation/widgets/wishlist_sign_in_button.dart';
import 'package:looks_loop/features/wishlist/presentation/widgets/wishlist_signed_out_chip.dart';
import 'package:looks_loop/features/wishlist/presentation/widgets/wishlist_signed_out_illustration.dart';
import 'package:looks_loop/features/wishlist/presentation/widgets/wishlist_signed_out_view.dart';

class _FakeWishlistRepo implements WishlistRepository {
  final ApiResult<List<ProductEntity>> result;
  _FakeWishlistRepo(this.result);

  @override
  Stream<List<ProductEntity>> get wishlistStream => const Stream.empty();
  @override
  Future<ApiResult<List<ProductEntity>>> getWishlist() async => result;
  @override
  Future<ApiResult<void>> addToWishlist(ProductEntity product) async =>
      const ApiSuccess(null);
  @override
  Future<ApiResult<void>> removeFromWishlist(String productId) async =>
      const ApiSuccess(null);
}

void main() {
  test(
      'WishlistCubit emits [WishlistLoading, WishlistUnauthenticated] on 401 error',
      () async {
    final repo = _FakeWishlistRepo(
      const ApiFailure(ServerFailure(
        'Authentication credentials were not provided.',
        statusCode: 401,
      )),
    );
    final cubit = WishlistCubit(
      GetWishlistUseCase(repo),
      AddToWishlistUseCase(repo),
      RemoveFromWishlistUseCase(repo),
      WatchWishlistUseCase(repo),
    );

    expectLater(
      cubit.stream,
      emitsInOrder([
        const WishlistLoading(),
        const WishlistUnauthenticated(
          message: 'Authentication credentials were not provided.',
        ),
      ]),
    );

    await cubit.fetchWishlist();
    cubit.close();
  });

  testWidgets('WishlistSignedOutView renders all components correctly',
      (tester) async {
    tester.view.physicalSize = const Size(375 * 3, 812 * 3);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    var retried = false;
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, _) => MaterialApp(
          home: Scaffold(
            body: WishlistSignedOutView(
              message: 'Authentication credentials were not provided.',
              onRetry: () async => retried = true,
            ),
          ),
        ),
      ),
    );

    expect(find.byType(WishlistSignedOutIllustration), findsOneWidget);
    expect(find.text("You're signed out"), findsOneWidget);
    expect(find.byType(WishlistSignInButton), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
    expect(find.byType(WishlistSignedOutChip), findsOneWidget);

    await tester.tap(find.text('Retry'));
    expect(retried, isTrue);
  });
}
