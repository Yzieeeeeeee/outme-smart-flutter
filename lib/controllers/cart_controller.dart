import 'package:get/get.dart';
import '../data/repositories/cart_repository.dart';
import '../data/models/cart_model.dart';

enum LoadStatus { loading, success, error, empty }

class CartController extends GetxController {
  final CartRepository _cartRepository;
  CartController(this._cartRepository);

  final Rx<LoadStatus> myCartsStatus = LoadStatus.loading.obs;
  final RxList<dynamic> myCarts = <dynamic>[].obs;

  final Rx<LoadStatus> cartDetailStatus = LoadStatus.loading.obs;
  final RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final Rx<CartSummaryModel?> summary = Rx<CartSummaryModel?>(null);

  Future<void> fetchMyCarts() async {
    myCartsStatus.value = LoadStatus.loading;
    try {
      final result = await _cartRepository.getMyCarts();
      myCarts.value = result;
      myCartsStatus.value = result.isEmpty ? LoadStatus.empty : LoadStatus.success;
    } catch (e) {
      myCartsStatus.value = LoadStatus.error;
    }
  }

  Future<void> fetchStoreCart(String storeId) async {
    cartDetailStatus.value = LoadStatus.loading;
    try {
      final items = await _cartRepository.getStoreCart(storeId);
      final summaryResult = await _cartRepository.getCartSummary(storeId);
      cartItems.value = items;
      summary.value = summaryResult;
      cartDetailStatus.value = items.isEmpty ? LoadStatus.empty : LoadStatus.success;
    } catch (e) {
      cartDetailStatus.value = LoadStatus.error;
    }
  }
}