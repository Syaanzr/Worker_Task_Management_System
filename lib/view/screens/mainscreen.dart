import 'package:flutter/material.dart';
import 'package:worker_task2/view/model/worker.dart';
import 'package:worker_task2/view/screens/viewTask.dart';
import 'package:worker_task2/view/screens/submission_history.dart';
import 'package:worker_task2/view/screens/profile_screen.dart';
import 'package:worker_task2/view/screens/loginscreen.dart';

class MainScreen extends StatefulWidget {
  final Worker worker;
  const MainScreen({super.key, required this.worker});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      viewTask(iD: widget.worker.iD!),
      SubmissionHistory(worker_id: widget.worker.iD!),
      ProfileScreen(id: widget.worker.toString()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Worker Task Management"),
        backgroundColor: const Color.fromARGB(255, 209, 46, 179),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.worker.name ?? "No Name"),
              accountEmail: Text(widget.worker.email ?? ""),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40),
              ),
              decoration: const BoxDecoration(color: Color.fromARGB(255, 209, 46, 179)),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
            ),
          ],
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
