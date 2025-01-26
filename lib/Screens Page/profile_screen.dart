import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:messenger_app/Helper/Dialouge.dart';
import 'package:messenger_app/Screens%20Page/Auth/login_screen.dart';
import 'package:messenger_app/api/apis.dart';
import 'package:messenger_app/model/user_chat.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _updatedName, _updatedAbout;
  String? _image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // Hide keyboard
      child: Scaffold(
        backgroundColor: const Color(0xFFE8F5E9),
        appBar: AppBar(
          title: const Text("Profile Screen"),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: FloatingActionButton.extended(
            backgroundColor: Colors.blueAccent,
            onPressed: () async {
              Dialouge.showProgressBar(context);
              await Apis.auth.signOut().then((value) async {
                await GoogleSignIn().signOut().then((value) {
                  Navigator.pop(context); // Hide progress dialog
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()));
                });
              });
            },
            icon: const Icon(Icons.logout_outlined),
            label: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * .03),
                  Stack(
                    children: [
                      _image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.height * .1),
                              child: Image.file(
                                File(_image!),
                                width: MediaQuery.of(context).size.height * .2,
                                height: MediaQuery.of(context).size.height * .2,
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.height * .1),
                              child: CachedNetworkImage(
                                width: MediaQuery.of(context).size.height * .2,
                                height: MediaQuery.of(context).size.height * .2,
                                fit: BoxFit.cover,
                                imageUrl: widget.user.image,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const CircleAvatar(
                                  child: Icon(Icons.person),
                                ),
                              ),
                            ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: MaterialButton(
                          elevation: 1,
                          color: Colors.white,
                          onPressed: () {
                            _showBottomSheet();
                          },
                          shape: const CircleBorder(),
                          child: const Icon(Icons.edit, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .03),
                  Text(
                    widget.user.email,
                    style: const TextStyle(color: Colors.black54, fontSize: 18),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  TextFormField(
                    initialValue: widget.user.name,
                    onSaved: (value) => _updatedName = value,
                    validator: (value) => value != null && value.isNotEmpty
                        ? null
                        : 'Name cannot be empty',
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person, color: Colors.blue),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Update Name',
                      labelText: 'Name',
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  TextFormField(
                    initialValue: widget.user.about,
                    onSaved: (value) => _updatedAbout = value,
                    validator: (value) => value != null && value.isNotEmpty
                        ? null
                        : 'About cannot be empty',
                    decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.info_outline, color: Colors.blue),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Feeling Happy',
                      labelText: 'About',
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Apis.updateUserInfo(
                                name: _updatedName, about: _updatedAbout)
                            .then((value) {
                          Dialouge.showSnackbar(
                              context, 'Profile updated successfully!');
                        });
                      }
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text("Update Profile",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width * 1,
                          MediaQuery.of(context).size.height * .06),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * .03,
            bottom: MediaQuery.of(context).size.height * .07,
          ),
          children: [
            Center(
              child: Text(
                "Pick your profile picture",
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * .3,
                      MediaQuery.of(context).size.height * .10,
                    ),
                  ),
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();

                    // Pick an image from the gallery
                    final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery, imageQuality: 80);
                    if (image != null) {
                      log('Image Path: ${image.path}');
                      setState(() {
                        _image = image.path;
                      });

                      try {
                        await Apis.updateProfilePic(File(_image!));
                        Dialouge.showSnackbar(
                            context, 'Profile picture updated successfully!');
                      } catch (e) {
                        Dialouge.showSnackbar(
                            context, 'Failed to update profile picture: $e');
                      }

                      // Close the bottom sheet
                      if (mounted) Navigator.pop(context);
                    }
                  },
                  child: Image.asset('images/add_image.png'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * .3,
                      MediaQuery.of(context).size.height * .10,
                    ),
                  ),
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();

                    // Pick an image from the gallery
                    final XFile? image = await picker.pickImage(
                        source: ImageSource.camera, imageQuality: 80);
                    if (image != null) {
                      log('Image Path: ${image.path}');
                      setState(() {
                        _image = image.path;
                      });

                      try {
                        await Apis.updateProfilePic(File(_image!));
                        Dialouge.showSnackbar(
                            context, 'Profile picture updated successfully!');
                      } catch (e) {
                        Dialouge.showSnackbar(
                            context, 'Failed to update profile picture: $e');
                      }

                      // Close the bottom sheet
                      if (mounted) Navigator.pop(context);
                    }
                  },
                  child: Image.asset('images/camera.png'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
