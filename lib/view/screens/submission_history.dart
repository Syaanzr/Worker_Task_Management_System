import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'edit_submission.dart';
import 'package:worker_task2/view/model/submission.dart';

class SubmissionHistory extends StatefulWidget {
  final String worker_id;
  const SubmissionHistory({super.key, required this.worker_id});

  @override
  State<SubmissionHistory> createState() => _SubmissionHistoryState();
}

class _SubmissionHistoryState extends State<SubmissionHistory> {
  List<Submission> submissions = [];
  bool isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchSubmission();
  }

  Future<void> fetchSubmission() async {
    try {
      print("Sending iD: ${widget.worker_id}");

    final response = await http.post(
      Uri.parse("http://10.0.2.2/worker_list/get_submissions.php"),
      body: {
        "iD": widget.worker_id,
        },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData == null || responseData['submissions'] == null) {
        setState(() {
          _errorMessage = 'No submission data received.';
          isLoading = false;
        });
        return;
      }

      final List<dynamic> data = responseData['submissions'];

      setState(() {
        submissions = data
        .map((json) => Submission.fromJson(json))
        //.where((submission) => submission.status.toLowerCase() == 'completed')
        .toList();
        isLoading = false;
      });

      
    } else {
      throw Exception('Failed to load submissions history');
    }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Submission History"), backgroundColor: Color.fromARGB(255, 209, 46, 179)),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
          ? Center(child: Text(_errorMessage))
          : ListView.builder(
              itemCount: submissions.length,
              itemBuilder: (context, index) {
                final submission = submissions[index];
                return InkWell(
                  onTap: () async {
                    final updated = await Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (_) => EditSubmission(
                          submission_id: submission.id, 
                          originalText: submission.text,
                          ),
                      ),
                      );
                      if (updated == true) fetchSubmission();
                  },
                  child: Card(
                    margin: const EdgeInsets.all(8),
                    child: Padding(padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Task: ${submission.title}", style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text("Date: ${submission.date}"),
                        Text("Summary: ${submission.text.length > 50 ? '${submission.text.substring(0, 50)}...' : submission.text}"),
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