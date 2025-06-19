import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditSubmission extends StatefulWidget {
  final int submission_id;
  final String originalText;

  const EditSubmission({super.key, required this.submission_id, required this.originalText});

  @override
  State<EditSubmission> createState() => _EditSubmissionState();
}

class _EditSubmissionState extends State<EditSubmission> {
  late TextEditingController _controller;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.originalText);
  }

  Future<void> saveEdit() async {
    setState(() => isSaving = true);
    final response = await http.post(
      Uri.parse("http://10.0.2.2/worker_list/edit_submissions.php"),
      body: {
        "submission_id": widget.submission_id,
        "updated_text": _controller.text.trim(),
      },
    );

    if (response.statusCode == 200) {
      Navigator.pop(context);
    }
    setState(() => isSaving = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Submission"), backgroundColor: Color.fromARGB(255, 209, 46, 179)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: "Updated Submission",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isSaving ? null : saveEdit,
              child: Text(isSaving ? "Saving..." : "Save"),
            ),
          ],
        ),
      ),
    );
  }
}
