<?php
ob_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);

header('Content-Type: application/json');
include 'dbconnect.php';

// ✅ Log raw POST input
file_put_contents("get_sub_log.txt", "POST: " . print_r($_POST, true) . PHP_EOL, FILE_APPEND);

// ✅ Correct key name: 'worker_id'
$worker_id = $_POST['worker_id'] ?? null;

if (!$worker_id) {
    echo json_encode(['error' => 'Missing worker_id']);
    exit;
}

// ✅ Fetch submissions for this worker
$query = "SELECT s.submission_id, s.submission_text, s.submitted_at, w.title, s.status
          FROM tbl_submissions s
          JOIN tbl_works w ON s.work_id = w.work_id
          WHERE s.worker_id = ?
          ORDER BY s.submitted_at DESC";

$stmt = $conn->prepare($query);
$stmt->bind_param("i", $worker_id);
$stmt->execute();
$result = $stmt->get_result();

$submissions = [];
while ($row = $result->fetch_assoc()) {
    $submissions[] = $row;
}

echo json_encode(["submissions" => $submissions]);
?>
