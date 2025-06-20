import 'package:flutter/material.dart';
import 'package:worker_task2/view/model/worker.dart';

class HomeScreen extends StatelessWidget {
  final Worker worker;
  const HomeScreen({super.key, required this.worker});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              "Welcome Worker!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  buildInfoCard("ID", worker.iD ?? "N/A", Icons.badge),
                  buildInfoCard("Name", worker.name ?? "N/A", Icons.person),
                  buildInfoCard("Email", worker.email ?? "N/A", Icons.email),
                  buildInfoCard("Phone", worker.phone ?? "N/A", Icons.phone),
                  buildInfoCard("Address", worker.address ?? "N/A", Icons.location_on),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoCard(String title, String value, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(value),
      ),
    );
  }
}
