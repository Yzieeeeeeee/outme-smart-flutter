import '../../core/constants/api_constants.dart';
import '../../core/network/api_client.dart';
import '../models/cart_model.dart';

class CartRepository {
  final ApiClient _apiClient;
  CartRepository(this._apiClient);

  Future<List<dynamic>> getMyCarts() async {
    final response = await _apiClient.get(ApiConstants.cart, withAuth: true);
    return response['data'] ?? [];
  }

  Future<List<CartItemModel>> getStoreCart(String storeId) async {
    final response = await _apiClient.get(ApiConstants.cartbystore(storeId), withAuth: true);
    final List data = response['data'] ?? [];
    return data.map((e) => CartItemModel.fromJson(e)).toList();
  }

  Future<CartSummaryModel> getCartSummary(String storeId) async {
    final response = await _apiClient.get(ApiConstants.cartSummary(storeId), withAuth: true);
    return CartSummaryModel.fromJson(response['data'] ?? {});
  }

  Future<void> addCartItem({required String storeId, required String productId, required int qty}) async {
    await _apiClient.post(ApiConstants.cartItems, withAuth: true, body: {
      'storeId': storeId,
      'productId': productId,
      'productType': 'vendor_product',
      'qty': qty,
    });
  }
}