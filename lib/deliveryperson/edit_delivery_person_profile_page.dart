import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditDeliveryPersonProfilePage extends StatefulWidget {
  const EditDeliveryPersonProfilePage({super.key});

  @override
  _EditDeliveryPersonProfilePageState createState() =>
      _EditDeliveryPersonProfilePageState();
}

class _EditDeliveryPersonProfilePageState
    extends State<EditDeliveryPersonProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String profileImage =
      "https://via.placeholder.com/150"; // Default profile picture

  @override
  void initState() {
    super.initState();
    // Pre-fill with dummy data
    nameController.text = "John Doe";
    emailController.text = "johndoe@gmail.com";
    phoneController.text = "1234567890";
    addressController.text = "123 Main Street, Springfield";
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        profileImage = image.path; // Update profile image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: profileImage.startsWith('http')
                          ? NetworkImage(profileImage)
                          : FileImage(File(profileImage)) as ImageProvider,
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: InkWell(
                        onTap: _pickImage, // Open gallery on tap
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blueAccent,
                          child: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              buildTextField("Name", nameController),
              const SizedBox(height: 20),
              buildTextField("Email", emailController, keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 20),
              buildTextField("Phone Number", phoneController, keyboardType: TextInputType.phone),
              const SizedBox(height: 20),
              buildTextField("Address", addressController, maxLines: 3),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Save profile functionality
                  if (_validateInputs()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Profile Updated Successfully!")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Save Changes", style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: "Enter $label",
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  bool _validateInputs() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required!")),
      );
      return false;
    }
    return true;
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: EditDeliveryPersonProfilePage(),
  ));
}
