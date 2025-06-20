<?php
header('Content-Type: application/json');
include 'dbconnect.php';

$workerId = $_POST['iD'];
$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$address = $_POST['address'];
$removePicture = isset($_POST['remove_picture']) ?? 'false';

$profilePicPath = $oldPic;

if (isset($_FILES['profile_pic'])) {
    $image_name = uniqid() . '_' . $_FILES['profile_pic']['name'];
    $target = "uploads/" . $image_name;

    if (move_uploaded_file($_FILES['profile_pic']['tmp_name'], $target)) {
        // Delete old image if exists
        if ($oldPic && file_exists("uploads/" . $oldPic)) {
            unlink("uploads/" . $oldPic);
        }
        $profilePicPath = $image_name;
    }
} elseif ($remove_picture == 'true') {
    // Remove image if requested
    if ($oldPic && file_exists("uploads/" . $oldPic)) {
        unlink("uploads/" . $oldPic);
    }
    $profilePicPath = '';
}

// Update profile
$query = "UPDATE worker_table SET name = ?, email = ?, phone = ?, address = ?, WHERE iD =?";
$stmt = $conn->prepare($query);
$stmt->bind_param("ssssi", $name, $email, $phone, $address, $profilePicPath, $workerId);

if ($stmt->execute()) {
    echo json_encode(['status' => 'success']);
} else {
    echo json_encode(['error' => 'Failed to update profile']);
}
?>
