import '../../core/constants/api_constants.dart';
import '../../core/network/api_client.dart';
import '../models/auth_model.dart';

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  Future<void> requestOtp(String phone) async {
    await _apiClient.post(
      ApiConstants.requestOtp,
      body: {'phone': phone},
    );
  }

  Future<AuthResponseModel> verifyOtp({
    required String phone,
    required String code,
  }) async {
    final response = await _apiClient.post(
      ApiConstants.verifyOtp,
      body: {'phone': phone, 'code': code},
    );
    return AuthResponseModel.fromJson(response);
  }
}