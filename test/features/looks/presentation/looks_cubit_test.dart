import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';
import 'package:looks_loop/features/looks/domain/entities/look_entity.dart';
import 'package:looks_loop/features/looks/domain/repositories/looks_repository.dart';
import 'package:looks_loop/features/looks/domain/usecases/get_look_detail_usecase.dart';
import 'package:looks_loop/features/looks/domain/usecases/get_looks_usecase.dart';
import 'package:looks_loop/features/looks/presentation/bloc/look_detail_cubit.dart';
import 'package:looks_loop/features/looks/presentation/bloc/look_detail_state.dart';
import 'package:looks_loop/features/looks/presentation/bloc/looks_cubit.dart';
import 'package:looks_loop/features/looks/presentation/bloc/looks_state.dart';

class FakeLooksRepository implements LooksRepository {
  ApiResult<List<LookSummaryEntity>>? looksResult;
  ApiResult<FeaturedLookEntity>? lookDetailResult;

  @override
  Future<ApiResult<List<LookSummaryEntity>>> getLooks() async {
    return looksResult!;
  }

  @override
  Future<ApiResult<FeaturedLookEntity>> getLookDetail(String slug) async {
    return lookDetailResult!;
  }
}

void main() {
  const dummyLookSummary = LookSummaryEntity(
    id: 1,
    slug: 'soft-tailoring',
    title: 'Soft Tailoring',
    description: 'Clean lines and ease.',
    image: 'https://example.com/look.jpg',
    isFeatured: true,
  );

  const dummyProduct = ProductEntity(
    id: '10',
    slug: 'blazer',
    name: 'Tailored Blazer',
    brand: 'MANGO',
    price: 3500.0,
    imageUrl: 'https://example.com/p.jpg',
  );

  const dummyLookDetail = FeaturedLookEntity(
    id: 1,
    slug: 'soft-tailoring',
    title: 'Soft Tailoring',
    description: 'Clean lines and ease.',
    imageUrl: 'https://example.com/look.jpg',
    hotspots: [
      LookHotspotEntity(x: 50.0, y: 30.0, product: dummyProduct),
    ],
  );

  group('LooksCubit', () {
    test('emits [LooksLoading, LooksLoaded] when getLooks succeeds', () async {
      final fakeRepo = FakeLooksRepository()
        ..looksResult = const ApiSuccess([dummyLookSummary]);
      final cubit = LooksCubit(GetLooksUseCase(fakeRepo));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const LooksLoading(),
          const LooksLoaded([dummyLookSummary]),
        ]),
      );

      await cubit.fetchLooks();
    });

    test('emits [LooksLoading, LooksError] when getLooks fails', () async {
      final fakeRepo = FakeLooksRepository()
        ..looksResult = const ApiFailure(ServerFailure('Server error'));
      final cubit = LooksCubit(GetLooksUseCase(fakeRepo));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const LooksLoading(),
          const LooksError('Server error'),
        ]),
      );

      await cubit.fetchLooks();
    });
  });

  group('LookDetailCubit', () {
    test('initWithLook immediately emits LookDetailLoaded', () {
      final fakeRepo = FakeLooksRepository();
      final cubit = LookDetailCubit(GetLookDetailUseCase(fakeRepo));

      cubit.initWithLook(dummyLookDetail);

      expect(cubit.state, const LookDetailLoaded(dummyLookDetail));
    });

    test('emits [LookDetailLoading, LookDetailLoaded] when fetchLookDetail succeeds',
        () async {
      final fakeRepo = FakeLooksRepository()
        ..lookDetailResult = const ApiSuccess(dummyLookDetail);
      final cubit = LookDetailCubit(GetLookDetailUseCase(fakeRepo));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const LookDetailLoading(),
          const LookDetailLoaded(dummyLookDetail),
        ]),
      );

      await cubit.fetchLookDetail('soft-tailoring');
    });

    test('emits [LookDetailLoading, LookDetailError] when fetchLookDetail fails',
        () async {
      final fakeRepo = FakeLooksRepository()
        ..lookDetailResult = const ApiFailure(ServerFailure('Look not found'));
      final cubit = LookDetailCubit(GetLookDetailUseCase(fakeRepo));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const LookDetailLoading(),
          const LookDetailError('Look not found'),
        ]),
      );

      await cubit.fetchLookDetail('soft-tailoring');
    });
  });
}
