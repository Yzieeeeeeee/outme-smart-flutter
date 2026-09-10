import 'pricing_model.dart';

class TrendingProductModel {
  final String id;
  final String? offerId;
  final String? storeId;
  final String type;
  final String name;
  final String? imageUrl;
  final PricingModel pricing;
  final String? storeName;
  final bool inStock;
  final bool isFavorited;
  final int cartQuantity;

  TrendingProductModel({
    required this.id,
    this.offerId,
    this.storeId,
    required this.type,
    required this.name,
    this.imageUrl,
    required this.pricing,
    this.storeName,
    required this.inStock,
    required this.isFavorited,
    required this.cartQuantity,
  });

  factory TrendingProductModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return TrendingProductModel(
      id: json['id']?.toString() ?? '',

      offerId: json['offerId']?.toString(),

      storeId: json['storeId']?.toString(),

      type: json['type']?.toString() ?? '',

      name: json['name']?.toString() ?? '',

      imageUrl: json['imageUrl']?.toString(),

      pricing: PricingModel.fromJson(
        json['pricing'] is Map
            ? Map<String, dynamic>.from(
          json['pricing'] as Map,
        )
            : null,
      ),

      storeName: json['storeName']?.toString(),

      inStock: json['inStock'] == true,

      isFavorited: json['isFavorited'] == true,

      cartQuantity:
      int.tryParse(
        json['cartQuantity']?.toString() ?? '0',
      ) ??
          0,
    );
  }
}