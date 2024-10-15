import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:wealthwise/Pages/LoginPage.dart';
import '../Components/Navigation/bottom_navigation.dart';
import '../Components/Navigation/top_navigation.dart';
import '../Components/Profile/profile_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'Connection.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  String? userId; // Variable to hold the user ID

  String username = '';
  String useremail = '';
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    _getUserInfo(); // Fetch the user ID when the page is loaded
  }

  // Method to get user ID from local storage
  Future<void> _getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId').toString(); // Properly get int and convert to string
    print('Logged in User ID: $userId'); // Print the user ID

    var url = Uri.parse('$baseUrl/api/UserInfo?user_id=$userId');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
      var data = jsonDecode(response.body);
      var firstName = data['payload']['user']['first_name'];
      var lastName = data['payload']['user']['last_name'];
      var email = data['payload']['user']['email'];
      profileImageUrl = data['payload']['user']['profile_image']; // Store image URL if exists
      var userFullName = '$firstName $lastName';

      print('User Full Name: $userFullName');
      print('User Email: $email');
      print('Profile Image URL: $profileImageUrl');

      setState(() {
        username = userFullName;
        useremail = email;
      });
    } else {
      print('Failed to fetch user data');
    }
  }

  // Method to pick image from gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    final XFile? selectedImage = await _picker.pickImage(source: source);
    if (selectedImage != null) {
      setState(() {
        _profileImage = File(selectedImage.path);
      });
      await _uploadImage(_profileImage!);
    }
  }

  // Method to upload image
  Future<void> _uploadImage(File imageFile) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId').toString(); // Get userId from SharedPreferences

    var url = Uri.parse('$baseUrl/api/uploadImage');

    // Create multipart request
    var request = http.MultipartRequest('POST', url);
    request.fields['user_id'] = userId;
    request.files.add(await http.MultipartFile.fromPath('profile_image', imageFile.path));

    // Send request
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded successfully');
    } else {
      print('Failed to upload image');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final double bodyWidth = width * 0.9;

    return SafeArea(
      child: Container(
        width: width,
        height: height,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            const TopNavigation(),
            SizedBox(
              width: width * 0.8,
              height: height * 0.15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      // Show a dialog or menu to pick either gallery or camera
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Wrap(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.photo_library),
                              title: const Text('Gallery'),
                              onTap: () {
                                _pickImage(ImageSource.gallery);
                                Navigator.pop(context); // Close the modal
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: const Text('Camera'),
                              onTap: () {
                                _pickImage(ImageSource.camera);
                                Navigator.pop(context); // Close the modal
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!) as ImageProvider
                          : (profileImageUrl != null
                          ? NetworkImage('$baseUrl/$profileImageUrl')
                          : null), // No fallback image if none exists
                      child: _profileImage == null && profileImageUrl == null
                          ? const Icon(Icons.person)
                          : null, // Show icon only if no image is available
                    ),

                  ),
                  SizedBox(
                    width: width * 0.5,
                    height: height * 0.08,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          username.isEmpty ? '...' : username,
                          style: TextStyle(
                            fontSize: 18,
                            decoration: TextDecoration.none,
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                        Text(
                          useremail.isEmpty ? '...' : useremail,
                          style: TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: width,
                  height: height * 0.76,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(50),
                        topLeft: Radius.circular(50)),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: double.maxFinite,
                      height: height * 0.69,
                      child: Column(
                        children: [
                          SizedBox(
                            width: bodyWidth,
                            height: height * 0.5,
                            child: Column(
                              children: [
                                ProfileCard(
                                  height: height * 0.06,
                                  icon: Icons.person_pin,
                                  settingName: 'Edit Profile',
                                  action: () {},
                                ),
                                ProfileCard(
                                  height: height * 0.06,
                                  icon: Icons.notifications_active,
                                  settingName: 'Notifications',
                                  action: () {},
                                ),
                                ProfileCard(
                                  height: height * 0.06,
                                  icon: Icons.headset_mic_sharp,
                                  settingName: 'Support',
                                  action: () {},
                                ),
                                ProfileCard(
                                  height: height * 0.06,
                                  icon: Icons.logout,
                                  settingName: 'Logout',
                                  action: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                        const LoginPage(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: BottomNavigation(
                                  height: height * 0.06,
                                  width: bodyWidth,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
