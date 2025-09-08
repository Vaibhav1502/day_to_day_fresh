
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// Data Models
class Product {
  final String name;
  final String imagePath;
  final String price;
  final String unit;

  Product({
    required this.name,
    required this.imagePath,
    required this.price,
    required this.unit,
  });
}

class Category {
  final String name;
  final String imagePath;

  Category({required this.name, required this.imagePath});
}

class GroceryHomeScreen extends StatelessWidget {
  const GroceryHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    // Dummy Data
    final List<Product> products = [
      Product(name: 'Bananas', imagePath: 'assets/images/banana.png', price: '80', unit: '1kg'),
      Product(name: 'Carrots', imagePath: 'assets/images/carrots.png', price: '70', unit: '1kg'),
      Product(name: 'Apples', imagePath: 'assets/images/apples.png', price: '180', unit: '1kg'),
      Product(name: 'Potatoes', imagePath: 'assets/images/potatoes.png', price: '40', unit: '1kg'),
      Product(name: 'Cucumbers', imagePath: 'assets/images/cucumbers.png', price: '40', unit: '1kg'),
      Product(name: 'Lemons', imagePath: 'assets/images/lemons.png', price: '90', unit: '1kg'),
    ];

    final List<Category> fruitCategories = [
      Category(name: 'Orange', imagePath: 'assets/images/orange.png'),
      Category(name: 'Watermelon', imagePath: 'assets/images/watermelon.png'),
      Category(name: 'Pear', imagePath: 'assets/images/pear.png'),
      Category(name: 'Grape', imagePath: 'assets/images/grapes.png'),
      Category(name: 'Strawberry', imagePath: 'assets/images/strawberry.png'),
      Category(name: 'Peach', imagePath: 'assets/images/peach.png'),
    ];

    final List<Category> vegetableCategories = [
      Category(name: 'Broccoli', imagePath: 'https://i.imgur.com/N6wEpcS.png'),
      Category(name: 'Cabbage', imagePath: 'https://i.imgur.com/8Nf3bBq.png'),
      Category(name: 'Onion', imagePath: 'https://i.imgur.com/Y1pGjP5.png'),
      Category(name: 'Peas', imagePath: 'https://i.imgur.com/OAN9Q90.png'),
      Category(name: 'Corn', imagePath: 'https://i.imgur.com/c635F7m.png'),
      Category(name: 'Tomatoe', imagePath: 'https://i.imgur.com/Qk7xWDB.png'),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const _TopHeader(),
                    const SizedBox(height: 20),
                    const _SearchBar(),
                    const SizedBox(height: 20),
                    _PromoBanners(pageController: pageController),
                    const SizedBox(height: 10),
                    Center(
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
                        effect: const WormEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          activeDotColor: Colors.green,
                          dotColor: Colors.black12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const _CategoryTabs(),
                    const SizedBox(height: 20),
                    _ProductGrid(products: products),
                    const SizedBox(height: 20),
                    _CategorySection(title: 'Fruits', categories: fruitCategories),
                    const SizedBox(height: 20),
                    _CategorySection(title: 'Vegetables', categories: vegetableCategories),
                    const SizedBox(height: 100), // Space for floating nav bar
                  ],
                ),
              ),
            ),
          ),
          const _FloatingBottomNavBar(),
        ],
      ),
    );
  }
}

class _TopHeader extends StatelessWidget {
  const _TopHeader();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.location_on, color: Colors.amber, size: 28),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Your Location', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                const Text('Gandhinagar, Gujarat.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ],
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu, size: 28),
        ),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Find fruits & veggies...',
              hintStyle: TextStyle(color: Colors.grey[500]),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.filter_list, color: Colors.white),
        ),
      ],
    );
  }
}

class _PromoBanners extends StatelessWidget {
  final PageController pageController;
  const _PromoBanners({required this.pageController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: PageView(
        controller: pageController,
        children: [
          _buildPromoCard(
            gradientColors: [const Color(0xFF53E88B), const Color(0xFF15BE77)],
            title: 'Straight from\nthe garden',
            subtitle: 'Freshness Delivered',
            buttonText: 'Find Out',
            imagePath: 'assets/images/Banner1.png', // Basket
          ),
          _buildPromoCard(
            gradientColors: [Colors.yellow.shade600, Colors.orange.shade400],
            title: 'Straight to\nyour doorstep',
            subtitle: 'Skip the store',
            buttonText: 'Order Now',
            imagePath: 'https://i.imgur.com/W23EfPN.png', // Bag
          ),
          _buildPromoCard(
            gradientColors: [Colors.orange.shade400, Colors.deepOrange.shade300],
            title: 'Save now\nthank us later',
            subtitle: 'Up to 40% Offer',
            buttonText: 'Claim Offer',
            imagePath: 'https://i.imgur.com/978K9QW.png', // Box
          ),
        ],
      ),
    );
  }

  Widget _buildPromoCard({
    required List<Color> gradientColors,
    required String title,
    required String subtitle,
    required String buttonText,
    required String imagePath,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Image.asset(imagePath, height: 140),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                const SizedBox(height: 5),
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(buttonText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryTabs extends StatelessWidget {
  const _CategoryTabs();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildTab('Most Ordered', isSelected: true),
          _buildTab('In Season'),
          _buildTab('Vegetables'),
          _buildTab('Fruits'),
          _buildTab('Leafy Vegetables'),
        ],
      ),
    );
  }

  Widget _buildTab(String title, {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.orange : Colors.grey[600],
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 2,
              width: 30,
              color: Colors.orange,
            )
        ],
      ),
    );
  }
}

class _ProductGrid extends StatelessWidget {
  final List<Product> products;
  const _ProductGrid({required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(child: Image.asset(product.imagePath, fit: BoxFit.cover,height: 150,width: 150,)),
              ),
              const SizedBox(height: 10),
              Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(product.unit, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              //const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('₹${product.price}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  CircleAvatar(
                    backgroundColor: Colors.orange,
                    radius: 16,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: const Icon(Icons.add, color: Colors.white, size: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CategorySection extends StatelessWidget {
  final String title;
  final List<Category> categories;

  const _CategorySection({required this.title, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('See all', style: TextStyle(color: Colors.orange.shade700, fontSize: 14)),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:Image.asset(category.imagePath),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(category.name, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _FloatingBottomNavBar extends StatelessWidget {
  const _FloatingBottomNavBar();
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.all(20),
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 'Home', true),
            _buildNavItemWithBadge(Icons.shopping_cart, 'Cart', '0'),
            _buildNavItem(Icons.list_alt, 'Orders', false),
            _buildNavItem(Icons.person, 'Profile', false),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: isSelected ? Colors.orange : Colors.grey, size: 28),
        Text(label, style: TextStyle(color: isSelected ? Colors.orange : Colors.grey, fontSize: 10)),
      ],
    );
  }

  Widget _buildNavItemWithBadge(IconData icon, String label, String badgeCount) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _buildNavItem(icon, label, false),
        Positioned(
          top: 8,
          right: 12,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: Text(
              badgeCount,
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
        ),
      ],
    );
  }
}