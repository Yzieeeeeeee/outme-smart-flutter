class NearbyStoreModel {
  final String id;
  final String name;
  final String? category;
  final double distanceKm;
  final String? logoUrl;
  final String? imageUrl;
  final double rating;
  final int ratingCount;
  final bool isOpen;
  final bool isFavorited;

  NearbyStoreModel({
    required this.id,
    required this.name,
    this.category,
    required this.distanceKm,
    this.logoUrl,
    this.imageUrl,
    required this.rating,
    required this.ratingCount,
    required this.isOpen,
    required this.isFavorited,
  });

  factory NearbyStoreModel.fromJson(Map<String, dynamic> json) {
    double parseNumber(dynamic value) {
      return double.tryParse(value?.toString() ?? '') ?? 0;
    }

    int parseInt(dynamic value) {
      return int.tryParse(value?.toString() ?? '') ?? 0;
    }

    return NearbyStoreModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      category: json['category']?.toString(),
      distanceKm: parseNumber(json['distanceKm']),
      logoUrl: json['logoUrl']?.toString(),
      imageUrl: json['imageUrl']?.toString(),
      rating: parseNumber(json['rating']),
      ratingCount: parseInt(json['ratingCount']),
      isOpen: json['isOpen'] == true,
      isFavorited: json['isFavorited'] == true,
    );
  }
}