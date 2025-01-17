import 'package:flutter/material.dart';
import 'package:quickcampus/shopkeeper/shopkeeper_profile.dart';
import 'add_item_page.dart';
import 'wallet_page.dart';
import 'food_page.dart';
import 'order_page.dart';  // Assume you have this profile page created

class ShopkeeperDashboard extends StatefulWidget {
  const ShopkeeperDashboard({super.key});

  @override
  _ShopkeeperDashboardState createState() => _ShopkeeperDashboardState();
}

class _ShopkeeperDashboardState extends State<ShopkeeperDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> orders = [
    {
      'orderId': '#ORD1234',
      'customerName': 'Customer 1',
      'orderDetails': 'Pizza, Burger, Fries',
      'totalAmount': 25.50,
      'status': 'New Order',
      'items': [
        {'name': 'Pizza', 'checked': false},
        {'name': 'Burger', 'checked': false},
        {'name': 'Fries', 'checked': false},
      ],
    },
    {
      'orderId': '#ORD1235',
      'customerName': 'Customer 2',
      'orderDetails': 'Pasta, Garlic Bread',
      'totalAmount': 18.75,
      'status': 'Preparing',
      'items': [
        {'name': 'Pasta', 'checked': false},
        {'name': 'Garlic Bread', 'checked': false},
      ],
    },
    // More sample orders can be added here
  ];

  // List of random delivery partners with names and contact numbers
  final List<Map<String, String>> deliveryPartners = [
    {'name': 'John Doe', 'contact': '(123) 456-7890'},
    {'name': 'Jane Smith', 'contact': '(987) 654-3210'},
    {'name': 'David Brown', 'contact': '(555) 123-4567'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopkeeper Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ShopkeeperProfilePage()),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'New Order'),
            Tab(text: 'Preparing'),
            Tab(text: 'Ready'),
            Tab(text: 'Picked'),
            Tab(text: 'Rejected'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            children: [
              _buildOrderListView('New Order'),
              _buildOrderListView('Preparing'),
              _buildOrderListView('Ready'),
              _buildOrderListView('Picked'),
              _buildOrderListView('Rejected'),
              _buildOrderListView('Completed'),
            ],
          ),
          // Add Item Button
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                // Navigate to Add Item Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddItemPage()),
                );
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderListView(String status) {
    final filteredOrders =
        orders.where((order) => order['status'] == status).toList();

    if (filteredOrders.isEmpty) {
      return Center(child: Text('No $status Orders'));
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: filteredOrders.length,
        itemBuilder: (context, index) {
          final order = filteredOrders[index];
          return _buildOrderCard(
            context,
            orderId: order['orderId'],
            customerName: order['customerName'],
            orderDetails: order['orderDetails'],
            totalAmount: order['totalAmount'],
            status: order['status'],
            items: order['items'],
            onReject: () => _moveOrderToRejected(order),
            onPrepare: () => _moveOrderToPreparing(order),
            onMarkReady: () => _moveOrderToReady(order),
            onMarkCompleted: () => _moveOrderToCompleted(order),
          );
        },
      ),
    );
  }

  Widget _buildOrderCard(
    BuildContext context, {
    required String orderId,
    required String customerName,
    required String orderDetails,
    required double totalAmount,
    required String status,
    required List items,
    required VoidCallback onReject,
    required VoidCallback onPrepare,
    required VoidCallback onMarkReady,
    required VoidCallback onMarkCompleted,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: $orderId', style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('Customer: $customerName'),
            Text('Items: $orderDetails'),
            Text('Total Amount: \$${totalAmount.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            Text(
              'Status: $status',
              style: TextStyle(color: _getOrderStatusColor(status), fontWeight: FontWeight.bold),
            ),
            if (status == 'New Order') ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => OrderPage(orderId: orderId, customerName: customerName, address: '', paymentMethod: '', items: const [], )),
                      );
                    },
                    child: const Text('View Details'),
                  ),
                  TextButton(
                    onPressed: () {
                      onPrepare();  // Move to Preparing Tab
                    },
                    child: const Text('Accept'),
                  ),
                  TextButton(
                    onPressed: onReject,
                    child: const Text('Reject'),
                  ),
                ],
              ),
            ],
            if (status == 'Preparing') ...[ 
              ...items.map((item) => Row(
                children: [
                  Checkbox(
                    value: item['checked'],
                    onChanged: (bool? newValue) {
                      setState(() {
                        item['checked'] = newValue!;
                      });
                    },
                  ),
                  Text(item['name']),
                ],
              )),
              ElevatedButton(
                onPressed: onMarkReady,
                child: const Text('Mark as Prepared'),  // Transition to Ready tab
              ),
            ],
            if (status == 'Ready') ...[
              // Display a random delivery partner
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Delivery Partner: ${_getRandomDeliveryPartner()['name']}'),
                      Text('Contact: ${_getRandomDeliveryPartner()['contact']}'),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _moveOrderToPicked(orderId);
                    },
                    child: const Text('Contact'),
                  ),
                ],
              ),
            ],
            if (status == 'Picked') ...[
              ElevatedButton(
                onPressed: onMarkCompleted,
                child: const Text('Mark as Completed'),  // Transition to Completed tab
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Function to handle order state transitions
  void _moveOrderToRejected(Map<String, dynamic> order) {
    setState(() {
      order['status'] = 'Rejected';
    });
    _tabController.index = 4;  // Navigate to Rejected Tab
  }

  void _moveOrderToPreparing(Map<String, dynamic> order) {
    setState(() {
      order['status'] = 'Preparing';
    });
    _tabController.index = 1;  // Navigate to Preparing Tab
  }

  void _moveOrderToReady(Map<String, dynamic> order) {
    setState(() {
      order['status'] = 'Ready';
    });
    _tabController.index = 2;  // Navigate to Ready Tab
  }

  void _moveOrderToPicked(String orderId) {
    setState(() {
      final order = orders.firstWhere((order) => order['orderId'] == orderId);
      order['status'] = 'Picked';
    });
    _tabController.index = 3;  // Navigate to Picked Tab
  }

  void _moveOrderToCompleted(Map<String, dynamic> order) {
    setState(() {
      order['status'] = 'Completed';
    });
    _tabController.index = 5;  // Navigate to Completed Tab
  }

  // Helper function to get color based on order status
  Color _getOrderStatusColor(String status) {
    switch (status) {
      case 'New Order':
        return Colors.green;
      case 'Preparing':
        return Colors.orange;
      case 'Ready':
        return Colors.blue;
      case 'Picked':
        return Colors.grey;
      case 'Rejected':
        return Colors.red;
      case 'Completed':
        return Colors.purple;
      default:
        return Colors.black;
    }
  }

  // Helper function to get random delivery partner details
  Map<String, String> _getRandomDeliveryPartner() {
    return (deliveryPartners..shuffle()).first;
  }
}
