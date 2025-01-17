import 'package:flutter/material.dart';
import 'package:quickcampus/deliveryperson/delivery_person_profile_page.dart';


class Order {
  String name;
  String userName;
  String address;
  String contactNo;
  String status;

  Order({
    required this.name,
    required this.userName,
    required this.address,
    required this.contactNo,
    this.status = "Pending",
  });
}

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<Order> pendingOrders = [
    Order(name: "Shop A", userName: "John Doe", address: "123 Street, City", contactNo: "9876543210"),
    Order(name: "Shop B", userName: "Jane Smith", address: "456 Avenue, Town", contactNo: "1234567890"),
  ];
  List<Order> pickupOrders = [];
  List<Order> deliveryOrders = [];
  List<Order> completedOrders = [];
  List<Order> rejectedOrders = [];

  // Transition Methods
  void cancelOrder(Order order) {
    if (order.status == "Pending") {
      setState(() {
        order.status = "Rejected";
        rejectedOrders.add(order);
        pendingOrders.remove(order);
      });
    }
  }

  void acceptOrder(Order order) {
    if (order.status == "Pending") {
      setState(() {
        order.status = "Pickup"; // Moving directly from Pending to Pickup
        pickupOrders.add(order);
        pendingOrders.remove(order);
      });
    }
  }

  void markOrderAsDelivered(Order order) {
    if (order.status == "Delivery") {
      setState(() {
        order.status = "Completed";
        completedOrders.add(order);
        deliveryOrders.remove(order);
      });
    }
  }

  void markOrderAsInDelivery(Order order) {
    if (order.status == "Pickup") {
      setState(() {
        order.status = "Delivery";
        deliveryOrders.add(order);
        pickupOrders.remove(order);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Order Management"),
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                // Navigate to DeliveryPersonProfilePage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DeliveryPersonProfilePage(),
                  ),
                );
              },
            ),
          ],
          bottom: const TabBar(
            isScrollable: true, // Prevent tab label overflow
            tabs: [
              Tab(text: "Pending"),
              Tab(text: "Pickup"),
              Tab(text: "Delivery"),
              Tab(text: "Completed"),
              Tab(text: "Rejected"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildOrdersList(pendingOrders, "Pending"),
            buildOrdersList(pickupOrders, "Pickup"),
            buildOrdersList(deliveryOrders, "Delivery"),
            buildOrdersList(completedOrders, "Completed"),
            buildOrdersList(rejectedOrders, "Rejected"),
          ],
        ),
      ),
    );
  }

  // Method to build orders list
  Widget buildOrdersList(List<Order> orders, String status) {
    return SingleChildScrollView(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(), // Allow SingleChildScrollView to scroll
        shrinkWrap: true, // Prevents layout overflow
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            elevation: 3.0,
            child: ListTile(
              title: Text("Shop: ${order.name}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("User: ${order.userName}"),
                  Text("Address: ${order.address}"),
                  Text("Contact No.: ${order.contactNo}"),
                ],
              ),
              trailing: getActionButton(order, status),
            ),
          );
        },
      ),
    );
  }

  // Get respective action buttons based on order status
  Widget getActionButton(Order order, String status) {
    if (status == "Pending") {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () => acceptOrder(order),
          ),
          IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () => cancelOrder(order),
          ),
        ],
      );
    } else if (status == "Pickup") {
      return IconButton(
        icon: const Icon(Icons.directions_car),
        onPressed: () => markOrderAsInDelivery(order),
      );
    } else if (status == "Delivery") {
      return IconButton(
        icon: const Icon(Icons.check_circle),
        onPressed: () => markOrderAsDelivered(order),
      );
    } else if (status == "Rejected") {
      return const Icon(Icons.error_outline); // Rejected orders won't have further actions
    } else {
      return const Icon(Icons.check_circle_outline); // Icon for completed orders
    }
  }
}

// Profile Page for the Delivery Person
