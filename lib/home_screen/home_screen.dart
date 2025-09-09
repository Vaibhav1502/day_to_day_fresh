
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../product_detail_screen/product_detail_screen.dart';
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
      Category(name: 'Broccoli', imagePath: 'assets/images/broccoli.png'),
      Category(name: 'Cabbage', imagePath: 'assets/images/cabbage.png'),
      Category(name: 'Onion', imagePath: 'assets/images/onion.png'),
      Category(name: 'Peas', imagePath: 'assets/images/peas.png'),
      Category(name: 'Corn', imagePath: 'assets/images/corn.png'),
      Category(name: 'Tomatoe', imagePath: 'assets/images/tomatoe.png'),
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
                const Text('Gandhinagar, Gujarat.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: Color(0xFF407A47))),
              ],
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.wallet, size: 28,color: Colors.amber,),
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

class _PromoBanners extends StatefulWidget {
  final PageController pageController;
  const _PromoBanners({required this.pageController});

  @override
  State<_PromoBanners> createState() => _PromoBannersState();
}

class _PromoBannersState extends State<_PromoBanners> {
  // A list of our banner images
  final List<String> _bannerImages = [
    'assets/images/Banner1.png',
    'assets/images/ban.png',
    'assets/images/banner3.png',
  ];

  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // Start the timer when the widget is initialized
    _startTimer();
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is removed from the screen
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    // Create a periodic timer that fires every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < _bannerImages.length - 1) {
        _currentPage++;
      } else {
        // Loop back to the first page
        _currentPage = 0;
      }

      // Animate to the next page
      if (widget.pageController.hasClients) {
        widget.pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This helper widget creates a rounded image banner.
    Widget buildBannerImage(String imagePath) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            // Add an error builder for robustness
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Icon(Icons.image_not_supported, color: Colors.grey));
            },
          ),
        ),
      );
    }

    return SizedBox(
      height: 160,
      child: PageView(
        controller: widget.pageController,
        // Update the current page when the user swipes manually
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: _bannerImages.map((path) => buildBannerImage(path)).toList(),
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
        return GestureDetector(
          onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailScreen()));
          },
          child: Container(
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
        // We increase the overall height of the horizontal list significantly.
        // This height is now the main factor controlling the image size.
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              // We give each item a fixed width to control its size in the list.
              return SizedBox(
                width: 95,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Column(
                    children: [
                      // --- THIS IS THE KEY CHANGE ---
                      // Expanded makes its child (the Container) fill all available
                      // vertical space within the Column.
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8.0), // Reduced padding to maximize image area
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey.shade200, width: 1),
                          ),
                          child: Image.asset(
                            category.imagePath,
                            fit: BoxFit.cover,

                          ),
                        ),
                      ),
                      // -------------------------------
                      const SizedBox(height: 8),
                      Text(
                        category.name,
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
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