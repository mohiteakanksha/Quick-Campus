import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  final String orderId;
  final String customerName;
  final String address;
  final String paymentMethod;
  final List<String> items;

  const OrderPage({super.key,
    required this.orderId,
    required this.customerName,
    required this.address,
    required this.paymentMethod,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details - $orderId'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Details
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('From:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Name: $customerName'),
                    Text('Address: $address'),
                    Text('Payment: $paymentMethod'),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),
            
            // Order Items
            const Text('Order Items:', style: TextStyle(fontWeight: FontWeight.bold)),
            for (var item in items)
              Text('- $item'),
          ],
        ),
      ),
    );
  }
}
