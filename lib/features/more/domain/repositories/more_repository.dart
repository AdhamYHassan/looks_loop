import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/more/domain/entities/app_info_entity.dart';
import 'package:looks_loop/features/more/domain/entities/contact_us_entity.dart';
import 'package:looks_loop/features/more/domain/entities/user_profile_entity.dart';

abstract interface class MoreRepository {
  Future<ApiResult<UserProfileEntity>> getUserProfile();
  Future<ApiResult<AppInfoEntity>> getAboutUs();
  Future<ApiResult<AppInfoEntity>> getPolicy();
  Future<ApiResult<ContactUsEntity>> getContactUs();
}
