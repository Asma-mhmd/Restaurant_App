class RecommendedItem {
  final int id;
  final String category;
  final String name;
  final String description;
  final String imagePath;
  final double price;

  RecommendedItem({
    required this.id,
    required this.category,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
  });
}

final List<RecommendedItem> recommendedItems = [
  RecommendedItem(
    id: 1,
    category: 'Naturales',
    name: 'Malteadas tropicales',
    description: 'Malteadas tropicales',
    imagePath: 'assets/images/juice.png',
    price: 12.58,
  ),
  RecommendedItem(
    id: 2,
    category: 'Naturales',
    name: 'Malteadas tropicales',
    description: 'Malteadas tropicales',
    imagePath: 'assets/images/juice2.png',
    price: 12.58,
  ),
  RecommendedItem(
    id: 3,
    category: 'Naturales',
    name: 'Malteadas tropicales',
    description: 'Malteadas tropicales',
    imagePath: 'assets/images/juice.png',
    price: 12.58,
  ),
];