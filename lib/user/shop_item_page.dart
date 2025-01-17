import 'package:flutter/material.dart';
import 'package:quickcampus/user/cart_page.dart';
import 'package:quickcampus/user/user_dashboard.dart';
import 'package:quickcampus/user/user_profile_page.dart';

class ShopItemsPage extends StatefulWidget {
  final String shopName;

  const ShopItemsPage({required this.shopName, super.key});

  @override
  _ShopItemsPageState createState() => _ShopItemsPageState();
}

class _ShopItemsPageState extends State<ShopItemsPage> {
  final List<Map<String, dynamic>> items = [
    {"name": "Item 1", "price": "₹50", "quantity": 0},
    {"name": "Item 2", "price": "₹100", "quantity": 0},
    {"name": "Item 3", "price": "₹30", "quantity": 0},
    {"name": "Item 4", "price": "₹75", "quantity": 0},
  ];

  final List<Map<String, dynamic>> cart = [];

  void updateQuantity(int index, bool increment) {
    setState(() {
      if (increment) {
        items[index]["quantity"]++;
      } else if (items[index]["quantity"] > 0) {
        items[index]["quantity"]--;
      }
    });
  }

  void addToCart(int index) {
    if (items[index]["quantity"] > 0) {
      final itemInCart = cart.indexWhere(
        (element) => element["name"] == items[index]["name"],
      );
      if (itemInCart == -1) {
        cart.add({
          "name": items[index]["name"],
          "price": items[index]["price"],
          "quantity": items[index]["quantity"],
        });
      } else {
        cart[itemInCart]["quantity"] = items[index]["quantity"];
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${items[index]["name"]} added to the cart!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Set quantity for ${items[index]["name"]}.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.shopName,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
          // List of Items
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    leading: const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/quickcampus_logo.png'), // Placeholder
                    ),
                    title: Text(item["name"]!),
                    subtitle: Text("Price: ${item["price"]}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => updateQuantity(index, false),
                        ),
                        Text(
                          item["quantity"].toString(),
                          style: const TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => updateQuantity(index, true),
                        ),
                        ElevatedButton(
                          onPressed: () => addToCart(index),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                          ),
                          child: const Text("Cart"),
                        ),
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

