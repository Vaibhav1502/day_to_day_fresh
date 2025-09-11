import 'package:day_to_day_fresh/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../checkout_screen/checkout_screen.dart';

// Data model to represent an item in the cart
class CartItem {
  final String name;
  final String imagePath;
  final String unit;
  final int price; // Use int for easier calculations
  int quantity;

  CartItem({
    required this.name,
    required this.imagePath,
    required this.unit,
    required this.price,
    this.quantity = 1,
  });
}

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {

  // Dummy list of cart items
  final List<CartItem> _cartItems = [
    CartItem(name: 'Bananas', imagePath: 'assets/images/banana.png', unit: '1kg', price: 80),
    CartItem(name: 'Carrots', imagePath: 'assets/images/carrots.png', unit: '1kg', price: 70),
    CartItem(name: 'Apples', imagePath: 'assets/images/apples.png', unit: '1kg', price: 180),
    CartItem(name: 'Potatoes', imagePath: 'assets/images/potatoes.png', unit: '1kg', price: 40),
  ];

  final int _deliveryFee = 20;

  // --- LOGIC METHODS ---

  void _incrementQuantity(int index) {
    setState(() {
      _cartItems[index].quantity++;
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
  }

  int _calculateSubtotal() {
    int subtotal = 0;
    for (var item in _cartItems) {
      subtotal += item.price * item.quantity;
    }
    return subtotal;
  }

  @override
  Widget build(BuildContext context) {
    int subtotal = _calculateSubtotal();
    int total = subtotal + _deliveryFee;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildAppBar(context),
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: _cartItems.length,
                itemBuilder: (context, index) {
                  return _buildCartItemTile(_cartItems[index], index);
                },
              ),
            ),
          ),
          _buildPriceSummary(subtotal, _deliveryFee, total),
        ],
      ),
      bottomNavigationBar: _buildCheckoutButton(),
    );
  }

  // --- WIDGET BUILDER METHODS ---

  Widget _buildAppBar(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GroceryHomeScreen())),
            ),
            const Text('My Cart', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItemTile(CartItem item, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(item.imagePath, width: 60, height: 60),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(item.unit, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                Text('₹${item.price}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                onPressed: () => _removeItem(index),
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.only(bottom: 8),
              ),
              _buildQuantitySelector(item.quantity, index),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector(int quantity, int index) {
    return Row(
      children: [
        _buildQuantityButton(icon: Icons.remove, onPressed: () => _decrementQuantity(index), color: Colors.grey.shade300),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text('$quantity', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        _buildQuantityButton(icon: Icons.add, onPressed: () => _incrementQuantity(index), color: Colors.amber),
      ],
    );
  }

  Widget _buildQuantityButton({required IconData icon, required VoidCallback onPressed, required Color color}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16, color: icon == Icons.add ? Colors.white : Colors.black87),
      ),
    );
  }

  Widget _buildPriceSummary(int subtotal, int delivery, int total) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        children: [
          _buildPriceRow('Subtotal', '₹$subtotal'),
          const SizedBox(height: 10),
          _buildPriceRow('Delivery', '₹$delivery'),
          const Divider(height: 30),
          _buildPriceRow('Total', '₹$total', isTotal: true),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isTotal ? Colors.black : Colors.grey[600],
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isTotal ? Colors.black : Colors.grey[800],
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckoutScreen()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          child: const Text('Go to Checkout', style: TextStyle(fontSize: 18, color: Colors.white)),
        ),
      ),
    );
  }
}