<?php
require_once __DIR__ . '/../../database.php';
class SwapListingsModel {
    private $db;

    private $cards = [];
    private $categories = [];
    private $conditions = [];

    public function __construct() {
        $this->db = Database::getInstance();

        // Swaps
        $query = "
            SELECT 
                l.listing_id,
                i.title,
                i.image_urls,
                u.full_name AS user_name,
                u.profile_picture_url AS user_image,
                c.name AS condition_name,
                l.listed_on
            FROM listing l
            JOIN swap_listing a ON l.listing_id = a.listing_id
            JOIN item i ON l.item_id = i.item_id
            JOIN user u ON i.user_id = u.user_id
            JOIN `condition` c ON i.condition_id = c.condition_id
            WHERE l.status = 'ACTIVE' 
              AND l.type = 'SWAP'
            ORDER BY l.listed_on ASC
        ";

        if ($stmt = $this->db->getConnection()->prepare($query)) {
            $stmt->execute();
            $result = $stmt->get_result();

            while ($row = $result->fetch_assoc()) {
                // TODO - Handle empty and null json
                $images = json_decode($row['image_urls'], true);
                $main_image = $images[0] ?? 'assets/images/placeholder.png';
                $user_image = $row['user_image'] ?: 'assets/images/placeholder.png';
                $time = date('M j, Y, g:i A', strtotime($row['listed_on']));
                $link = "view/swap?id=" . $row['listing_id'];
                $condition = $row['condition_name'];

                $this->cards[] = [
                    'title' => $row['title'],
                    'image' => $main_image,
                    'user_name' => $row['user_name'],
                    'user_image' => $user_image,
                    'listed_on' => $time,
                    'link' => $link,
                    'condition_name' => $condition,
                    'type' => 'swap'
                ];
            }

            $stmt->close();
        }


        // Categories
        $query = "SELECT name FROM category";
        if ($stmt = $this->db->getConnection()->prepare($query)) {
            $stmt->execute();
            $stmt->bind_result($name);
            while ($stmt->fetch()) {
                $this->categories[] = $name;
            }
            $stmt->close();
        } 

        // Conditions
        $query = "SELECT name FROM web_dev.condition";
        if ($stmt = $this->db->getConnection()->prepare($query)) {
            $stmt->execute();
            $stmt->bind_result($name);
            while ($stmt->fetch()) {
                $this->conditions[] = $name;
            }
            $stmt->close();
        } 
    }

    public function searchCards($searchQuery, $filters = []) {
        $conn = $this->db->getConnection();
        $this->cards = [];

        $query = "
            SELECT 
                sl.listing_id,
                i.title,
                i.image_urls,
                u.full_name AS user_name,
                u.profile_picture_url AS user_image,
                l.listed_on,
                c.name AS condition_name,
                GROUP_CONCAT(cat.name) AS categories
            FROM swap_listing sl
            JOIN listing l ON sl.listing_id = l.listing_id
            JOIN item i ON l.item_id = i.item_id
            JOIN user u ON i.user_id = u.user_id
            LEFT JOIN `condition` c ON i.condition_id = c.condition_id
            LEFT JOIN item_category ic ON i.item_id = ic.item_item_id
            LEFT JOIN category cat ON ic.category_id = cat.category_id
            WHERE l.status = 'ACTIVE'
        ";

        $params = [];
        $types = '';

        if (!empty($searchQuery)) {
            // $query .= " AND (i.title LIKE CONCAT('%', ?, '%') OR i.description LIKE CONCAT('%', ?, '%'))";

            $query .= " AND i.title LIKE CONCAT('%', ?, '%')";
            $params[] = $searchQuery;
            $types .= "s";
        }

        if (!empty($filters['categories'])) {
            $placeholders = implode(',', array_fill(0, count($filters['categories']), '?'));
            $query .= " AND cat.name IN ($placeholders)";
            foreach ($filters['categories'] as $cat) {
                $params[] = $cat;
                $types .= "s";
            }
        }

        if (!empty($filters['condition'])) {
            $query .= " AND c.name = ?";
            $params[] = $filters['condition'];
            $types .= "s";
        }

        $query .= " GROUP BY l.listing_id ORDER BY l.listed_on DESC";

        $stmt = $conn->prepare($query);

        if ($params) {
            $stmt->bind_param($types, ...$params);
        }

        $stmt->execute();
        $result = $stmt->get_result();

        while ($row = $result->fetch_assoc()) {
            $imageUrls = json_decode($row['image_urls'], true);
            $firstImage = $imageUrls[0] ?? 'assets/images/placeholder.png';
            $formattedDate = date('M j, Y, g:i A', strtotime($row['listed_on']));

            $this->cards[] = [
                'title' => $row['title'],
                'image' => $firstImage,
                'user_name' => $row['user_name'],
                'user_image' => $row['user_image'] ?? 'assets/images/placeholder.png',
                'listed_on' => $formattedDate,
                'link' => "view/swap?id=" . $row['listing_id'],
                'condition_name' => $row['condition_name'],
                'type' => 'swap'
            ];
        }

        $stmt->close();
        return $this->cards;
    }

    public function getPaginatedCards($page, $per_page) {
        $offset = ($page - 1) * $per_page;
        return array_slice($this->cards, $offset, $per_page);
    }

    public function getTotalCards() {
        return count($this->cards);
    }

    public function getAllCards() {
        return $this->cards;
    }

    public function getAllCategories() {
        return $this->categories;
    }

    public function getAllConditions() {
        return $this->conditions;
    }
}
?>