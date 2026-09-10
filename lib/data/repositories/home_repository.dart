import '../../core/constants/api_constants.dart';
import '../../core/network/api_client.dart';
import '../models/store_category_model.dart';
import '../models/nearby_store_model.dart';
import '../models/trending_product_model.dart';

class HomeRepository {
  final ApiClient _apiClient;

  HomeRepository(this._apiClient);

  Future<List<StoreCategoryModel>> getStoreCategories({
    String? search,
  }) async {
    final uri = Uri.parse(ApiConstants.storeCategories).replace(
      queryParameters: {
        'page': '1',
        'limit': '20',
        if (search != null && search.isNotEmpty) 'search': search,
      },
    );

    final response = await _apiClient.get(uri.toString());

    final List data = response['data']['items'] ?? [];

    return data
        .map((e) => StoreCategoryModel.fromJson(e))
        .toList();
  }

  Future<List<NearbyStoreModel>> getNearbyStores() async {
    final uri = Uri.parse(ApiConstants.nearbyStores).replace(
      queryParameters: {
        'lat': '12.9716',
        'lng': '77.5946',
        'page': '1',
        'limit': '20',
      },
    );

    final response = await _apiClient.get(uri.toString());

    final List data = response['data']['items'] ?? [];

    return data
        .map((e) => NearbyStoreModel.fromJson(e))
        .toList();
  }

  Future<List<TrendingProductModel>> getTrendingProducts() async {
    final uri = Uri.parse(ApiConstants.trendingProducts).replace(
      queryParameters: {
        'page': '1',
        'limit': '20',
      },
    );

    final response = await _apiClient.get(uri.toString());
    final List data = response['data']['items'] ?? [];

    return data
        .map((e) => TrendingProductModel.fromJson(e))
        .toList();
  }
}