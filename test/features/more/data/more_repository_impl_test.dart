import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/more/data/datasources/more_local_data_source.dart';
import 'package:looks_loop/features/more/data/repositories/more_repository_impl.dart';
import 'package:looks_loop/features/more/domain/entities/user_profile_entity.dart';

class FakeMoreLocalDataSource implements MoreLocalDataSource {
  final bool shouldThrow;

  const FakeMoreLocalDataSource({this.shouldThrow = false});

  @override
  Future<UserProfileEntity> getUserProfile() async {
    if (shouldThrow) {
      throw Exception('Database error');
    }
    return const UserProfileEntity.guest();
  }
}

void main() {
  test('MoreRepositoryImpl returns ApiSuccess when data source succeeds', () async {
    final repository = MoreRepositoryImpl(const FakeMoreLocalDataSource());
    final result = await repository.getUserProfile();

    expect(result, isA<ApiSuccess<UserProfileEntity>>());
    expect((result as ApiSuccess<UserProfileEntity>).data.isGuest, true);
  });

  test('MoreRepositoryImpl catches exception and returns ApiFailure', () async {
    final repository = MoreRepositoryImpl(const FakeMoreLocalDataSource(shouldThrow: true));
    final result = await repository.getUserProfile();

    expect(result, isA<ApiFailure<UserProfileEntity>>());
    final failure = (result as ApiFailure<UserProfileEntity>).failure;
    expect(failure, isA<UnknownFailure>());
    expect(failure.message, contains('Database error'));
  });
}
