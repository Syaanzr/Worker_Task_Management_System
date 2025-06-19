import 'dart:convert'; 
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:worker_task2/view/model/task.dart';
import 'package:worker_task2/view/screens/submission_screen.dart';
import 'package:worker_task2/view/screens/viewTask.dart';
import 'package:worker_task2/view/model/submission.dart';

class viewTask extends StatefulWidget {
  final String? iD;
  const viewTask({super.key, required this.iD}); 

  @override
  State<viewTask> createState() => _viewTaskState();
}

class _viewTaskState extends State<viewTask> {
  List<Task> _task = [];
  bool _isLoading = true; 
  String _errorMessage = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchTasks();
  }

Future<void> _fetchTasks() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2/worker_list/task.php?id=${widget.iD}'),
      );

      if (response.statusCode == 200) {
        log(response.body);
        final data = json.decode(response.body);
        final taskList = data['task'] as List;
        setState(() {
        _task = taskList.map((json) => Task.fromJson(json)).toList();
        _isLoading = false;
      });
      } else {
        throw Exception('Failed to load tasks');
      }
    } catch (e) {
      if(!mounted) return;
      setState(() {
        _errorMessage = 'Error fetching tasks: $e';
        _isLoading = false;
      });
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Assigned Tasks'),
      backgroundColor: Color.fromARGB(255, 209, 46, 179),
    ),
    body: _isLoading
        ? const Center(child: CircularProgressIndicator())
        : _errorMessage.isNotEmpty
            ? Center(child: Text(_errorMessage))
            : ListView.builder(
                itemCount: _task.length,
                itemBuilder: (context, index) {
                  final task = _task[index];
                  return InkWell(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SubmissionScreen(
                            work_id: task.id,
                            worker_id: int.parse(widget.iD!),
                            title: task.title,
                          ),
                        ),
                      );

                      if (result == true) {
                        _fetchTasks(); // refresh to show updated status
                      }
                    },
                    child: Card(
                      margin: const EdgeInsets.all(8),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('id: ${task.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text('title: ${task.title}'),
                            Text('description: ${task.description}'),
                            Text('date_assigned: ${task.dateAssigned}'),
                            Text('due_date: ${task.dueDate}'),
                            Text('status: ${task.status}', style: TextStyle(
                              color: task.status == 'completed' ? Colors.green : Colors.red,
                            )),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
  );
}
}