import 'dart:io';
import 'package:commerce_project/const/assets_const.dart';
import 'package:commerce_project/utils/validation_utils.dart';
import 'package:commerce_project/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:commerce_project/api/database_helper.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _emailController = TextEditingController();
  String _profilePicture = ''; // Profile picture URL or path

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    // Retrieve user data from database
    Map<String, dynamic>? userData =
        await DatabaseHelper.instance.getLoggedInUser();
    if (userData != null) {
      setState(() {
        _emailController.text = userData[DatabaseHelper.columnEmail];
        _profilePicture = userData[DatabaseHelper.columnProfilePicture] ?? '';
        // _profilePicture = userData[DatabaseHelper.columnProfilePicture] ?? '';
      });
    }
  }

  void updateProfile() async {
    // Construct updated user data
    Map<String, dynamic> updatedUser = {
      DatabaseHelper.columnId:
          1, // Assuming user id is 1 (or retrieve from authentication)
      DatabaseHelper.columnEmail: _emailController.text,
      DatabaseHelper.columnProfilePicture: _profilePicture,
    };

    // Update user data in database
    await DatabaseHelper.instance.updateUser(updatedUser);

    // Show success message or navigate back
    Get.snackbar('Success', 'Profile updated successfully');
  }

  Future<void> _selectProfilePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profilePicture = pickedFile.path; // Use path for local storage
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () => _selectProfilePicture(),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: _profilePicture != null && _profilePicture.isNotEmpty
                      ? Image.file(
                          File(_profilePicture), // Display selected image
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          CommonImages.profile, // Default image asset
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CommonTextFormField(
              textInputAction: TextInputAction.done,
              validator: (value) =>
                  checkEmailAddressValidation(value: value!),
              controller: _emailController,
              hintText: "Enter Email",
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            CommonButton(onPressed: () => updateProfile(), buttonText: 'Update Profile')
          ],
        ),
      ),
    );
  }
}
