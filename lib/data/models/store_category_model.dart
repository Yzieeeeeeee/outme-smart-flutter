class StoreCategoryModel {
  final String id;
  final String name;
  final String slug;
  final String imageUrl;
  final bool requiresDrugLicense;

  StoreCategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.imageUrl,
    required this.requiresDrugLicense,
  });

  factory StoreCategoryModel.fromJson(Map<String, dynamic> json) {
    return StoreCategoryModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString() ?? '',
      requiresDrugLicense: json['requiresDrugLicense'] ?? false,
    );
  }
}