import 'package:flutter/material.dart';

import '../home_screen/home_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, color: Colors.red[400], size: 28),
                  const SizedBox(width: 8),
                  const Text(
                    'Select your location, first',
                    style: TextStyle(
                      color: Color(0xFFFFB300),
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Let us find your location to serve you better.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),

              const Spacer(),

              Image.asset(
                "assets/images/location.png",
                fit: BoxFit.cover,
                height: 450,
              ),

              const Spacer(),

              OutlinedButton.icon(
                onPressed: () {
                  // TODO: Implement "use current location" functionality
                },
                icon: Icon(Icons.my_location, color: Colors.red[400]),
                label: Text(
                  'use my current location',
                  style: TextStyle(color: Colors.grey[800], fontSize: 16),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'or',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>GroceryHomeScreen()));
                  // TODO: Implement "enter location manually" functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF44336), // Solid red color
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0, // Flat design as in the image
                ),
                child: const Text(
                  'Enter location Manually',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
