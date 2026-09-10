import 'package:get/get.dart';
import '../core/network/api_client.dart';
import '../core/services/storage_service.dart';
import '../data/repositories/cart_repository.dart';
import '../controllers/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StorageService());
    Get.lazyPut(() => ApiClient(Get.find()));
    Get.lazyPut(() => CartRepository(Get.find()));
    Get.lazyPut(() => CartController(Get.find()));
  }
}