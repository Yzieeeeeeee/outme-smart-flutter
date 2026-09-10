// lib/routes/auth_binding.dart

import 'package:get/get.dart';
import '../core/network/api_client.dart';
import '../core/services/storage_service.dart';
import '../data/repositories/auth_repository.dart';
import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StorageService());
    Get.lazyPut(() => ApiClient(Get.find()));
    Get.lazyPut(() => AuthRepository(Get.find()));
    Get.lazyPut(() => AuthController(Get.find(), Get.find()));
  }
}