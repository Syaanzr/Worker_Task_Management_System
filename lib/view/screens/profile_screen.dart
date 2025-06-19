import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final String id;
  const ProfileScreen({super.key, required this.id});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  File? _imageFile;
  bool isLoading = true;
  String _message = '';
  void _removeImage(){
    setState(() {
      _imageFile = null;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    final response = await http.post(
      Uri.parse("http://10.0.2.2/worker_list/get_profile.php"),
      body: {"iD": widget.id},
    );
 if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          nameController.text = data['name'] ?? '';
          emailController.text = data['email'] ?? '';
          phoneController.text = data['phone'] ?? '';
          addressController.text = data['address'] ?? '';
          isLoading = false;
        });
    }else{
      setState(() {
        _message = 'Failed to load profile';
        isLoading = false;
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile!= null) {
      setState(() => _imageFile = File(pickedFile.path));
        
      }
    }


  Future<void> updateProfile() async {
    setState(() => _message= '');
    final request = http.MultipartRequest(
      'POST',
      Uri.parse("http://10.0.2.2/worker_list/update_profile.php"),
    );
    request.fields['iD'] = widget.id;
    request.fields['name'] = nameController.text;
    request.fields['email'] = emailController.text;
    request.fields['phone'] = phoneController.text;
    request.fields['address'] = addressController.text;
    
    if (_imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath('profile_pic', _imageFile!.path));
    }

    final response = await request.send();
    final resBody = await response.stream.bytesToString();
    if (response.statusCode == 200 && resBody.contains('success')) {
      setState(() => _message = 'Profile updated succesfully.');
      }else {
        setState(() => _message = 'Update Failed.');
        }
  }
          

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), backgroundColor: Color.fromARGB(255, 209, 46, 179)),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                      child: _imageFile == null ? const Icon(Icons.camera_alt, size: 40) : null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (_imageFile != null)
                  TextButton.icon(onPressed: _removeImage, icon: const Icon(Icons.delete, color: Colors.red),
                  label: const Text("Remove Picture", style: TextStyle(color: Colors.red)),
                  ),

                  TextField(controller: nameController, decoration: const InputDecoration(labelText: "name")),
                  TextField(controller: emailController, decoration: const InputDecoration(labelText: "email")),
                  TextField(controller: phoneController, decoration: const InputDecoration(labelText: "phone")),
                  TextField(controller: addressController, decoration: const InputDecoration(labelText: "address")),
                  const SizedBox(height: 20),
                  ElevatedButton(onPressed: updateProfile, child: const Text("Save Changes")),
                ],
              ),
            ),
    );
  }
}