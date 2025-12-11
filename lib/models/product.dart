class Product {
  final int id; 
  final String name;
  final String description;
  final String imagePath;
  final double price;

  Product({required this.id,required this.name, required this.description, required this.imagePath, required this.price});
}

final List<Product> products = [
  Product(name: 'Pizza Clásica', description: 'Salsa clásica de la casa', imagePath: 'assets/images/pizza_product.png', price: 12.58, id: 1),
  Product(name: 'Hamburguesa mix', description: 'Doble carne con queso', imagePath: 'assets/images/burger2.png', price: 12.58, id: 2),
  Product(name: 'Pizza Clásica', description: 'Salsa clásica de la casa', imagePath: 'assets/images/pizza_product.png', price: 12.58, id: 3),

];
