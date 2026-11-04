import 'package:looks_loop/core/helpers/secure_storage_helper.dart';
import 'package:looks_loop/features/more/domain/entities/user_profile_entity.dart';

abstract interface class MoreLocalDataSource {
  Future<String?> getToken();
  Future<void> saveUserProfile(UserProfileEntity profile);
  Future<UserProfileEntity> getUserProfile();
}

class MoreLocalDataSourceImpl implements MoreLocalDataSource {
  const MoreLocalDataSourceImpl();

  @override
  Future<String?> getToken() async {
    return await SecureStorageHelper.getToken();
  }

  @override
  Future<void> saveUserProfile(UserProfileEntity profile) async {
    await SecureStorageHelper.saveUserName(profile.name);
    if (profile.email != null) {
      await SecureStorageHelper.saveUserEmail(profile.email!);
    }
    if (profile.phone != null) {
      await SecureStorageHelper.savePhoneNumber(profile.phone!);
    }
  }

  @override
  Future<UserProfileEntity> getUserProfile() async {
    final token = await getToken();
    final name = await SecureStorageHelper.getUserName();
    final email = await SecureStorageHelper.getUserEmail();
    final phone = await SecureStorageHelper.getPhoneNumber();

    if (token != null && token.trim().isNotEmpty) {
      final displayName = (name != null && name.trim().isNotEmpty)
          ? name.trim()
          : (phone != null && phone.trim().isNotEmpty
              ? phone.trim()
              : 'User');

      return UserProfileEntity(
        name: displayName,
        isGuest: false,
        email: email,
        phone: phone,
      );
    }

    return const UserProfileEntity.guest();
  }
}
