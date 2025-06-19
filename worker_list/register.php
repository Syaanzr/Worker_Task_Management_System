<?php
error_reporting(0);
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

// Decode JSON input
$data = json_decode(file_get_contents("php://input"));

if (!isset($_POST['name']) || !isset($_POST['email']) || !isset($_POST['phone']) || !isset($_POST['password']) || !isset($_POST['address'])) {
    $response = array('status' => 'failed', 'message' => 'Missing required fields');
    sendJsonResponse($response);
    exit();
}

include_once("dbconnect.php");

$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$password = sha1($_POST['password']); // Not secure, but matches login
$address = $_POST['address'];

$sqlinsert = "INSERT INTO `worker_table`(`name`, `email`, `phone`, `password`, `address`) 
              VALUES ('$name','$email','$phone','$password','$address')";

// Debug: write to log file
file_put_contents("debug.log", "SQL Query: $sqlinsert", FILE_APPEND);

try {
    if ($conn->query($sqlinsert) === TRUE) {
        $response = array('status' => 'success', 'data' => null);
    } else {
        $response = array('status' => 'failed', 'message' => $conn->error);
    }
    sendJsonResponse($response);
} catch (Exception $e) {
    $response = array('status' => 'failed', 'message' => $e->getMessage());
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    echo json_encode($sentArray);
}
?>
