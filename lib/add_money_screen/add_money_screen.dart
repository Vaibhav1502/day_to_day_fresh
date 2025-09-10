import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Converted to a StatefulWidget for proper controller management
class AddMoneyScreen extends StatefulWidget {
  const AddMoneyScreen({super.key});

  @override
  State<AddMoneyScreen> createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  // Controller is created here to be managed by the State
  late final TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: '1000');
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is removed to prevent memory leaks
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // This ensures the layout adapts gracefully when the keyboard is open
      resizeToAvoidBottomInset: true,
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.amber.shade400,
              Colors.amber.shade100,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        // FIX 1: Wrapped in a SingleChildScrollView to prevent overflow
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildAppBar(context),
              _buildIllustration(),
              const SizedBox(height: 30),
              _buildAmountInput(),
              // FIX 2: Replaced Spacer with a SizedBox for predictable spacing
              const SizedBox(height: 30),
              _buildNotesSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  // --- WIDGET BUILDER METHODS ---

  Widget _buildAppBar(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black87),
              onPressed: () => Navigator.of(context).pop(),
            ),
            const SizedBox(width: 16),
            const Text(
              'Add Money to your wallet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIllustration() {
    // UI ENHANCEMENT: Added a Stack to create the subtle shadow effect
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // The shadow container
        Container(
          height: 30,
          width: 200,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 10,
              ),
            ],
          ),
        ),
        // The main image
        Image.asset(
          "assets/images/wallet.png",
          height: 250,
        ),
      ],
    );
  }

  Widget _buildAmountInput() {
    return Column(
      children: [
        Text(
          'Enter Amount to add',
          style: TextStyle(color: Colors.grey[800], fontSize: 16),
        ),
        const SizedBox(height: 10),
        IntrinsicWidth(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    '₹',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 120,
                    child: TextField(
                      // FIX 3: Using the state-managed controller
                      controller: _amountController,
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      cursorColor: Colors.black87,
                      style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black87),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 8),
                      ),
                    ),
                  ),
                ],
              ),
              // UI ENHANCEMENT: Re-enabled the custom underline from the design
              // Container(
              //   height: 2,
              //   color: Colors.blue,
              // ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotesSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'NOTE :',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]),
          ),
          const SizedBox(height: 16),
          _buildNotePoint('Money balance is valid for 1 year from the date of money added.'),
          const SizedBox(height: 8),
          _buildNotePoint('Wallet Money is useable only on Day2Day Fresh.'),
          const SizedBox(height: 8),
          _buildNotePoint('Wallet Money cannot be transferred to a bank account as per RBI guidelines'),
        ],
      ),
    );
  }

  Widget _buildNotePoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('•  ', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: Colors.grey[600], fontSize: 14, height: 1.4),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
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
            Row(
              children: [
                Image.asset("assets/images/phonepe_logo.png", height: 24),
                const SizedBox(width: 8),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('PAY USING ▲', style: TextStyle(color: Colors.grey[600], fontSize: 10, fontWeight: FontWeight.bold)),
                    const Text('PhonePe UPI', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber.shade600,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 2,
              ),
              child: const Row(
                children: [
                  Text('PAY NOW', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, size: 16, color: Colors.black87),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}