<?php
// Turn on error reporting for debugging (only in development)
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Prevent accidental whitespace before/after JSON
ob_clean();
header('Content-Type: application/json');

include 'dbconnect.php';

$iD = $_GET['id'];

$query = "SELECT * FROM tbl_works WHERE assigned_to = $iD";
$stmt = $conn->prepare($query);
// $stmt->bind_param("i", $iD);
$stmt->execute();
$result = $stmt->get_result();

$task = [];
while ($row = $result->fetch_assoc()) {
    $task[] = $row;
}

echo json_encode(['task' => $task]);

$stmt->close();
$conn->close();
?>
