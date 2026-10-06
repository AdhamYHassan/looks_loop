import 'package:looks_loop/core/helpers/secure_storage_helper.dart';
import 'package:looks_loop/features/more/domain/entities/user_profile_entity.dart';

abstract interface class MoreLocalDataSource {
  Future<UserProfileEntity> getUserProfile();
}

class MoreLocalDataSourceImpl implements MoreLocalDataSource {
  const MoreLocalDataSourceImpl();

  @override
  Future<UserProfileEntity> getUserProfile() async {
    final token = await SecureStorageHelper.getToken();
    final name = await SecureStorageHelper.getUserName();
    final email = await SecureStorageHelper.getUserEmail();
    final phone = await SecureStorageHelper.getPhoneNumber();

    if (token != null && token.isNotEmpty && name != null && name.isNotEmpty) {
      return UserProfileEntity(
        name: name,
        isGuest: false,
        email: email,
        phone: phone,
      );
    }

    return const UserProfileEntity.guest();
  }
}
