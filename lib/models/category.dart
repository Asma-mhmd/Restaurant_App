import 'package:flutter/material.dart';

class Category {
  final String name;
  final String imagePath;

  Category({required this.name, required this.imagePath});
  static final List<Category> allCategories = [
    Category(name: 'Tacos', imagePath: 'assets/images/tacos.png'),
    Category(name: 'Frias', imagePath: 'assets/images/frias.png'),
    Category(name: 'Burger', imagePath: 'assets/images/burger.png'),
    Category(name: 'Pizza', imagePath: 'assets/images/pizza.png'),
    Category(name: 'Burritos', imagePath: 'assets/images/Burritos.png'),
    Category(name: 'Tacos', imagePath: 'assets/images/tacos.png'),
  ];
}