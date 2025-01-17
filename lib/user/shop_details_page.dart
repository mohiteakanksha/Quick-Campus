import 'package:flutter/material.dart';
import 'package:quickcampus/user/shop_item_page.dart';

class ShopDetailPage extends StatelessWidget {
  final String shopName;

  const ShopDetailPage({required this.shopName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          shopName,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shop Banner Image
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/quickcampus_logo.png'), // Placeholder image
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(10),
          ),

          // Shop Name and Details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              shopName,
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              "Description: This shop provides a variety of food and services for Quick Campus users.",
              style: TextStyle(color: Colors.black54),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              "Contact: +91-9876543210",
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              "Opening Hours: 9:00 AM - 9:00 PM",
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
          ),

          const SizedBox(height: 20),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Navigate to shop's item listing page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShopItemsPage(shopName: shopName),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  backgroundColor: Colors.purple,
                ),
                child: const Text("View Items"),
              ),
              ElevatedButton(
                onPressed: () {
                  // Action for contacting shop
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Contacting Shop...')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  backgroundColor: Colors.blue,
                ),
                child: const Text("Contact Shop"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
