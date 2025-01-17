import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quickcampus/deliveryperson/delivery_person_dashboard.dart'; // Delivery person dashboard page  
import 'package:quickcampus/login_page.dart';
import 'package:quickcampus/shopkeeper/shopkeeper_dashboard.dart'; // Shopkeeper dashboard page  
import 'package:quickcampus/user/user_dashboard.dart'; // User dashboard page

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}
  
class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController documentController = TextEditingController();
  final TextEditingController idCardController = TextEditingController();
  final TextEditingController profilePhotoController = TextEditingController();
  String dropdownValue = 'user';
  bool termsAccepted = false;
  XFile? profilePhoto;
  String? documentPath;

  Future<void> requestPermissions() async {
    await Permission.camera.request();
    await Permission.storage.request();
  }

  Future<void> pickProfilePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        profilePhoto = photo;
        profilePhotoController.text = photo.path;
      });
    }
  }

  Future<void> pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'doc', 'jpg']);
    if (result != null) {
      setState(() {
        documentPath = result.files.single.path;
        documentController.text = result.files.single.name;
      });
    }
  }

  Future<void> _signUp() async {
    if (!termsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You must accept terms and conditions!")),
      );
      return;
    }
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all the required details!")),
      );
      return;
    }

    if (dropdownValue == 'shopkeeper' &&
      (shopNameController.text.isEmpty || documentPath == null)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please fill in shop name and upload document!")),
    );
    return;
  }

  if (dropdownValue == 'delivery person' &&
      (idCardController.text.isEmpty || profilePhoto == null)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please upload ID card and profile photo!")),
    );
    return;
  }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'fullName': nameController.text.trim(),
        'email': emailController.text.trim(),
        'userType': dropdownValue,
        if (dropdownValue == 'shopkeeper') 'shopName': shopNameController.text.trim(),
        if (dropdownValue == 'shopkeeper') 'document': documentPath, // Document path
        if (dropdownValue == 'delivery person') 'idCard': idCardController.text.trim(), // Add ID card
        if (dropdownValue == 'delivery person') 'profilePhoto': profilePhoto?.path, // Profile photo path
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created successfully!")),
      );

      if (dropdownValue == 'user') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const UserDashboard()),
        );
      } else if (dropdownValue == 'shopkeeper') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ShopkeeperDashboard()),
        );
      } else if (dropdownValue == 'delivery person') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  OrdersPage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = "This email is already registered.";
          break;
        case 'weak-password':
          errorMessage = "Password must be at least 6 characters.";
          break;
        case 'invalid-email':
          errorMessage = "Invalid email format.";
          break;
        default:
          errorMessage = "An unexpected error occurred. Please try again.";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: ${e.toString()}")),
      );
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Sign Up",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Create Account",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  "Enter your name, email, password, and choose your account type to continue.",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "FULL NAME",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "EMAIL ADDRESS",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "PASSWORD",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "USER TYPE",
                    border: OutlineInputBorder(),
                  ),
                  value: dropdownValue,
                  items: <String>['user', 'shopkeeper', 'delivery person']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 10),
                if (dropdownValue == 'shopkeeper')
                  TextField(
                    controller: shopNameController,
                    decoration: const InputDecoration(
                      labelText: "SHOP NAME",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 10),

                if (dropdownValue == 'shopkeeper')
  Row(
    children: [
      Expanded(
        child: TextField(
          controller: TextEditingController(text: "ADD SHOP DOCUMENT"),
          decoration: const InputDecoration(
            hintText: "ADD SHOP DOCUMENT",
            border: OutlineInputBorder(),
          ),
          readOnly: true, // Prevent manual editing
        ),
      ),
      IconButton(
        onPressed: () async {
          // Call the gallery picker function
          await pickIdCardFromGallery();
        },
        icon: const Icon(Icons.photo_library),
      ),
    ],
  ),
                if (dropdownValue == 'delivery person')
  Row(
    children: [
      Expanded(
        child: TextField(
          controller: profilePhotoController, // Use the profile photo controller
          decoration: const InputDecoration(
            hintText: "TAKE PROFILE PHOTO",
            border: OutlineInputBorder(),
          ),
          readOnly: true, // Prevent manual editing
        ),
      ),
      IconButton(
        onPressed: pickProfilePhotoUsingCamera, // Call the function to open the camera
        icon: const Icon(Icons.camera_alt), // Camera icon
      ),
    ],
  ),
  const SizedBox(height: 10),

                if (dropdownValue == 'delivery person')
  Row(
    children: [
      Expanded(
        child: TextField(
          controller: TextEditingController(text: "ID CARD PHOTO"),
          decoration: const InputDecoration(
            hintText: "ID CARD PHOTO",
            border: OutlineInputBorder(),
          ),
          readOnly: true, // Prevent manual editing
        ),
      ),
      IconButton(
        onPressed: () async {
          // Call the gallery picker function
          await pickIdCardFromGallery();
        },
        icon: const Icon(Icons.photo_library),
      ),
    ],
  ),
  
                Row(
                  children: [
                    Checkbox(
                      value: termsAccepted,
                      onChanged: (value) {
                        setState(() {
                          termsAccepted = value!;
                        });
                      },
                    ),
                    const Text("Accept Terms & Conditions"),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _signUp,
                  
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8A5DEF),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    
                    ),
                  ),
                  child: const Text("Sign-Up",style: TextStyle(fontSize: 18, color: Colors.white),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickProfilePhotoUsingCamera() async {
  final ImagePicker picker = ImagePicker();
  final XFile? photo = await picker.pickImage(source: ImageSource.camera);
  if (photo != null) {
    setState(() {
      profilePhoto = photo;
      profilePhotoController.text = photo.path; // Update the text field
    });
  }
}


  
  Future<void> pickIdCardFromGallery() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    setState(() {
      idCardController.text = image.name; // Show image name in the text field
      documentPath = image.path; // Save the path for upload
    });
  }
}

}
