import 'package:flutter/material.dart';
import 'package:quickcampus/deliveryperson/delivery_person_dashboard.dart';
import 'package:quickcampus/deliveryperson/edit_delivery_person_profile_page.dart';
import 'package:quickcampus/login_page.dart';
import 'wallet_page.dart';

class DeliveryPersonProfilePage extends StatelessWidget {
  const DeliveryPersonProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Profile Icon and User Info
          Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'John Doe', // Replace with delivery person name dynamically
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Delivery Person', // Replace with dynamic role info
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                // Menu Items
                ProfileMenuItem(
                  icon: Icons.shopping_bag,
                  text: 'My Orders',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrdersPage()),
                    );
                    // Navigate to My Orders Page
                  },
                ),
                ProfileMenuItem(
                  icon: Icons.edit,
                  text: 'Edit Profile',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditDeliveryPersonProfilePage()),
                    );
                    // Navigate to Edit Profile Page
                  },
                ),
                ProfileMenuItem(
                  icon: Icons.payment,
                  text: 'Wallet',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DeliveryPersonWalletPage()),
                    );
                    // Navigate to Wallet Page
                  },
                ),
                ProfileMenuItem(
                  icon: Icons.logout,
                  text: 'LogOut',
                  onTap: () {
                    // Handle logout logic, like clearing data or session
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Profile Tab
        onTap: (index) {
          // Handle Navigation Between Bottom Tabs (You can update navigation logic here)
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const ProfileMenuItem({
    required this.icon,
    required this.text,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: Colors.black),
      title: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DeliveryPersonProfilePage(),
  ));
}
