<?php
require_once __DIR__ . '/database.php';

header('Content-Type: application/json');

$uploadDir = __DIR__ . '/../server_storage/images/';
if (!is_dir($uploadDir)) {
    mkdir($uploadDir, 0777, true);
}

$response = [
    'success' => false,
    'message' => '',
    'files' => []
];

// --- Check if files were uploaded ---
if (!isset($_FILES['images'])) {
    echo json_encode(['success' => false, 'message' => 'No files uploaded.']);
    exit;
}

// --- Handle multiple uploads ---
foreach ($_FILES['images']['tmp_name'] as $index => $tmpName) {

    if (empty($tmpName) || !file_exists($tmpName)) {
        continue;
    }

    $originalName = pathinfo($_FILES['images']['name'][$index], PATHINFO_FILENAME);
    $extension = pathinfo($_FILES['images']['name'][$index], PATHINFO_EXTENSION);
    $uniqueName = $originalName . '_' . uniqid() . '.' . $extension;

    $targetPath = $uploadDir . $uniqueName;

    $fileType = mime_content_type($tmpName);
    $allowed = ['image/jpeg', 'image/png', 'video/mp4'];
    if (!in_array($fileType, $allowed)) {
        $response['message'] = "File type not allowed: {$_FILES['images']['name'][$index]}";
        echo json_encode($response);
        exit;
    }

    if (move_uploaded_file($tmpName, $targetPath)) {
        $response['files'][] = 'server_storage/images/' . $uniqueName;
    } else {
        $response['message'] = "Failed to upload {$_FILES['images']['name'][$index]}";
        echo json_encode($response);
        exit;
    }
}

$title = $_POST['title'] ?? '';
$description = $_POST['description'] ?? '';
$category = $_POST['category'] ?? 1;
$condition = $_POST['condition'] ?? 1;
$images_json = json_encode($response['files'], JSON_UNESCAPED_SLASHES);

$db = Database::getInstance()->getConnection();
$stmt = NULL;
$user_id = 1;

if($_POST['type'] == "auction") {
    // --- Handle text fields ---
    $starting_bid = $_POST['starting_bid'] ?? 0;
    $reserve_price = $_POST['reserve_price'] ?? 0;
    $buy_now_price = $_POST['buy_now_price'] ?? 0;
    $duration = isset($_POST['duration']) ? (int)$_POST['duration'] : 0;
    $bid_increment = 10.5; // temp

    $today = new DateTime();
    $today->modify("+{$duration} days");
    $end_date = $today->format('Y-m-d H:i:s');

    $stmt = $db->prepare("CALL create_new_auction_listing(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param(
        "iisssddddsi",
        $user_id,
        $condition,
        $title,
        $description,
        $images_json,
        $reserve_price,
        $buy_now_price,
        $starting_bid,
        $bid_increment,
        $end_date,
        $category
    );
} else {
    $looking_for = $_POST['looking_for'] ?? '';
    $is_open_to_any_offer = isset($_POST['open_to_offers']) ? 1 : 0;

    $stmt = $db->prepare("CALL create_new_swap_listing(?, ?, ?, ?, ?, ?, ?, ?)");

    $stmt->bind_param(
        "iissssii",
        $user_id,
        $condition,
        $title,
        $description,
        $images_json,
        $looking_for,
        $is_open_to_any_offer,
        $category
    );
}

if ($stmt->execute()) {
    $response['success'] = true;
    $response['message'] = 'Listing created successfully!';
} else {
    $response['message'] = 'Database error: ' . $stmt->error;
}

$stmt->close();
$db->close();

echo json_encode($response);