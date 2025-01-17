import 'package:flutter/material.dart';

class ShopDetailsPage extends StatefulWidget {
  const ShopDetailsPage({super.key});

  @override
  _ShopDetailsPageState createState() => _ShopDetailsPageState();
}

class _ShopDetailsPageState extends State<ShopDetailsPage> {
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  TimeOfDay openTime = const TimeOfDay(hour: 6, minute: 0);
  TimeOfDay closeTime = const TimeOfDay(hour: 6, minute: 0);

  Map<String, bool> days = {
    "Monday": true,
    "Tuesday": true,
    "Wednesday": true,
    "Thursday": true,
    "Friday": true,
    "Saturday": true,
    "Sunday": true,
  };

  Future<void> selectTime(BuildContext context, bool isOpening) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isOpening ? openTime : closeTime,
    );
    if (picked != null && picked != (isOpening ? openTime : closeTime)) {
      setState(() {
        if (isOpening) {
          openTime = picked;
        } else {
          closeTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QuickCampus"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Shop Details",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: shopNameController,
                decoration: const InputDecoration(
                  labelText: "Shop Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: "Address",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Restaurant Operational Time",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => selectTime(context, true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Open at: ${openTime.format(context)}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => selectTime(context, false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Close at: ${closeTime.format(context)}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Make Open Days",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...days.keys.map((day) {
                return CheckboxListTile(
                  title: Text(day),
                  value: days[day],
                  onChanged: (bool? value) {
                    setState(() {
                      days[day] = value ?? false;
                    });
                  },
                );
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add save functionality here
                  print("Shop Name: ${shopNameController.text}");
                  print("Address: ${addressController.text}");
                  print("Open at: ${openTime.format(context)}");
                  print("Close at: ${closeTime.format(context)}");
                  print("Open Days: ${days.entries.where((entry) => entry.value).map((entry) => entry.key).toList()}");
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.purple,
                ),
                child: const Text("SAVE"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ShopDetailsPage(),
  ));
}
