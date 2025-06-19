<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');

// Read raw JSON input
$data = json_decode(file_get_contents("php://input"));

if (!isset($data->email) || !isset($data->password)) {
    echo json_encode(['status' => 'failed', 'message' => 'Missing parameters']);
    exit;
}

include_once "dbconnect.php";

$email = $data->email;
$password = sha1($data->password); // still using SHA1 to match stored hash

$sql = "SELECT * FROM `worker_table` WHERE email = ? AND password = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ss", $email, $password);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $worker = $result->fetch_assoc();
    $response = array('status' => 'success', 'data' => $worker);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray) {
    echo json_encode($sentArray);
}
?>
