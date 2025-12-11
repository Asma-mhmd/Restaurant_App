import 'package:flutter/material.dart';
import 'package:nectar/utils/themes/app_colors.dart';

import '../../utils/services/favourites_manager.dart';



class DetailsContainer extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double radius = 40.0;
    path.moveTo(0, size.height);
    path.lineTo(0, 100);
    path.quadraticBezierTo(0, 60, radius, 60);
    path.lineTo(size.width * 0.4, 60);
    path.quadraticBezierTo(
      size.width * 0.9, 70,
      size.width, 0,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class ItemDetailsScreen extends StatefulWidget {
  final int id;
  final String category;
  final String name;
  final String description;
  final String imagePath;
  final double price;
  final Function(bool) onFavoriteChanged;

  const ItemDetailsScreen({
    Key? key,
    required this.id,
    required this.category,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.onFavoriteChanged,
  }) : super(key: key);

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  late bool isFav;

  final List<Map<String, String>> ingredients = [
    {'imagePath': 'assets/images/burgerr.png', 'name': 'Arrachera'},
    {'imagePath': 'assets/images/bread.png', 'name': 'Pan ajonjoli'},
    {'imagePath': 'assets/images/lechuga.png', 'name': 'Lechuga'},
    {'imagePath': 'assets/images/onions.png', 'name': 'Cebolla'},
    {'imagePath': 'assets/images/burgerr.png', 'name': 'Arrachera'},
  ];

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final favStatus = await FavoritesManager.isFavorite(widget.id, widget.category);
    if (mounted) {
      setState(() {
        isFav = favStatus;
      });
    }
  }

  Widget _buildDeleteButton() {
    return GestureDetector(
      onTap: () {
        print("Delete item tapped");
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.redAccent,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            )
          ],
        ),
        padding: EdgeInsets.all(12),
        child: Icon(
          Icons.delete_outline,
          color: Colors.white,
          size: 26,
        ),
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return GestureDetector(
      onTap: () async {
        await FavoritesManager.toggleFavorite(widget.id, widget.category);
        bool newValue = await FavoritesManager.isFavorite(widget.id, widget.category);

        setState(() {
          isFav = newValue;
        });

        widget.onFavoriteChanged(newValue);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isFav ? Colors.red : Colors.grey[400],
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            )
          ],
        ),
        padding: EdgeInsets.all(12),
        child: Icon(
          isFav ? Icons.favorite : Icons.favorite_border,
          color: Colors.white,
          size: 26,
        ),
      ),
    );
  }

  Widget _buildIngredientsList() {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: ingredients.length,
        separatorBuilder: (_, __) => SizedBox(width: 15),
        itemBuilder: (context, index) {
          final ingredient = ingredients[index];
          return SizedBox(
            width: 90.0,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    ingredient['imagePath'] ?? '',
                    width: 90.0,
                    height: 90.0,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 90.0,
                        height: 90.0,
                        color: Colors.grey[200],
                        child: Icon(Icons.broken_image, color: Colors.grey[400]),
                      );
                    },
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  ingredient['name'] ?? 'Componente',
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  Widget _buildTopBar() {
    return Positioned(
      top: 50,
      left: 20,
      right: 20,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
          Expanded(
            child: Text(
              widget.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4A148C), Color(0xFF26C6DA)],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              alignment: Alignment.center,
              child: Text(
                "Ordenar ahora",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(width: 20),
          Text(
            "\$${widget.price.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B3D6D),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double clipperTopPadding = 100.0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Image.asset('assets/images/burger_bg.png',
              fit: BoxFit.cover,
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: DetailsContainer(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.65,
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.only(
                  top: clipperTopPadding,
                  left: 25,
                  right: 25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Descripción",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B3D6D),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text("Lorem ipsum dolor sit amet, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero ",
                      style: TextStyle(color: AppColors.textPrimary, height: 1.5),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Ingredientes",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B3D6D),
                          ),
                        ),
                        Text("${ingredients.length} ingredientes", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    SizedBox(height: 15),
                    _buildIngredientsList(),
                    Container(
                      height: 1.0,
                      color: Colors.grey[200],
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                    ),

                    Spacer(),
                    _buildBottomAction(context),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            left: 25,
            bottom: 120,
            child: _buildDeleteButton(),
          ),

          Positioned(
            right: 50,
            top: MediaQuery.of(context).size.height * 0.35 + 15,
            child: _buildFavoriteButton(),
          ),

          _buildTopBar(),
        ],
      ),
    );
  }
}
