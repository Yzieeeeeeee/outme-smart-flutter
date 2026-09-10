import 'package:get/get.dart';

import '../data/models/nearby_store_model.dart';
import '../data/models/store_category_model.dart';
import '../data/models/trending_product_model.dart';
import '../data/repositories/home_repository.dart';

enum LoadStatus {
  loading,
  success,
  error,
  empty,
}

class HomeController extends GetxController {
  final HomeRepository repository;

  HomeController(this.repository);

  // ============================================================
  // DATA
  // ============================================================

  final RxList<StoreCategoryModel> categories =
      <StoreCategoryModel>[].obs;

  final RxList<NearbyStoreModel> nearbyStores =
      <NearbyStoreModel>[].obs;

  final RxList<TrendingProductModel> trendingProducts =
      <TrendingProductModel>[].obs;

  // ============================================================
  // STATUS
  // ============================================================

  final Rx<LoadStatus> categoriesStatus =
      LoadStatus.loading.obs;

  final Rx<LoadStatus> nearbyStoresStatus =
      LoadStatus.loading.obs;

  final Rx<LoadStatus> trendingStatus =
      LoadStatus.loading.obs;

  // ============================================================
  // ERRORS
  // ============================================================

  final RxString categoriesError = ''.obs;
  final RxString nearbyStoresError = ''.obs;
  final RxString trendingError = ''.obs;

  // ============================================================
  // INITIAL LOAD
  // ============================================================

  @override
  void onInit() {
    super.onInit();
    fetchAllHomeData();
  }

  // ============================================================
  // FETCH ALL
  // ============================================================

  Future<void> fetchAllHomeData() async {
    await Future.wait<void>([
      fetchCategories(),
      fetchNearbyStores(),
      fetchTrendingProducts(),
    ]);
  }

  // ============================================================
  // CATEGORIES
  // ============================================================

  Future<void> fetchCategories() async {
    categoriesStatus.value = LoadStatus.loading;
    categoriesError.value = '';

    try {
      final result = await repository.getStoreCategories();

      if (result.isEmpty) {
        categoriesStatus.value = LoadStatus.empty;
      } else {
        categories.assignAll(result);
        categoriesStatus.value = LoadStatus.success;
      }
    } catch (e) {
      categoriesError.value = _errorMessage(e);

      // If we already have data, don't destroy the working UI.
      if (categories.isNotEmpty) {
        categoriesStatus.value = LoadStatus.success;
      } else {
        categoriesStatus.value = LoadStatus.error;
      }
    }
  }

  // ============================================================
  // CATEGORY SEARCH
  // ============================================================

  Future<void> searchCategories(String query) async {
    final search = query.trim();

    if (search.isEmpty) {
      await fetchCategories();
      return;
    }

    categoriesStatus.value = LoadStatus.loading;
    categoriesError.value = '';

    try {
      final result = await repository.getStoreCategories(
        search: search,
      );

      if (result.isEmpty) {
        categories.clear();
        categoriesStatus.value = LoadStatus.empty;
      } else {
        categories.assignAll(result);
        categoriesStatus.value = LoadStatus.success;
      }
    } catch (e) {
      categoriesError.value = _errorMessage(e);

      if (categories.isNotEmpty) {
        categoriesStatus.value = LoadStatus.success;
      } else {
        categoriesStatus.value = LoadStatus.error;
      }
    }
  }

  // ============================================================
  // NEARBY STORES
  // ============================================================

  Future<void> fetchNearbyStores() async {
    nearbyStoresStatus.value = LoadStatus.loading;
    nearbyStoresError.value = '';

    try {
      final result = await repository.getNearbyStores();

      if (result.isEmpty) {
        nearbyStoresStatus.value = LoadStatus.empty;
      } else {
        nearbyStores.assignAll(result);
        nearbyStoresStatus.value = LoadStatus.success;
      }
    } catch (e) {
      nearbyStoresError.value = _errorMessage(e);

      if (nearbyStores.isNotEmpty) {
        nearbyStoresStatus.value = LoadStatus.success;
      } else {
        nearbyStoresStatus.value = LoadStatus.error;
      }
    }
  }

  // ============================================================
  // TRENDING PRODUCTS
  // ============================================================

  Future<void> fetchTrendingProducts() async {
    trendingStatus.value = LoadStatus.loading;
    trendingError.value = '';

    try {
      final result = await repository.getTrendingProducts();

      if (result.isEmpty) {
        trendingStatus.value = LoadStatus.empty;
      } else {
        trendingProducts.assignAll(result);
        trendingStatus.value = LoadStatus.success;
      }
    } catch (e) {
      trendingError.value = _errorMessage(e);

      if (trendingProducts.isNotEmpty) {
        trendingStatus.value = LoadStatus.success;
      } else {
        trendingStatus.value = LoadStatus.error;
      }
    }
  }

  // ============================================================
  // ERROR
  // ============================================================

  String _errorMessage(Object error) {
    final message = error.toString();

    if (message.startsWith('Exception: ')) {
      return message.substring('Exception: '.length);
    }

    return message;
  }
}