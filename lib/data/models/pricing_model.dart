class PricingModel {
  final double mrp;
  final double price;
  final double discountPercent;
  final double savings;

  PricingModel({
    required this.mrp,
    required this.price,
    required this.discountPercent,
    required this.savings,
  });

  factory PricingModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return PricingModel(
        mrp: 0,
        price: 0,
        discountPercent: 0,
        savings: 0,
      );
    }

    double parseNumber(dynamic value) {
      return double.tryParse(value?.toString() ?? '') ?? 0;
    }

    return PricingModel(
      mrp: parseNumber(json['mrp']),
      price: parseNumber(json['price']),
      discountPercent: parseNumber(json['discountPercent']),
      savings: parseNumber(json['savings']),
    );
  }
}