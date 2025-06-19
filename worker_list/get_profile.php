<?php
header('Content-Type: application/json');
include 'dbconnect.php';

$worker_id = $_POST['id'] ?? null;

if($worker_id){
    echo json_encode(["error" => "No ID received"]);
    file_put_contents("debug_post.txt", print_r($_POST, true));
    exit;
}



$query = "SELECT * FROM worker_table WHERE id = ?";
$stmt = $conn->prepare($query);
$stmt->bind_param("i", $worker_id);
$stmt->execute();
$result = $stmt->get_result();

if ($row = $result->fetch_assoc()) {
    echo json_encode($row);
} else{
    echo json_encode(["error" => "User not found"]);
}
?>
