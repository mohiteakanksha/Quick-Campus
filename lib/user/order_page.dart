import 'package:flutter/material.dart';

class Order {
  String name;
  double totalAmount;
  String status;

  Order({required this.name, required this.totalAmount, this.status = "Pending"});
}

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<Order> pendingOrders = [
    Order(name: "Order 1", totalAmount: 50.0),
    Order(name: "Order 2", totalAmount: 75.0),
  ];
  List<Order> preparingOrders = [];
  List<Order> readyOrders = [];
  List<Order> pickupOrders = [];
  List<Order> deliveredOrders = [];
  List<Order> rejectedOrders = [];
  List<Order> canceledOrders = [];

  void cancelOrder(Order order) {
    if (order.status == "Pending") {
      setState(() {
        order.status = "Canceled";
        canceledOrders.add(order);
        pendingOrders.remove(order);
      });
    }
  }

  void acceptOrder(Order order) {
    if (order.status == "Pending") {
      setState(() {
        order.status = "Preparing";
        preparingOrders.add(order);
        pendingOrders.remove(order);
      });
    }
  }

  void markOrderAsPrepared(Order order) {
    if (order.status == "Preparing") {
      setState(() {
        order.status = "Ready";
        readyOrders.add(order);
        preparingOrders.remove(order);
      });
    }
  }

  void markOrderAsPickedUp(Order order) {
    if (order.status == "Ready") {
      setState(() {
        order.status = "Pickup";
        pickupOrders.add(order);
        readyOrders.remove(order);
      });
    }
  }

  void markOrderAsDelivered(Order order) {
    if (order.status == "Pickup") {
      setState(() {
        order.status = "Delivered";
        deliveredOrders.add(order);
        pickupOrders.remove(order);
      });
    }
  }

  void rejectOrder(Order order) {
    if (order.status == "Pending") {
      setState(() {
        order.status = "Rejected";
        rejectedOrders.add(order);
        pendingOrders.remove(order);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Order Management"),
          bottom: const TabBar(
            isScrollable: true, // Prevent tab label overflow
            tabs: [
              Tab(text: "Pending"),
              Tab(text: "Preparing"),
              Tab(text: "Ready"),
              Tab(text: "Pickup"),
              Tab(text: "Delivered"),
              Tab(text: "Rejected"),
              Tab(text: "Canceled"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildOrdersList(pendingOrders, "Pending"),
            buildOrdersList(preparingOrders, "Preparing"),
            buildOrdersList(readyOrders, "Ready"),
            buildOrdersList(pickupOrders, "Pickup"),
            buildOrdersList(deliveredOrders, "Delivered"),
            buildOrdersList(rejectedOrders, "Rejected"),
            buildOrdersList(canceledOrders, "Canceled"),
          ],
        ),
      ),
    );
  }

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
              title: Text(order.name),
              subtitle: Text("Total: \$${order.totalAmount.toStringAsFixed(2)}"),
              trailing: getActionButton(order, status),
            ),
          );
        },
      ),
    );
  }

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
    } else if (status == "Preparing") {
      return IconButton(
        icon: const Icon(Icons.done),
        onPressed: () => markOrderAsPrepared(order),
      );
    } else if (status == "Ready") {
      return IconButton(
        icon: const Icon(Icons.local_shipping),
        onPressed: () => markOrderAsPickedUp(order),
      );
    } else if (status == "Pickup") {
      return IconButton(
        icon: const Icon(Icons.home),
        onPressed: () => markOrderAsDelivered(order),
      );
    } else if (status == "Rejected") {
      return const Icon(Icons.error_outline);
    } else {
      return const Icon(Icons.check_circle_outline);
    }
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: OrdersPage(),
  ));
}
