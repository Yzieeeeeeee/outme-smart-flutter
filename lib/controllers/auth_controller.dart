import 'package:get/get.dart';
import '../core/constants/app_routes.dart';
import '../core/services/storage_service.dart';
import '../data/repositories/auth_repository.dart';

enum AuthStatus { idle, loading, success, error }

class AuthController extends GetxController {
  final AuthRepository _authRepository;
  final StorageService _storageService;

  AuthController(this._authRepository, this._storageService);

  final Rx<AuthStatus> otpRequestStatus = AuthStatus.idle.obs;
  final Rx<AuthStatus> otpVerifyStatus = AuthStatus.idle.obs;
  final RxString errorMessage = ''.obs;

  String phoneNumber = '';

  Future<void> requestOtp(String phone) async {
    phoneNumber = phone;
    otpRequestStatus.value = AuthStatus.loading;
    try {
      await _authRepository.requestOtp(phone);
      otpRequestStatus.value = AuthStatus.success;
      Get.toNamed(AppRoutes.verifyOtp);
    } catch (e) {
      errorMessage.value = e.toString();
      otpRequestStatus.value = AuthStatus.error;
    }
  }

  Future<void> verifyOtp(String code) async {
    otpVerifyStatus.value = AuthStatus.loading;
    try {
      final result = await _authRepository.verifyOtp(
        phone: phoneNumber,
        code: code,
      );
      await _storageService.saveTokens(
        accessToken: result.accessToken,
        refreshToken: result.refreshToken,
      );
      otpVerifyStatus.value = AuthStatus.success;
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      errorMessage.value = e.toString();
      otpVerifyStatus.value = AuthStatus.error;
    }
  }

  Future<void> logout() async {
    await _storageService.clearTokens();
    Get.offAllNamed(AppRoutes.sendOtp);
  }
}