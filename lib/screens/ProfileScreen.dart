import 'package:event/customwigdets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import '../customwigdets/ProfileFields.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  XFile? _profileImage;
  String? _profileImageUrl;
  final _firestore = FirebaseFirestore.instance;
  String? _userId;
  bool _isEditMode = false;
  Map<String, dynamic> _userData = {};

  String? _message;
  bool _showMessage = false;

  @override
  void initState() {
    super.initState();
    _fetchRandomUserProfile();
  }

  Future<void> _fetchRandomUserProfile() async {
    try {
      final snapshot = await _firestore.collection('users').get();
      if (snapshot.docs.isNotEmpty) {
        final randomUser = snapshot.docs.first;
        _userId = randomUser.id;
        _userData = randomUser.data();
        _profileImageUrl = _userData['profileImageUrl'];
        setState(() {});
      }
    } catch (error) {
      _setMessage('Error fetching user profile: $error');
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    _profileImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final data = _formKey.currentState!.value;

      String? profileImageUrl;
      if (_profileImage != null) {
        profileImageUrl = await _uploadImage(_profileImage!);
      } else {
        profileImageUrl = _profileImageUrl;
      }

      if (_userId != null) {
        await _firestore.collection('users').doc(_userId).update({
          'name': data['name'],
          'email': data['email'],
          'phone': data['phone'],
          'profileImageUrl': profileImageUrl,
        });

        setState(() {
          _isEditMode = false;
          _userData['name'] = data['name'];
          _userData['email'] = data['email'];
          _userData['phone'] = data['phone'];
          _profileImageUrl = profileImageUrl;
        });

        AnimatedSnackBar.material(
          'Profile Updated Successfully!',
          type: AnimatedSnackBarType.success,
        ).show(context);
      }
    } else {
      AnimatedSnackBar.material(
        'Please correct the errors in the form.',
        type: AnimatedSnackBarType.error,
      ).show(context);
    }
  }

  Future<String> _uploadImage(XFile image) async {
    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('profile_images/${image.name}');
      await storageRef.putFile(File(image.path));
      return await storageRef.getDownloadURL();
    } catch (e) {
      return '';
    }
  }

  void _setMessage(String message) {
    setState(() {
      _message = message;
      _showMessage = true;
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _showMessage = false;
      });
    });
  }

  Widget _buildProfileDisplay() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Profile',
            style: TextStyle(
              fontSize: 30.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 50.h),
          GestureDetector(
            onTap: _isEditMode ? _pickImage : null,
            child: CircleAvatar(
              radius: 70.r,
              backgroundImage: _profileImage != null
                  ? FileImage(File(_profileImage!.path))
                  : _profileImageUrl != null
                      ? NetworkImage(_profileImageUrl!)
                      : AssetImage('assets/images/b.png') as ImageProvider,
              child: _profileImage == null && _isEditMode
                  ? Icon(Icons.camera_alt, size: 40.sp, color: Colors.grey)
                  : null,
            ),
          ),
          SizedBox(height: 26.h),
          _isEditMode
              ? buildEditableTextField(
                  name: 'name',
                  labelText: 'Name',
                  initialValue: _userData['name'] ?? '',
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                )
              : buildProfileInfoRow('Display Name', _userData['name']),
          SizedBox(height: 16.h),
          _isEditMode
              ? buildEditableTextField(
                  name: 'email',
                  labelText: 'Email',
                  initialValue: _userData['email'] ?? '',
                  icon: Icons.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                )
              : buildProfileInfoRow('Email', _userData['email']),
          SizedBox(height: 16.h),
          _isEditMode
              ? buildEditableTextField(
                  name: 'phone',
                  labelText: 'Phone Number',
                  initialValue: _userData['phone'] ?? '',
                  icon: Icons.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'Please enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                )
              : buildProfileInfoRow('Phone Number', _userData['phone']),
          SizedBox(height: 24.h),
          _isEditMode
              ? mybutton(
                  color: Colors.purpleAccent,
                  fontSize: 16.sp,
                  ontap: _saveProfile,
                  btext: 'Save Changes',
                )
              : mybutton(
                  color: Colors.purpleAccent,
                  fontSize: 16.sp,
                  ontap: () {
                    setState(() {
                      _isEditMode = true;
                    });
                  },
                  btext: 'Edit Profile',
                ),
          if (_showMessage)
            Padding(
              padding: EdgeInsets.all(8.0.r),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  _message ?? '',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueAccent,
              Colors.purpleAccent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 50.h),
          child: FormBuilder(
            key: _formKey,
            child: _buildProfileDisplay(),
          ),
        ),
      ),
    );
  }
}
