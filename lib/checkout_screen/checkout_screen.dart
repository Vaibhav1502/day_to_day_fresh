import 'package:flutter/material.dart';

import '../order_confirmed_screen/order_confirmed_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedDeliveryTypeIndex = 0; // 0: Standard, 1: Express, 2: Schedule

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light grey background
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Order Summary'),
              _buildClickableCard(
                child: const Text('4 items'),
                onTap: () {},
              ),
              const SizedBox(height: 24),

              _buildSectionTitle('Delivery Address'),
              _buildAddressCard(),
              const SizedBox(height: 24),

              _buildSectionTitle('Delivery Type'),
              _buildDeliveryTypeSelector(),
              const SizedBox(height: 24),

              _buildSectionTitle('Payment Method'),
              _buildPaymentMethod(),
              const SizedBox(height: 24),

              _buildPriceSummary(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  // --- WIDGET BUILDER METHODS ---

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF5F5F5),
      elevation: 0.5,
      foregroundColor: Colors.black87,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Text('Checkout', style: TextStyle(fontWeight: FontWeight.bold)),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }

  Widget _buildClickableCard({required Widget child, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            child,
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade600),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Lorem Ipsum', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text('Apartment 15C', style: TextStyle(color: Colors.grey.shade700)),
                Text('350 West 2nd Street, Gandhinagar', style: TextStyle(color: Colors.grey.shade700)),
                const SizedBox(height: 4),
                Text('+91 8955507192', style: TextStyle(color: Colors.grey.shade700)),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit_outlined, color: Colors.grey.shade600, size: 20),
            onPressed: () {},
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryTypeSelector() {
    return Row(
      children: [
        _buildDeliveryTypeOption(
          icon: Icons.local_shipping_outlined,
          title: 'Standard',
          subtitle: '1-2 days',
          index: 0,
        ),
        const SizedBox(width: 12),
        _buildDeliveryTypeOption(
          icon: Icons.flash_on_outlined,
          title: 'Express',
          subtitle: 'Same day',
          index: 1,
        ),
        const SizedBox(width: 12),
        _buildDeliveryTypeOption(
          icon: Icons.schedule_outlined,
          title: 'Schedule',
          subtitle: 'Choose time',
          index: 2,
        ),
      ],
    );
  }

  Widget _buildDeliveryTypeOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required int index,
  }) {
    bool isSelected = _selectedDeliveryTypeIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedDeliveryTypeIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? Colors.amber.shade600 : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(icon, color: Colors.black87),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethod() {
    return Column(
      children: [
        _buildClickableCard(
          child: Row(
            children: [
              Icon(Icons.credit_card, color: Colors.blue.shade800), // Placeholder for Visa icon
              const SizedBox(width: 12),
              const Text('•••• 5496'),
            ],
          ),
          onTap: () {},
        ),
        const SizedBox(height: 12),
        _buildClickableCard(
          child: Row(
            children: [
              Icon(Icons.account_balance_wallet_outlined, color: Colors.blue.shade600), // Placeholder
              const SizedBox(width: 12),
              const Text('pay from wallet'),
            ],
          ),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildPriceSummary() {
    return Column(
      children: [
        _buildPriceRow('Subtotal', '₹290'),
        const SizedBox(height: 12),
        _buildPriceRow('Delivery', '₹20'),
      ],
    );
  }

  Widget _buildPriceRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      color: const Color(0xFFF5F5F5),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
           Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderConfirmedScreen()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          child: const Text('Place Order', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}