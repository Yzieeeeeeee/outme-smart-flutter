class CartItemModel {
  final String id;
  final String productId;
  final String name;
  final String? imageUrl;
  final double price;
  final int qty;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.name,
    this.imageUrl,
    required this.price,
    required this.qty,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id']?.toString() ?? '',
      productId: json['productId']?.toString() ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'],
      price: (json['price'] ?? 0).toDouble(),
      qty: json['qty'] ?? 1,
    );
  }
}

class CartSummaryModel {
  final double itemTotal;
  final double deliveryFee;
  final double platformFee;
  final double discount;
  final double totalPayable;

  CartSummaryModel({
    required this.itemTotal,
    required this.deliveryFee,
    required this.platformFee,
    required this.discount,
    required this.totalPayable,
  });

  factory CartSummaryModel.fromJson(Map<String, dynamic> json) {
    return CartSummaryModel(
      itemTotal: (json['itemTotal'] ?? 0).toDouble(),
      deliveryFee: (json['deliveryFee'] ?? 0).toDouble(),
      platformFee: (json['platformFee'] ?? 0).toDouble(),
      discount: (json['discount'] ?? 0).toDouble(),
      totalPayable: (json['totalPayable'] ?? 0).toDouble(),
    );
  }
}