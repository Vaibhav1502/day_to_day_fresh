import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../cart_screen/cart_screen.dart';

// Dummy data model for related products
class RelatedProduct {
  final String name;
  final String imagePath;
  RelatedProduct({required this.name, required this.imagePath});
}

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  final int _basePrice = 80;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<RelatedProduct> relatedProducts = [
      RelatedProduct(name: 'Orange', imagePath: 'assets/images/orange.png'),
      RelatedProduct(name: 'Watermelon', imagePath: 'assets/images/watermelon.png'),
      RelatedProduct(name: 'Pear', imagePath: 'assets/images/pear.png'),
      RelatedProduct(name: 'Grape', imagePath: 'assets/images/grapes.png'),
    ];

    final int totalPrice = _basePrice * _quantity;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // This Expanded contains the main content area (image + details)
          Expanded(
            child: Stack(
              children: [
                _buildImageSection(),
                // This is the new, non-scrollable details section
                _buildDetailsSection(relatedProducts),
              ],
            ),
          ),
          // This remains at the bottom
          _buildBottomBar(totalPrice),
        ],
      ),
    );
  }

  // --- WIDGET BUILDER METHODS ---

  Widget _buildImageSection() {
    return Container(
      // The image section takes up the top 45% of the screen
      height: MediaQuery.of(context).size.height * 0.40,
      color: const Color(0xFFFFF3C6), // Light yellow background
      child: SafeArea(
        bottom: false, // No need for bottom safe area here
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50), // Pushes image up a bit
                child: Image.asset(
                  'assets/images/banana.png', // Banana image URL
                  fit: BoxFit.contain,

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black87,size: 28,),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>MyCartScreen())),
              ),
              //const Icon(Icons.shopping_cart_outlined, color: Colors.black87, size: 28),
              Positioned(
                top: -4,
                right: -4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Text('0', style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // This widget replaces the DraggableScrollableSheet
  Widget _buildDetailsSection(List<RelatedProduct> relatedProducts) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        // The details section takes up 60% of the screen, creating an overlap
        height: MediaQuery.of(context).size.height * 0.55,
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
        ),
        // We use a Column instead of a ListView to prevent scrolling
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Quantity Selector
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Sweet Bananas', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  _buildQuantitySelector(),
                ],
              ),
              const SizedBox(height: 8),

              // Price
              Text('₹$_basePrice/kg', style: const TextStyle(fontSize: 18, color: Colors.orange, fontWeight: FontWeight.w600)),
              const SizedBox(height: 16), // Adjusted spacing

              // Description
              _buildDescription(),
              const SizedBox(height: 16), // Adjusted spacing

              // Spacer to push the related products to the bottom of the container
              const Spacer(),

              // Related Products Section
              _buildRelatedProducts(relatedProducts),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.amber)
      ),
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.remove, size: 18), onPressed: _decrementQuantity),
          Text('$_quantity', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          IconButton(icon: const Icon(Icons.add, size: 18, color: Colors.orange), onPressed: _incrementQuantity),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Naturally Ripe Bananas', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.5),
            children: <TextSpan>[
              const TextSpan(text: 'Enjoy the delicious taste of our fresh bananas perfectly ripe, naturally sweet, and packed with essential nutrients... '),
              TextSpan(
                text: 'Read More',
                style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRelatedProducts(List<RelatedProduct> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Fruits", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
            Text("See all", style: TextStyle(color: Colors.orange.shade700, fontSize: 14)),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(product.imagePath),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(product.name, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(int totalPrice) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Price', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                Text('₹$totalPrice', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 2,
              ),
              child: const Text('Add to Cart', style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}