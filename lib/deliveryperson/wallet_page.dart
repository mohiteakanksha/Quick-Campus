import 'package:flutter/material.dart';

class DeliveryPersonWalletPage extends StatefulWidget {
  const DeliveryPersonWalletPage({super.key});

  @override
  _DeliveryPersonWalletPageState createState() =>
      _DeliveryPersonWalletPageState();
}

class _DeliveryPersonWalletPageState extends State<DeliveryPersonWalletPage> {
  double walletBalance = 100.50;  // Sample wallet balance
  List<Transaction> transactionHistory = [
    Transaction(amount: 50.0, date: DateTime.now().subtract(const Duration(days: 1)), type: 'Deposit'),
    Transaction(amount: -10.0, date: DateTime.now().subtract(const Duration(days: 3)), type: 'Withdrawal'),
    Transaction(amount: 60.0, date: DateTime.now().subtract(const Duration(days: 5)), type: 'Deposit'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Wallet Balance
            const Text(
              'Wallet Balance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              '\$${walletBalance.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 28, color: Colors.green, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // Deposit & Withdraw Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement deposit logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(140, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Deposit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement withdraw logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    minimumSize: const Size(140, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Withdraw'),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Transaction History Header
            const Text(
              'Transaction History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Transaction History List
            Expanded(
              child: ListView.builder(
                itemCount: transactionHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      '\$${transactionHistory[index].amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: transactionHistory[index].type == 'Deposit'
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(transactionHistory[index].date.toLocal().toString()),
                    trailing: Text(
                      transactionHistory[index].type,
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Transaction {
  final double amount;
  final DateTime date;
  final String type;

  Transaction({required this.amount, required this.date, required this.type});
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DeliveryPersonWalletPage(),
  ));
}
