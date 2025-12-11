import 'package:flutter/material.dart';
import 'package:nectar/ui/widgets/custom_bottom_navigation_bar.dart';

import '../widgets/add_adress_button.dart';
import '../widgets/address_button.dart';
import '../widgets/cart_item_card.dart';
import '../widgets/custom_floating_action_bar.dart';

class CartItem {
  final String title;
  final String description;
  final double unitPrice;
  int quantity;
  final String imagePath;

  CartItem({
    required this.title,
    required this.description,
    required this.unitPrice,
    required this.quantity,
    required this.imagePath,
  });

  double get totalPrice => unitPrice * quantity;
}

class ShoppingCartScreen extends StatefulWidget {

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  List<CartItem> cartItems = [
    CartItem(
      title: 'Big Burger Queso',
      description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aranis, adique quae osus',
      unitPrice: 20.0,
      quantity: 2,
      imagePath: 'assets/burger1.png',
    ),
    CartItem(
      title: 'Big Burger',
      description:
      'Un clásico jugoso ',
      unitPrice: 18.0,
      quantity: 1,
      imagePath: 'assets/burger2.png',
    ),
  ];

  double get subtotalAmount {
    double subtotal = 0;
    for (var item in cartItems) {
      subtotal += item.totalPrice;
    }
    return subtotal;
  }

  void updateQuantity(int index, int change) {
    setState(() {
      int newQuantity = cartItems[index].quantity + change;
      if (newQuantity > 0) {
        cartItems[index].quantity = newQuantity;
      } else if (newQuantity == 0) {
        removeItem(index);
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  int _selectedIndex = 0;
  final double _fabSize = 60.0;
  final double _notchWidth = 80.0;
  final double _notchHeight = 80.0;
  final double _bottomBarHeight = 80.0;
  final double _notchCornerRadius = 65.0;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double shippingCost = 0.0;
    final double total = subtotalAmount + shippingCost;

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito',
            style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 100.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 10),
                  _buildAddressSection(),
                  SizedBox(height: 20),
                  Container(
                    height: screenHeight * 0.35,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: CartItemCard(
                            item: item,
                            onQuantityChanged: (change) => updateQuantity(index, change),
                            onRemove: () => removeItem(index),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  _buildSummarySection(total, shippingCost),
                  SizedBox(height: 20),
                  _buildCheckoutButton(total),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomNavigationBar(
              selectedIndex: _selectedIndex,
              onItemTapped: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              fabSize: _fabSize,
              notchWidth: _notchWidth,
              notchHeight: _notchHeight,
              bottomBarHeight: _bottomBarHeight,
              notchCornerRadius: _notchCornerRadius,
            ),
          ),
          Positioned(
            bottom: 10,
            left: (MediaQuery.of(context).size.width / 2) - (_fabSize / 2),
            child: CustomFloatingActionButton(
              onPressed: () {
                print('Floating Action Button Pressed!');
              },
              fabSize: _fabSize,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressSection() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: AddressButton(
            icon: Icons.home,
            label: 'Mi casa',
            description: 'Dirección de ejemplo',
            isSelected: true,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: AddressButton(
            icon: Icons.work,
            label: 'Mi Trabajo',
            description: 'Dirección de ejemplo',
            isSelected: false,
          ),
        ),
        SizedBox(width: 10),
        AddAddressButton(),
      ],
    );
  }

  Widget _buildSummarySection(double total, double shippingCost) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            _buildSummaryRow('SubTotal:', '\$${subtotalAmount.toStringAsFixed(2)} usd', isTotal: false),
            SizedBox(height: 8),
            _buildSummaryRow('Envio:', shippingCost == 0.0 ? 'Gratis' : '\$${shippingCost.toStringAsFixed(2)}', isTotal: false),
            Divider(height: 20, thickness: 1, color: Colors.grey[200]),
            _buildSummaryRow('Total:', '\$${total.toStringAsFixed(2)} usd', isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {required bool isTotal}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.deepPurple : Colors.black,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.deepPurple : Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton(double total) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [
            Colors.deepPurple.shade300,
            Colors.deepPurple.shade700,
            Colors.teal.shade400,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            print('Realizar compra clicked. Total: \$${total.toStringAsFixed(2)}');
          },
          borderRadius: BorderRadius.circular(15),
          child: const Center(
            child: Text(
              'Realizar compra',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}