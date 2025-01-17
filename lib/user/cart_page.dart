import 'package:flutter/material.dart';
import 'package:quickcampus/user/review_order_page.dart';

class CartItem {
  String name;
  double price;
  int quantity;

  CartItem({required this.name, required this.price, required this.quantity});
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Sample list of cart items
  List<CartItem> cartItems = [
    CartItem(name: 'Burger', price: 5.99, quantity: 2),
    CartItem(name: 'Pizza', price: 8.49, quantity: 1),
    CartItem(name: 'Coke', price: 1.99, quantity: 3),
  ];

  // Method to calculate total price
  double getTotalPrice() {
    return cartItems.fold(0.0, (sum, item) => sum + item.price * item.quantity);
  }

  // Method to update item quantity
  void updateQuantity(int index, int change) {
    setState(() {
      cartItems[index].quantity += change;
      if (cartItems[index].quantity <= 0) {
        cartItems.removeAt(index); // Remove the item if quantity reaches zero
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Display list of cart items
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(item.name[0]),
                      ),
                      title: Text(item.name),
                      subtitle: Text('Price: \$${item.price.toStringAsFixed(2)}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => updateQuantity(index, -1),
                            icon: const Icon(Icons.remove),
                          ),
                          Text('${item.quantity}'),
                          IconButton(
                            onPressed: () => updateQuantity(index, 1),
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            // Total price section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: \$${getTotalPrice().toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the Review Order Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReviewOrderPage(),
                        ),
                      );
                    },
                    child: const Text('Place Your Order'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CartPage(),
  ));
}
