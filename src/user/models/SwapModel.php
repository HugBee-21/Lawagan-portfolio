<?php
require_once __DIR__ . '/../../database.php';

class SwapModel {
    private $db;

    private $id;
    private $title;
    private $description;
    private $images = [];
    private $looking_for_description;
    private $listed_on;
    private $is_open_to_any_offer;
    private $condition;
    private $seller_name;
    private $categories = [];

    public function __construct(int $id) {
        $this->id = $id;
        $this->db = Database::getInstance()->getConnection();

        $stmt = $this->db->prepare("CALL get_swap_listing(?)");
        if (!$stmt) throw new Exception("Prepare failed: " . $this->db->error);

        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result && $row = $result->fetch_assoc()) {
            $this->id = $row['listing_id'];

            $this->title = $row['title'];
            $this->description = $row['description'];
            $this->images = json_decode($row['image_urls'], true);
            $this->looking_for_description = $row['looking_for_description'];
            $this->listed_on = date('M j, Y, g:i A', strtotime($row['listed_on']));
            $this->is_open_to_any_offer = $row['is_open_to_any_offer'];
            $this->condition = $row['condition_name'];
            $this->seller_name = $row['seller_name'];
            $this->categories = explode(', ', $row['categories'] ?? '');
        } else throw new Exception("Swap not found or no data returned.");

        $result->close();
        $stmt->close();
    }

     public function getId() {
        return $this->id;
    }

    public function getTitle() {
        return $this->title;
    }

    public function getDescription() {
        return $this->description;
    }

    public function getImages() {
        return $this->images;
    }

    public function getLookingForDescription() {
        return $this->looking_for_description;
    }

    public function getListedOn() {
        return $this->listed_on;
    }


    public function getIsOpenToAnyOffer() {
        return $this->is_open_to_any_offer;
    }

    public function getCondition() {
        return $this->condition;
    }

    public function getSellerName() {
        return $this->seller_name;
    }

    public function getCategories() {
        return $this->categories;
    }
}