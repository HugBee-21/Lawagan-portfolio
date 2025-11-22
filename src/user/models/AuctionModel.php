<?php 
require_once __DIR__ . '/../../database.php';
class AuctionModel {
    private $db;

    private $id;
    private $condition;
    private $title;
    private $buy_now_price;
    private $bid_increment;
    private $end_date;
    private $watchers;
    private $images = [];
    private $description;
    private $seller_name;
    private $payment_methods = [];
    private $categories = [];

    private $bid_history = [];


    public function __construct(int $id) {
        $this->id = $id;
        $this->db = Database::getInstance()->getConnection(); 

        $stmt = $this->db->prepare("CALL get_auction_listing(?)");
        if (!$stmt) {
            throw new Exception("Prepare failed: " . $this->db->error);
        }

        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result && $row = $result->fetch_assoc()) {
            $this->id = $row['listing_id'];

            // TODO - Handle empty and null json
            $this->images = json_decode($row['image_urls'], true);
            $this->title = $row['title'];
            $this->description = $row['description'];
            $this->bid_increment = $row['bid_increment'];
            $this->buy_now_price = $row['buy_now_price'];
            $this->end_date = date('M j, Y, g:i A', strtotime($row['end_date']));
            $this->condition = $row['condition_name'];
            $this->seller_name = $row['seller_name'];
            $this->watchers = $row['watchers'];
            $this->payment_methods = explode(', ', $row['payment_methods'] ?? '');
            $this->categories = explode(', ', $row['categories'] ?? '');
        } else {
            throw new Exception("Auction not found or no data returned.");
        }

        $result->free();
        $stmt->close();

        $this->loadBidHistory();
    }

    private function loadBidHistory(): void {
        $stmt = $this->db->prepare("CALL get_bid_history(?)");
        if (!$stmt) {
            throw new Exception("Prepare failed: " . $this->db->error);
        }

        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $result = $stmt->get_result();

        while ($row = $result->fetch_assoc()) {
            $this->bid_history[] = [
                "user_name" => $row['user_name'],
                "is_highest_bid" => (bool)$row['is_the_winner'],
                "bid_time" => date('M j, Y, g:i A', strtotime($row['bid_time'])),
                "bid_amount" => $row['bid_amount']
            ];
        }
        $result->free();
        $stmt->close();
    }

    public function getId() { return $this->id; }
    public function getImages() { return $this->images; }
    public function getTitle() { return $this->title; }
    public function getDescription() { return $this->description; }
    public function getCondition() { return $this->condition; }
    public function getSellerName() { return $this->seller_name; }
    public function getBuyNowPrice() { return $this->buy_now_price; }
    public function getEndDate() { return $this->end_date; }
    public function getWatchers() { return $this->watchers; }
    public function getPaymentMethods() { return $this->payment_methods; }
    public function getCategories() { return $this->categories; }
    public function getBidIncrement() { return $this->bid_increment; }
    public function getBidHistory() { return $this->bid_history;}
}
?>