<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "wtms"; 

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    header('Content-Type: application/json');
    echo json_encode(['success' => false, 'message' => 'Database connection failed']);
    exit;
}
?>

