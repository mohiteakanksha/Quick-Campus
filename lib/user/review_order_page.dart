import 'package:flutter/material.dart';
import 'package:quickcampus/user/user_dashboard.dart'; // Assuming UserDashboard exists.

class CartItem {
  String name;
  double price;
  int quantity;

  CartItem({required this.name, required this.price, required this.quantity});
}

class ReviewOrderPage extends StatefulWidget {
  const ReviewOrderPage({super.key});

  @override
  _ReviewOrderPageState createState() => _ReviewOrderPageState();
}

class _ReviewOrderPageState extends State<ReviewOrderPage> {
  List<CartItem> cartItems = [
    CartItem(name: 'Burger', price: 5.99, quantity: 2),
    CartItem(name: 'Pizza', price: 8.49, quantity: 1),
    CartItem(name: 'Coke', price: 1.99, quantity: 3),
  ];

  final double deliveryFee = 3.00;
  final double taxRate = 0.08; // 8% tax
  String deliveryName = "John Doe";
  String deliveryAddress = "123 Main Street, Springfield";
  String selectedPaymentMethod = "Wallet"; // Default payment method
  final List<String> paymentMethods = ["Wallet", "Cash on Delivery"];
  double walletBalance = 100.00; // Example wallet balance, modify according to your logic

  double getSubtotal() {
    return cartItems.fold(0.0, (sum, item) => sum + item.price * item.quantity);
  }

  double getTax() {
    return getSubtotal() * taxRate;
  }

  double getTotal() {
    return getSubtotal() + getTax() + deliveryFee;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Display cart items
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
                      trailing: Text('Qty: ${item.quantity}'),
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            // Payment Method Section
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: const Text('Payment Method:'),
                subtitle: Text(selectedPaymentMethod),
                trailing: TextButton(
                  onPressed: () {
                    _showPaymentMethodSelector(context);
                  },
                  child: const Text(
                    'Change',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ),
            // Delivery Info Section
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text('Delivery To: $deliveryName'),
                subtitle: Text(deliveryAddress),
                trailing: TextButton(
                  onPressed: () async {
                    final updatedAddress = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeAddressPage(
                          currentName: deliveryName,
                          currentAddress: deliveryAddress,
                        ),
                      ),
                    );
                    if (updatedAddress != null) {
                      setState(() {
                        deliveryName = updatedAddress['name'];
                        deliveryAddress = updatedAddress['address'];
                      });
                    }
                  },
                  child: const Text(
                    'Change',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ),
            const Divider(),
            // Summary Section
            Column(
              children: [
                summaryRow('Subtotal', getSubtotal()),
                summaryRow('Delivery Fee', deliveryFee),
                summaryRow('Tax (8%)', getTax()),
                const Divider(),
                summaryRow('Total', getTotal(), isBold: true),
              ],
            ),
            const SizedBox(height: 20),
            // Confirm Button
            ElevatedButton(
              onPressed: () {
                if (selectedPaymentMethod == "Wallet" && walletBalance >= getTotal()) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Place Order'),
                      content: Text('Your total is \$${getTotal().toStringAsFixed(2)}'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              walletBalance -= getTotal(); // Deduct amount from wallet
                            });
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => OrderConfirmationSheet()),
                            );
                          },
                          child: const Text('Confirm'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                  );
                } else if (selectedPaymentMethod == "Wallet" && walletBalance < getTotal()) {
                  // Show message if wallet balance is not enough
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Insufficient Wallet Balance'),
                      content: const Text(
                        'Your wallet balance is not enough to place the order. Please choose a different payment method or add more funds to your wallet.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else {
                  // Proceed to place order for other payment methods (Card, COD)
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Place Order'),
                      content: Text('Your total is \$${getTotal().toStringAsFixed(2)}'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => OrderConfirmationSheet()),
                            );
                          },
                          child: const Text('Confirm'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }

  // Summary Row Widget
  Widget summaryRow(String title, double value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            '\$${value.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  // Payment Method Selector
  void _showPaymentMethodSelector(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Payment Method'),
          content: SingleChildScrollView(
            child: Column(
              children: paymentMethods
                  .map((method) => RadioListTile<String>(
                        title: Text(method),
                        value: method,
                        groupValue: selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            selectedPaymentMethod = value!;
                          });
                          Navigator.pop(context);
                        },
                      ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}

class OrderConfirmationSheet extends StatelessWidget {
  const OrderConfirmationSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.6,
      minChildSize: 0.4,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 5,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 16),
              const Icon(Icons.check_circle_outline, color: Colors.purple, size: 48),
              const SizedBox(height: 16),
              const Text(
                "Order Placed Successfully",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              const Text(
                "You placed the order successfully. You will get your food within 25 minutes. Thanks for using our service!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const UserDashboard()));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Keep browsing!")));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Keep Browsing"),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ChangeAddressPage extends StatelessWidget {
  final String currentName;
  final String currentAddress;

  ChangeAddressPage({super.key, required this.currentName, required this.currentAddress});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = currentName;
    addressController.text = currentAddress;

    return Scaffold(
      appBar: AppBar(title: const Text('Change Address')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
            const SizedBox(height: 16),
            TextField(controller: addressController, decoration: const InputDecoration(labelText: 'Address'), maxLines: 3),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {'name': nameController.text, 'address': addressController.text});
              },
              child: const Text('Save Address'),
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
    home: ReviewOrderPage(),
  ));
}
