import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:worker_task2/view/model/worker.dart';
import 'package:worker_task2/view/screens/mainscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worker_task2/view/screens/registerscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isChecked = false;
  static const String url = "http://10.0.2.2/worker_list/login.php";

  @override
  void initState() {
    super.initState();
    loadCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen"),
        backgroundColor: const Color.fromARGB(255, 225, 61, 214),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
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
                      Row(
                        children: [
                          const Text("Remember Me"),
                          Checkbox(
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value!;
                              });
                              String email = emailController.text;
                              String password = passwordController.text;
                              if (isChecked) {
                                if (email.isEmpty && password.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Please fill all fields"),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  isChecked = false;
                                  return;
                                }
                              }
                              storeCredentials(email, password, isChecked);
                            },
                          ),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () {
                            loginUser();
                          },
                          child: const Text("Login"))
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterScreen()),
                );
              },
              child: const Text("Register an account?"),
            ),
            const SizedBox(height: 10),
            GestureDetector(onTap: () {}, child: const Text("Forgot Password?")),
          ],
        ),
      ),
    );
  }

  void loginUser() async {
  String email = emailController.text;
  String password = passwordController.text;

  
  try {
    final response = await http.post(Uri.parse(url),
     headers: {"Content-Type": "application/json"},
      body: json.encode({
    "email": email,
    "password": password,
  }),
);

   // print("Response status: ${response.statusCode}");
    print("Response body: '${response.body}'");

    if (response.body.isEmpty) {
      if (!context.mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Empty response from server"),
        backgroundColor: Colors.red,
      ));
      return;
    }


    var jsondata;
    try {
      jsondata = json.decode(response.body);
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Invalid JSON: $e"),
        backgroundColor: Colors.red,
      ));
      return;
    }

    if (response.statusCode == 200 && jsondata['status'] == 'success') {
      var workerData = jsondata['data']; 
      Worker worker = Worker(
        iD: workerData['iD'].toString(),
        name: workerData['name'].toString(),
        email: workerData['email'].toString(),
        phone: workerData['phone'].toString(),
        password: workerData['password'].toString(),
        address: workerData['address'].toString(),
      );

      if (!context.mounted) return;
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainScreen(worker: worker)),
      );
    } else {
      if (!context.mounted)return;
   
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Login failed. Please check your credentials."),
        backgroundColor: Colors.red,
      ));
    }
  } catch (e, stack) {

    print("Stack trace: $stack");
    print("Login error: $e");
    if (!context.mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Login error: $e"),
      backgroundColor: Colors.red,
    ));
  }
}


  Future<void> storeCredentials(
      String email, String password, bool isChecked) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isChecked) {
      await prefs.setString('email', email);
      await prefs.setString('password', password);
      await prefs.setBool('remember', isChecked);
      
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Pref Stored Success!"),
        backgroundColor: Color.fromARGB(255, 209, 46, 179),
      ));
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
      await prefs.remove('remember');
      emailController.clear();
      passwordController.clear();
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Pref Removed!"),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> loadCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    bool? isChecked = prefs.getBool('remember');
    if (email != null && password != null && isChecked != null) {
      emailController.text = email;
      passwordController.text = password;
      setState(() {
        this.isChecked = isChecked!;
      });
    } else {
      emailController.clear();
      passwordController.clear();
      isChecked = false;
      setState(() {});
    }
  }
}
