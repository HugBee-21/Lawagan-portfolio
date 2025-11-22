<!-- Temporary Code -->
<?php
require_once __DIR__ . '/database.php';
header('Content-Type: application/json');

try {
    $db = Database::getInstance()->getConnection();

    // --- Fetch categories ---
    $categories = [];
    $stmt = $db->prepare("SELECT category_id, name FROM category ORDER BY name ASC");
    if ($stmt->execute()) {
        $result = $stmt->get_result();
        while ($row = $result->fetch_assoc()) {
            $categories[] = $row;
        }
        $stmt->close();
    }

    // --- Fetch conditions ---
    $conditions = [];
    $stmt = $db->prepare("SELECT condition_id, name FROM condition ORDER BY name ASC");
    if ($stmt->execute()) {
        $result = $stmt->get_result();
        while ($row = $result->fetch_assoc()) {
            $conditions[] = $row;
        }
        $stmt->close();
    }

    echo json_encode([
        'success' => true,
        'categories' => $categories,
        'conditions' => $conditions
    ]);
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'message' => $e->getMessage()
    ]);
}
