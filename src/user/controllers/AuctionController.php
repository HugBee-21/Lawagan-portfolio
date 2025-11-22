<?php 
require_once __DIR__ . '/../models/AuctionModel.php';
class AuctionController {
    private $model;

    public function __construct(){
        $this->model = new AuctionModel($_GET['id']);
    }

    public function index() {
        $auction = $this->model;
        $active = 1;
        require __DIR__ . '/../views/AuctionView.php';
    }
}
?>