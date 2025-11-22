<?php 
require_once __DIR__ . '/../models/SwapModel.php';

class SwapController {
    private $model;

    public function __construct()
    {
        $this->model = new SwapModel($_GET['id']);
    }

    public function index() {
        $swap = $this->model;
        $active = 2;
        require __DIR__ . '/../views/SwapView.php';
    }
}