import 'package:flutter/material.dart';
import 'package:quickcampus/contact_us.dart';
import 'package:quickcampus/login_page.dart';
import 'package:quickcampus/user/Edit_profile_page.dart';
import 'package:quickcampus/user/wallet_page.dart';
import '../user/order_page.dart';


class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

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
                'User', // Replace with username dynamically
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'UserName', // Replace with dynamic email or ID
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
                  text: 'My Order',
                  onTap: () {
                    Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => OrdersPage()),
                            );
                    // Navigate to My Order Page
                  },
                ),
                ProfileMenuItem(
                  icon: Icons.edit,
                  text: 'Edit Profile',
                  onTap: () {
                    Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EditProfilePage()),
                            );
                    // Navigate to Edit Profile Page
                  },
                ),
                ProfileMenuItem(
                  icon: Icons.payment,
                  text: 'Wallet',
                  onTap: () {
                    Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => WalletPage()),
                            );
                    // Navigate to Payment Method Page
                  },
                ),
              
                ProfileMenuItem(
                  icon: Icons.contact_mail,
                  text: 'Contact Us',
                  onTap: () {
                    Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const QuickCampusContact()),
                            );
                    // Navigate to Contact Us Page
                  },
                ),
                ProfileMenuItem(
                  icon: Icons.logout,
                  text: 'LogOut',
                  onTap: () {Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginPage()),
                            );
                    // Handle Logout Logic
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
