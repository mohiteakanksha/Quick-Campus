import 'package:flutter/material.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  double walletBalance = 0.0;
  final TextEditingController amountController = TextEditingController();

  // Function to handle adding funds
  void addAmount() {
    final enteredAmount = double.tryParse(amountController.text);
    if (enteredAmount != null && enteredAmount > 0) {
      setState(() {
        walletBalance += enteredAmount;
      });
      amountController.clear(); // Clear the text field after adding the amount
    } else {
      // Show error if entered amount is invalid
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Invalid Amount'),
            content: const Text('Please enter a valid amount greater than 0.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Display the wallet balance
            Text(
              'Wallet Balance: \$${walletBalance.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Text Field to input the amount to be added to the wallet
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Enter Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 20),

            // Button to add the entered amount to the wallet balance
            ElevatedButton(
              onPressed: addAmount,
              child: const Text('Add Amount'),
            ),
          ],
        ),
      ),
    );
  }
}
