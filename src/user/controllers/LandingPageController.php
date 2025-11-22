<?php
class LandingPageController {
    function index() {
        $active = 0;
        require __DIR__ . '/../views/LandingPageView.php';
    }
}
?>