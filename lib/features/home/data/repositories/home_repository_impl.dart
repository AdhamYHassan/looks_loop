import 'package:flutter/foundation.dart';
import 'package:looks_loop/core/cache/catalog_cache.dart';
import 'package:looks_loop/core/network/network_exceptions.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/data/datasources/home_local_data_source.dart';
import 'package:looks_loop/features/home/data/datasources/home_remote_data_source.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';
import 'package:looks_loop/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;
  final HomeLocalDataSource _localDataSource;
  final CatalogCache _catalogCache;

  const HomeRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._catalogCache,
  );

  @override
  Future<List<String>> getCachedAnnouncements() async {
    try {
      final cached = await _localDataSource.getCachedAnnouncements();
      return cached ?? const [];
    } catch (_) {
      return const [];
    }
  }

  @override
  Future<ApiResult<HomeFeedData>> getHomeFeed() async {
    try {
      final feedModel = await _remoteDataSource.getHomeFeed();
      _catalogCache.saveCategories(feedModel.categories);
      await _syncAnnouncementsIfChanged(feedModel.announcements);
      return ApiSuccess(feedModel);
    } catch (e) {
      return ApiFailure(NetworkExceptions.getFailure(e));
    }
  }

  Future<void> _syncAnnouncementsIfChanged(List<String> remote) async {
    if (remote.isEmpty) return;
    try {
      final cached = await _localDataSource.getCachedAnnouncements() ?? const [];
      if (!listEquals(cached, remote)) {
        await _localDataSource.cacheAnnouncements(remote);
      }
    } catch (_) {
      // Non-fatal: Local cache errors should not disrupt primary feed delivery
    }
  }
}

