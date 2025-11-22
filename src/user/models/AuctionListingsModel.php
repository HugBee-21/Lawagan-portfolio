<?php
require_once __DIR__ . '/../../database.php';
class AuctionListingsModel {
    private $db;

    private $cards = [];
    private $categories = [];
    private $conditions = [];

    public function __construct() {
        $this->db = Database::getInstance();

        // Auctions
        $query = "
            SELECT 
                l.listing_id,
                i.title,
                i.image_urls,
                u.full_name AS user_name,
                u.profile_picture_url AS user_image,
                a.starting_bid,
                c.name AS condition_name,
                a.end_date
            FROM listing l
            JOIN auction_listing a ON l.listing_id = a.listing_id
            JOIN item i ON l.item_id = i.item_id
            JOIN user u ON i.user_id = u.user_id
            JOIN web_dev.condition c ON i.condition_id = c.condition_id
            WHERE l.status = 'ACTIVE' 
              AND l.type = 'AUCTION'
            ORDER BY a.end_date ASC
        ";

        // Auctions
        if ($stmt = $this->db->getConnection()->prepare($query)) {
            $stmt->execute();
            $result = $stmt->get_result();

            while ($row = $result->fetch_assoc()) {
                $images = json_decode($row['image_urls'], true);
                $main_image = $images[0] ?? 'assets/images/placeholder.png';
                $user_image = $row['user_image'] ?: 'assets/images/placeholder.png';
                $price = "₱". number_format($row['starting_bid'], 0);
                $time = date('M j, Y, g:i A', strtotime($row['end_date']));
                $link = "view/auction?id=" . $row['listing_id'];
                $condition = $row['condition_name'];

                $this->cards[] = [
                    'title' => $row['title'],
                    'image' => $main_image,
                    'user_name' => $row['user_name'],
                    'user_image' => $user_image,
                    'price' => $price,
                    'time' => $time,
                    'link' => $link,
                    'condition_name' => $condition,
                    'type' => 'auction'
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
                al.listing_id,
                i.title,
                i.image_urls,
                u.full_name AS user_name,
                u.profile_picture_url AS user_image,
                al.starting_bid AS price,
                al.end_date,
                al.reserve,
                al.buy_now_price,
                c.name AS condition_name,
                GROUP_CONCAT(cat.name) AS categories
            FROM auction_listing al
            JOIN listing l ON al.listing_id = l.listing_id
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

        if (!empty($filters['price'])) {
            switch ($filters['price']) {
                case 'lt500':
                    $query .= " AND al.starting_bid < 500";
                    break;
                case '500-1000':
                    $query .= " AND al.starting_bid BETWEEN 500 AND 1000";
                    break;
                case 'gt1000':
                    $query .= " AND al.starting_bid > 1000";
                    break;
            }
        }

        if (!empty($filters['condition'])) {
            $query .= " AND c.name = ?";
            $params[] = $filters['condition'];
            $types .= "s";
        }

        switch ($filters['auction_type']) {
            case 'reserve_met':
                $query .= " AND al.reserve IS NOT NULL AND al.starting_bid >= al.reserve";
                break;
            case 'reserve_not_met':
                $query .= " AND al.reserve IS NOT NULL AND al.starting_bid < al.reserve";
                break;
            case 'buy_now':
                $query .= " AND al.buy_now_price > 0";
                break;
        }

        $query .= " GROUP BY al.listing_id ORDER BY al.end_date ASC";

        $stmt = $conn->prepare($query);

        if ($params) {
            $stmt->bind_param($types, ...$params);
        }

        $stmt->execute();
        $result = $stmt->get_result();

        while ($row = $result->fetch_assoc()) {
            $imageUrls = json_decode($row['image_urls'], true);
            $firstImage = $imageUrls[0] ?? 'assets/images/placeholder.png';
            $formattedDate = date('M j, Y, g:i A', strtotime($row['end_date']));
            $formattedPrice = '₱' . number_format($row['price'], 0);

            $this->cards[] = [
                'title' => $row['title'],
                'image' => $firstImage,
                'user_name' => $row['user_name'],
                'user_image' => $row['user_image'] ?? 'assets/images/placeholder.png',
                'price' => $formattedPrice,
                'time' => $formattedDate,
                'link' => "view/auction?id=" . $row['listing_id'],
                'condition_name' => $row['condition_name'],
                'type' => 'auction'
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