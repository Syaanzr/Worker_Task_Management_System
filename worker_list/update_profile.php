<?php
header('Content-Type: application/json');
include 'dbconnect.php';

$worker_id = $_POST['iD'];
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
$update = "UPDATE workers SET name=?, email=?, phone=?, address=?, profile_pic=? WHERE id=?";
$stmt = $conn->prepare($update);
$stmt->bind_param("ssssss", $name, $email, $phone, $address, $profilePicPath, $worker_id);

if ($stmt->execute()) {
    echo json_encode(['status' => 'success']);
} else {
    echo json_encode(['error' => 'Failed to update profile']);
}
?>