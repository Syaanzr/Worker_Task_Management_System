<?php
include 'dbconnect.php';

$workerId = $_POST['iD'];

$query = "SELECT name, email, phone FROM worker_table WHERE iD = ?";
$stmt = $conn->prepare($query);
$stmt->bind_param("i", $workerId);
$stmt->execute();
$result = $stmt->get_result();

if ($row = $result->fetch_assoc()) {
    echo json_encode($row);
} else {
    echo json_encode(["error" => "User not found"]);
}
?>
