import 'package:dio/dio.dart';
import 'package:looks_loop/core/network/network_exceptions.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/address/data/datasources/address_local_data_source.dart';
import 'package:looks_loop/features/address/data/datasources/address_remote_data_source.dart';
import 'package:looks_loop/features/address/data/models/add_address_request_model.dart';
import 'package:looks_loop/features/address/domain/entities/address_entity.dart';
import 'package:looks_loop/features/address/domain/entities/add_address_params.dart';
import 'package:looks_loop/features/address/domain/entities/province_entity.dart';
import 'package:looks_loop/features/address/domain/repositories/address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  final AddressRemoteDataSource _remoteDataSource;
  final AddressLocalDataSource _localDataSource;

  List<AddressEntity>? _memoryAddresses;
  List<ProvinceEntity>? _memoryProvinces;

  AddressRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  @override
  Future<ApiResult<List<AddressEntity>>> getAddresses() async {
    // 1. Fast path: return in-memory cache if already available in active session
    if (_memoryAddresses != null) {
      return ApiSuccess(_memoryAddresses!);
    }

    // 2. Offline Hive check
    final localCached = await _localDataSource.getCachedAddresses();
    if (localCached != null && localCached.isNotEmpty) {
      _memoryAddresses = localCached.map((m) => m.toEntity()).toList();
    }

    try {
      final models = await _remoteDataSource.getAddresses();
      await _localDataSource.cacheAddresses(models);
      final entities = models.map((m) => m.toEntity()).toList();
      _memoryAddresses = entities;
      return ApiSuccess(entities);
    } on DioException catch (e) {
      if (_memoryAddresses != null && _memoryAddresses!.isNotEmpty) {
        return ApiSuccess(_memoryAddresses!);
      }
      return ApiFailure(NetworkExceptions.getFailure(e));
    } catch (e) {
      if (_memoryAddresses != null && _memoryAddresses!.isNotEmpty) {
        return ApiSuccess(_memoryAddresses!);
      }
      return ApiFailure(NetworkExceptions.getFailure(e));
    }
  }

  @override
  Future<ApiResult<AddressEntity>> addAddress(AddAddressParams params) async {
    try {
      final request = AddAddressRequestModel.fromEntity(params);
      final model = await _remoteDataSource.addAddress(request);

      final entity = model.toEntity();
      _memoryAddresses = [entity, ...?_memoryAddresses];

      final currentCache = await _localDataSource.getCachedAddresses() ?? [];
      await _localDataSource.cacheAddresses([model, ...currentCache]);

      return ApiSuccess(entity);
    } on DioException catch (e) {
      return ApiFailure(NetworkExceptions.getFailure(e));
    } catch (e) {
      return ApiFailure(NetworkExceptions.getFailure(e));
    }
  }

  @override
  Future<ApiResult<List<ProvinceEntity>>> getProvinces({
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh && _memoryProvinces != null) {
      return ApiSuccess(_memoryProvinces!);
    }

    try {
      final models = await _remoteDataSource.getProvinces();
      await _localDataSource.cacheProvinces(models);
      final entities = models.map((m) => m.toEntity()).toList();
      _memoryProvinces = entities;
      return ApiSuccess(entities);
    } on DioException catch (e) {
      final cached = await _localDataSource.getCachedProvinces();
      if (cached != null && cached.isNotEmpty) {
        final entities = cached.map((m) => m.toEntity()).toList();
        _memoryProvinces = entities;
        return ApiSuccess(entities);
      }
      return ApiFailure(NetworkExceptions.getFailure(e));
    } catch (e) {
      final cached = await _localDataSource.getCachedProvinces();
      if (cached != null && cached.isNotEmpty) {
        final entities = cached.map((m) => m.toEntity()).toList();
        _memoryProvinces = entities;
        return ApiSuccess(entities);
      }
      return ApiFailure(NetworkExceptions.getFailure(e));
    }
  }
}
