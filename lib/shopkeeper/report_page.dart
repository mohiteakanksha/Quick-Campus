import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Annual Report'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Report Summary',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            const Text(
              'Year: 2025',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Total Sales Card
            const Card(
              elevation: 4,
              child: ListTile(
                title: Text('Total Sales'),
                trailing: Text('\$36,000'),
              ),
            ),
            const SizedBox(height: 15),

            // Order Count
            const Card(
              elevation: 4,
              child: ListTile(
                title: Text('Total Orders'),
                trailing: Text('1,000 Orders'),
              ),
            ),
            const SizedBox(height: 15),

            // Total Products Sold
            const Card(
              elevation: 4,
              child: ListTile(
                title: Text('Total Products Sold'),
                trailing: Text('4,500 Items'),
              ),
            ),
            const SizedBox(height: 20),

            // Report Breakdown Header
            const Text(
              'Report Breakdown:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Categories List
            SizedBox(
              height: 200,
              child: ListView(
                children: const [
                  ReportItem(
                    title: 'Electronics',
                    count: 1000,
                    percentage: 25,
                  ),
                  ReportItem(
                    title: 'Fashion',
                    count: 800,
                    percentage: 20,
                  ),
                  ReportItem(
                    title: 'Groceries',
                    count: 700,
                    percentage: 17.5,
                  ),
                  ReportItem(
                    title: 'Home Appliances',
                    count: 600,
                    percentage: 15,
                  ),
                  ReportItem(
                    title: 'Books',
                    count: 400,
                    percentage: 10,
                  ),
                  ReportItem(
                    title: 'Toys',
                    count: 200,
                    percentage: 5,
                  ),
                ],
              ),
            ),

            // Average Sales Details Section
            const SizedBox(height: 15),
            const Text(
              'Average Sales Per Category:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Card(
              elevation: 4,
              child: ListTile(
                title: Text('Electronics'),
                trailing: Text('\$20,000'),
              ),
            ),
            const SizedBox(height: 15),
            const Card(
              elevation: 4,
              child: ListTile(
                title: Text('Fashion'),
                trailing: Text('\$15,000'),
              ),
            ),
            const SizedBox(height: 15),
            const Card(
              elevation: 4,
              child: ListTile(
                title: Text('Groceries'),
                trailing: Text('\$12,000'),
              ),
            ),
            const SizedBox(height: 15),

            // Final Notes Section
            const Text(
              'Final Notes:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'The report for 2025 indicates an overall growth in all categories, especially in electronics and fashion. Strategies to improve home appliance and book categories are being considered. Stay tuned for upcoming changes!',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportItem extends StatelessWidget {
  final String title;
  final int count;
  final double percentage;

  const ReportItem({
    required this.title,
    required this.count,
    required this.percentage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        title: Text(title),
        subtitle: Text('$count items - ${percentage.toStringAsFixed(2)}%'),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ReportPage(),
  ));
}
