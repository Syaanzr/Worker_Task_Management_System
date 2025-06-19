<?php
header('Content-Type: application/json');
include 'dbconnect.php';

$submission_id = $_POST['submission_id'] ?? null;
$updated_text = $_POST['updated_text'] ?? null;

if (!$submission_id || !$updated_text) {
    echo json_encode(['success' => false, 'message' => 'Missing parameters']);
    exit;
}

$query = "UPDATE tbl_submissions SET submission_text = ? WHERE id = ?";
$stmt = $conn->prepare($query);
$stmt->bind_param("si", $updated_text, $submission_id);
$success = $stmt->execute();

echo json_encode(['success' => $success]);

$stmt->close();
$conn->close();
?>
