import 'package:get/get.dart';
import '../core/network/api_client.dart';
import '../core/services/storage_service.dart';
import '../data/repositories/home_repository.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StorageService());
    Get.lazyPut(() => ApiClient(Get.find()));
    Get.lazyPut(() => HomeRepository(Get.find()));
    Get.lazyPut(() => HomeController(Get.find()));
  }
}