import 'package:flutter/material.dart';
import 'package:quickcampus/contact_us.dart';
import 'package:quickcampus/login_page.dart';
import 'package:quickcampus/shopkeeper/food_page.dart'; // Sample order page // Sample reports page
import 'package:quickcampus/shopkeeper/edit_profile_page.dart';
import 'package:quickcampus/shopkeeper/report_page.dart';
import 'package:quickcampus/shopkeeper/shopkeeper_dashboard.dart';  // Sample edit profile page
import 'package:quickcampus/shopkeeper/shop_details_page.dart'; // Shop details page
import 'package:quickcampus/shopkeeper/wallet_page.dart'; // Wallet page
 // Contact us page

class ShopkeeperProfilePage extends StatelessWidget {
  const ShopkeeperProfilePage({super.key});

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
          'Shopkeeper Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Profile Icon and Shopkeeper Info
          Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: const Icon(
                  Icons.shop,
                  size: 50,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Shopkeeper', // Replace with shopkeeper's name dynamically
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'ShopName', // Replace with shopkeeper's shop name
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                // Menu Items for Shopkeeper
                ProfileMenuItem(
                  icon: Icons.shopping_bag,
                  text: 'Manage Orders',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShopkeeperDashboard()),
                    );
                  },
                ),
                ProfileMenuItem(
                  icon: Icons.add_shopping_cart,
                  text: 'Manage Products',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FoodPage()),
                    );
                  },
                ),
                ProfileMenuItem(
                  icon: Icons.bar_chart,
                  text: 'View Reports',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ReportPage()),
                    );
                  },
                ),
                ProfileMenuItem(
                  icon: Icons.shop,
                  text: 'Shop Details',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShopDetailsPage()), // Navigate to Shop Details Page
                    );
                  },
                ),
                ProfileMenuItem(
                  icon: Icons.payment,
                  text: 'Wallet',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShopkeeperWalletPage()), // Navigate to Wallet Page
                    );
                  },
                ),
                ProfileMenuItem(
                  icon: Icons.contact_mail,
                  text: 'Contact Us',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const QuickCampusContact()), // Navigate to Contact Us Page
                    );
                  },
                ),
                ProfileMenuItem(
                  icon: Icons.edit,
                  text: 'Edit Profile',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditProfilePage()),
                    );
                  },
                ),
                ProfileMenuItem(
                  icon: Icons.logout,
                  text: 'Logout',
                  onTap: () {
                    Navigator.push(
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
          // Handle Navigation Between Bottom Tabs
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
