import 'package:flutter/material.dart';
import 'package:quickcampus/user/cart_page.dart';
import 'user_profile_page.dart';
import 'shop_item_page.dart';

void main() => runApp(const MaterialApp(home: UserDashboard()));

class UserDashboard extends StatelessWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample list of shops
    final shops = [
      {"name": "STES Canteen"},
      {"name": "Kalyan Shop"},
      {"name": "Cafe"},
      {"name": "Cake Shop"},
      {"name": "Fruit Point"},
      {"name": "Laundry"},
      {"name": "Sinhgad Canteen"},
      {"name": "Parcel Pickup"},
      {"name": "Restaurant"},
      {"name": "Xerox"},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            // Implement drawer or menu if required
          },
        ),
        title: const Text(
          "QuickCampus",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black),
            onPressed: () {
              // Navigate to User Profile page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserProfilePage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          // Grid of Shops
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.0,
              ),
              itemCount: shops.length,
              itemBuilder: (context, index) {
                final shop = shops[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to Shop Details page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShopItemsPage(shopName: shop["name"]!),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Placeholder image for shop
                        const Expanded(
                          child: Image(
                            image: AssetImage('assets/quickcampus_logo.png'), // Replace with actual image
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Shop name
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            shop["name"]!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Set according to the current page index
        onTap: (index) {
          // Handle navigation based on index
          if (index == 0) {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserDashboard()),
              ); // Navigate to Dashboard
          } else if (index == 1) {
          Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              ); // Navigate to Cart Page
          } else if (index == 2) {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserProfilePage()),
              );// Navigate to Profile Page
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}
