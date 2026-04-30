import 'package:pedal/domain/gifticon/entities/gifticon_entity.dart';

class GifticonResponse {
  final String id;
  final String category;
  final String brandName;
  final String name;
  final String? description;
  final int pricePoints;
  final String? imageUrl;
  final String? exchangePlace;
  final int validDays;
  final bool isActive;
  final DateTime createdAt;

  const GifticonResponse({
    required this.id,
    required this.category,
    required this.brandName,
    required this.name,
    this.description,
    required this.pricePoints,
    this.imageUrl,
    this.exchangePlace,
    required this.validDays,
    required this.isActive,
    required this.createdAt,
  });

  factory GifticonResponse.fromJson(Map<String, dynamic> json) =>
      GifticonResponse(
        id: json['id'] as String,
        category: json['category'] as String,
        brandName: json['brand_name'] as String,
        name: json['name'] as String,
        description: json['description'] as String?,
        pricePoints: json['price_points'] as int,
        imageUrl: json['image_url'] as String?,
        exchangePlace: json['exchange_place'] as String?,
        validDays: json['valid_days'] as int,
        isActive: json['is_active'] as bool,
        createdAt: DateTime.parse(json['created_at'] as String),
      );

  GifticonEntity toEntity() {
    final GifticonCategory cat;
    switch (category) {
      case 'korean':
        cat = GifticonCategory.korean;
        break;
      case 'chicken':
        cat = GifticonCategory.chicken;
        break;
      case 'pizza':
        cat = GifticonCategory.pizza;
        break;
      case 'snack':
        cat = GifticonCategory.snack;
        break;
      case 'dessert':
        cat = GifticonCategory.dessert;
        break;
      case 'cafe':
        cat = GifticonCategory.cafe;
        break;
      default:
        cat = GifticonCategory.convenience;
    }
    return GifticonEntity(
      id: id,
      category: cat,
      brandName: brandName,
      name: name,
      description: description,
      pricePoints: pricePoints,
      imageUrl: imageUrl,
      exchangePlace: exchangePlace,
      validDays: validDays,
      isActive: isActive,
      createdAt: createdAt,
    );
  }
}
