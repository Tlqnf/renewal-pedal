enum GifticonCategory {
  korean,
  chicken,
  pizza,
  snack,
  dessert,
  cafe,
  convenience,
}

class GifticonEntity {
  final String id;
  final GifticonCategory category;
  final String brandName;
  final String name;
  final String? description;
  final int pricePoints;
  final String? imageUrl;
  final String? exchangePlace;
  final int validDays;
  final bool isActive;
  final DateTime createdAt;

  const GifticonEntity({
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
}
