import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:worker_task2/view/screens/loginscreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
      final String url = "http://10.0.2.2/worker_list/register.php";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Register Screen"),
          backgroundColor: const Color.fromARGB(255, 186, 71, 212),
        ),
        body: Center(
            child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: "Your Name",
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: "Email",
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        labelText: "Password",
                      ),
                      obscureText: true,
                    ),
                    TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        labelText: "Phone",
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    TextField(
                      controller: addressController,
                      decoration: const InputDecoration(
                        labelText: "Address",
                      ),
                      keyboardType: TextInputType.text,
                      maxLines: 4,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                        width: 400,
                        child: ElevatedButton(
                          onPressed: registerWorkerDialog,
                          child: const Text("Register"),
                        )
                        )
                  ],
                ),
              ),
            ),
          ),
        )));
        
  }

void registerWorkerDialog() {
  String name = nameController.text;
  String email = emailController.text;
  String phone = phoneController.text;
  String password = passwordController.text;
  String address = addressController.text;

  if (name.isEmpty ||
      email.isEmpty ||
      phone.isEmpty ||
      password.isEmpty ||
      address.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Please fill all fields"),
    ));
    return;
  }
  registerWorker();
}

  void registerWorker() async {
  String name = nameController.text;
  String email = emailController.text;
  String phone = phoneController.text;
  String password = passwordController.text;
  String address = addressController.text;

  try {
    var response = await http.post(Uri.parse(url), body: {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
      "address": address,
    });

    print(response.body);

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      if (jsondata['status'] == 'success') {
        //if (!context.mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Success!"),
        ));

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen())
        );
      } else {
        if (!context.mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Failed to register"),
        ));
      }
    }
  } catch (e) {
    print("Error: $e");
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Error: $e"),
    ));
  }
}

}
