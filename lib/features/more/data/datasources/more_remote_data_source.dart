import 'package:looks_loop/core/network/api_endpoints.dart';
import 'package:looks_loop/core/network/network_helper.dart';
import 'package:looks_loop/features/more/data/models/app_info_model.dart';
import 'package:looks_loop/features/more/data/models/contact_us_model.dart';
import 'package:looks_loop/features/more/data/models/update_user_profile_request_model.dart';
import 'package:looks_loop/features/more/data/models/user_profile_model.dart';

abstract interface class MoreRemoteDataSource {
  Future<UserProfileModel> getUserProfile();
  Future<UserProfileModel> updateUserProfile(UpdateUserProfileRequestModel request);
  Future<AppInfoModel> getAboutUs();
  Future<AppInfoModel> getPolicy();
  Future<ContactUsModel> getContactUs();
}

class MoreRemoteDataSourceImpl implements MoreRemoteDataSource {
  final NetworkHelper _networkHelper;

  const MoreRemoteDataSourceImpl(this._networkHelper);

  @override
  Future<UserProfileModel> getUserProfile() async {
    final response = await _networkHelper.get(ApiEndpoints.me);
    final responseData = response.data as Map<String, dynamic>;
    final data = responseData['data'] as Map<String, dynamic>;
    return UserProfileModel.fromJson(data);
  }

  @override
  Future<UserProfileModel> updateUserProfile(
    UpdateUserProfileRequestModel request,
  ) async {
    final response = await _networkHelper.patch(
      ApiEndpoints.me,
      data: request.toJson(),
    );
    final responseData = response.data as Map<String, dynamic>;
    final data = responseData['data'] as Map<String, dynamic>;
    return UserProfileModel.fromJson(data);
  }

  @override
  Future<AppInfoModel> getAboutUs() async {
    final response = await _networkHelper.get(ApiEndpoints.appAbout);
    final responseData = response.data as Map<String, dynamic>;
    final data = responseData['data'] as Map<String, dynamic>;
    return AppInfoModel.fromJson(data);
  }

  @override
  Future<AppInfoModel> getPolicy() async {
    final response = await _networkHelper.get(ApiEndpoints.appPolicy);
    final responseData = response.data as Map<String, dynamic>;
    final data = responseData['data'] as Map<String, dynamic>;
    return AppInfoModel.fromJson(data);
  }

  @override
  Future<ContactUsModel> getContactUs() async {
    final response = await _networkHelper.get(ApiEndpoints.appContactUs);
    final responseData = response.data as Map<String, dynamic>;
    final data = responseData['data'] as Map<String, dynamic>;
    return ContactUsModel.fromJson(data);
  }
}

