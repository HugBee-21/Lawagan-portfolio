<?php
require_once __DIR__ . '/../models/AuctionListingsModel.php';

class AuctionListingsController {
    private $model;

    public function __construct() {
        $this->model = new AuctionListingsModel();
    }

    public function index() {
        $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
        $per_page = 9;

        $cards = $this->model->getPaginatedCards($page, $per_page);
        $categories = $this->model->getAllCategories();
        $conditions = $this->model->getAllConditions();

        $total_result = $this->model->getTotalCards();
        $total_pages = ceil($total_result / $per_page);
        $current_page = $page;

        $active = 1;
        require __DIR__ . '/../views/AuctionListingsView.php';
    }

    // TODO - Add Category, Price, and Condition handling
    public function search() {
        $sq = $_GET['sq'] ?? '';
        $page = isset($_GET['page']) ? max(1, (int)$_GET['page']) : 1;
        $per_page = 9;

        $filters = [
            'categories'   => $_GET['category'] ?? [],
            'price'        => $_GET['price'] ?? null,
            'condition'    => $_GET['condition'] ?? null,
            'auction_type' => $_GET['auction_type'] ?? 'any'
        ];

        $cards = $this->model->searchCards($sq, $filters);
        $total = count($cards);
        $total_pages = max(1, ceil($total / $per_page));

        // slice cards for current page
        $start = ($page - 1) * $per_page;
        $paged_cards = array_slice($cards, $start, $per_page);

        ob_start();
        foreach ($paged_cards as $c) {
            $title = $c['title'];
            $image = $c['image'];
            $user_name = $c['user_name'];
            $user_image = $c['user_image'];
            $price = $c['price'];
            $time = $c['time'];
            $link = $c['link'];
            $condition = $c['condition_name'];
            $type = $c['type'];
            include 'server_scripts/user/component/card.php';
        }
        $html = ob_get_clean();

        header('Content-Type: application/json');
        echo json_encode([
            'count' => $total,
            'html' => $html,
            'currentPage' => $page,
            'totalPages' => $total_pages
        ]);
        exit;
    }
}
?>