
class Submission {
  final int id;
  final String title;
  final String text;
  final String date;
  final String status;


  Submission({
    required this.id,
    required this.title,
    required this.text,
    required this.date,
    required this.status,
  });

  factory Submission.fromJson(Map<String, dynamic> json) {
    return Submission(
      id: json['submission_id'],
      title: json['title'],
      text: json['submission_text'],
      date: json['submitted_at'],
      status: json['status'],
    );
  }
}