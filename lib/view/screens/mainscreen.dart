import 'package:flutter/material.dart';
import 'package:worker_task2/view/model/worker.dart';
import 'package:worker_task2/view/screens/viewTask.dart';
import 'package:worker_task2/view/screens/submission_history.dart';
import 'package:worker_task2/view/screens/profile_screen.dart';
import 'package:worker_task2/view/screens/loginscreen.dart';
import 'package:worker_task2/view/screens/home_screen.dart';


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
      HomeScreen(worker: widget.worker),
      viewTask(iD: widget.worker.iD!),
      SubmissionHistory(workerId: widget.worker.iD!),
      ProfileScreen(workerId: widget.worker.iD!),
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
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Homepage'),
          const BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.history),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: const Text(
                      '!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
            label: 'History',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
