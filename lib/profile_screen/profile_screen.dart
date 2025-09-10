import 'package:day_to_day_fresh/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildAppBar(context),
                const SizedBox(height: 30),
                _buildProfileHeader(),
                const SizedBox(height: 30),
                _buildMenuGroup1(),
                const SizedBox(height: 20),
                _buildMenuGroup2(),
                const SizedBox(height: 20),
                _buildMenuGroup3(),
                const SizedBox(height: 20),
                _buildMenuGroup4(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- WIDGET BUILDER METHODS ---

  Widget _buildAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildAppBarButton(
          icon: Icons.arrow_back,
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GroceryHomeScreen())),
        ),
        const Text(
          'Profile',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        _buildAppBarButton(
          icon: Icons.more_horiz,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildAppBarButton({required IconData icon, required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          )
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black87),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage("assets/images/day_2_day_fresh.png"),
          radius: 40,
          backgroundColor: Colors.grey,
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Day2DayFresh',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.red),
            ),
            const SizedBox(height: 4),
            Text(
              'Eat Healthy Stay Healthy',
              style: TextStyle(fontSize: 14, color: Colors.green),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMenuGroup1() {
    return _buildGroupContainer(
      children: [
        _ProfileMenuItem(
          icon: Icons.person_outline,
          text: 'Personal Info',
          iconColor: Colors.red.shade400,
        ),
        _buildDivider(),
        _ProfileMenuItem(
          icon: Icons.map_outlined,
          text: 'Addresses',
          iconColor: Colors.blue.shade400,
        ),
      ],
    );
  }

  Widget _buildMenuGroup2() {
    return _buildGroupContainer(
      children: [
        _ProfileMenuItem(
          icon: Icons.shopping_bag_outlined,
          text: 'Cart',
          iconColor: Colors.lightBlue.shade600,
        ),
        _buildDivider(),
        _ProfileMenuItem(
          icon: Icons.favorite_border,
          text: 'Favourite',
          iconColor: Colors.purple.shade300,
        ),
        _buildDivider(),
        _ProfileMenuItem(
          icon: Icons.notifications_none,
          text: 'Notifications',
          iconColor: Colors.orange.shade400,
        ),
        _buildDivider(),
        _ProfileMenuItem(
          icon: Icons.payment,
          text: 'Payment Method',
          iconColor: Colors.blue.shade700,
        ),
      ],
    );
  }

  Widget _buildMenuGroup3() {
    return _buildGroupContainer(
      children: [
        _ProfileMenuItem(
          icon: Icons.settings_outlined,
          text: 'Settings',
          iconColor: Colors.indigo.shade400,
        ),
      ],
    );
  }

  Widget _buildMenuGroup4() {
    return _buildGroupContainer(
      children: [
        _ProfileMenuItem(
          icon: Icons.logout,
          text: 'Log Out',
          iconColor: Colors.red.shade600,
        ),
      ],
    );
  }

  Widget _buildGroupContainer({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9F0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: children,
        ),
      ),
    );
  }

  Widget _buildDivider() => const Divider(height: 1, indent: 60, endIndent: 16);
}

// Reusable widget for each item in the profile list
class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;

  const _ProfileMenuItem({
    required this.icon,
    required this.text,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // TODO: Handle item tap
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    );
  }
}