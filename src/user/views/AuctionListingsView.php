<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="assets/css/page/listings.css" rel="stylesheet">

    <script>const pageListingType = "<?php 
        $listingType = 'auction';
        echo $listingType ?>"
    </script>
    <script defer src="assets/js/listings.js"></script>

    <title>Auction</title>
</head>
<?php include __DIR__ . "/../component/navbar.php"?>
<body>
    <div class="hero-wrapper">
        <div class="hero">
            <h1 class="hero-header-text">AUCTIONS</h1>
            <p class="hero-subtext">Browse upcoming, featured, and past auctions</p>
        </div>
    </div>

    <div class="container">
        <div class="grid-container listings">
            <div class="grid-item">
                <label id="results-label" class="results">
                    <?= "Show $total_result Results"?>
                </label>
            </div>
            <div class="grid-item">
                <div class="search-container">
                    <input id="search" type="search" placeholder="Search" autocomplete="off">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" id="search_icon" height="13" width="13">
                        <path stroke="#000000" d="M18.425 18.425 23.5 23.5m-12.5 -2C5.201 21.5 0.5 16.799 0.5 11S5.201 0.5 11 0.5 21.5 5.201 21.5 11 16.799 21.5 11 21.5Z" stroke-width="1"></path>
                    </svg>
                </div>
            </div>
            <div class="grid-item">
                <!-- Sidebar -->
                <form class="filter-form">
                    <div class="filter-section">
                        <h3>Category</h3>
                        <?php
                        $name = "category[]";
                        foreach($categories as $value) {
                            include 'server_scripts/user/component/checkbox.php';
                        }
                        ?>
                    </div>

                    <hr>

                    <div class="filter-section">
                        <h3>Price Range</h3>
                        <?php 
                        $name = "price";
                        $options = [
                            "lt500"    => "Less than ₱500",
                            "500-1000" => "₱500 - ₱1000",
                            "gt1000"   => "More than ₱1000"
                        ];

                        foreach ($options as $value => $txt) {
                            include 'server_scripts/user/component/radio_button.php';
                        }
                        $txt = NULL;
                        ?>
                    </div>

                    <hr>

                    <div class="filter-section">
                        <h3>Condition</h3>
                        <?php 
                        $name = "condition";

                        foreach ($conditions as $value) {
                            include 'server_scripts/user/component/radio_button.php';
                        }

                        $txt = NULL;
                        ?>
                    </div>

                    <hr>

                    <div class="filter-section">
                        <h3>Auction Type</h3>
                        <?php 
                        $name = "auction_type";
                        $options = [
                            "any"             => "Any",
                            "reserve_met"     => "Reserve Met",
                            "reserve_not_met" => "Reserve Not Met",
                            "buy_now"         => "Buy Now Price"
                        ];

                        foreach ($options as $value => $txt) {
                            include 'server_scripts/user/component/radio_button.php';
                        }

                        $txt = NULL;
                        ?>
                    </div>
                </form>
            </div>
            <div class="grid-item">
                <!-- Listings -->
                <div id="spinner-overlay" class="overlay<?= count($cards) != 0 ? "" : " visible" ?>">
                    <div class="loader"></div>
                </div>

                <div id="no-result-overlay" class="overlay">
                    <img src="assets\images\No_Result.png" alt="No Result Image">
                    <h4>No Result Found</h4>
                    <p>We can’t find any items matching your search</p>
                </div>

                <div id="card-listings" class="grid-container">
                    <?php
                        foreach($cards as $c) {
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
                    ?>
                </div>

                <div id="pagination" class="pagination">
                    <?php if ($current_page > 1): ?>
                        <a href="#" class="pagination-link" data-page="<?= $current_page - 1 ?>">Prev</a>
                    <?php endif; ?>

                    <?php
                    if ($total_pages > 1) {
                        $visible_pages = 3;
                        $start_page = max(1, $current_page - 1);
                        $end_page = min($total_pages, $current_page + 1);

                        if ($start_page > 1) {
                            echo '<a href="#" class="pagination-link" data-page="1">1</a>';
                            if ($start_page > 2) echo '<button class="pagination-ellipsis">...</button>';
                        }

                        for ($i = $start_page; $i <= $end_page; $i++) {
                            $active = ($i == $current_page) ? 'active' : '';
                            echo "<a href='#' class='pagination-link $active' data-page='$i'>$i</a>";
                        }

                        if ($end_page < $total_pages) {
                            if ($end_page < $total_pages - 1) echo '<button class="pagination-ellipsis">...</button>';
                            echo "<a href='#' class='pagination-link' data-page='$total_pages'>$total_pages</a>";
                        }
                    }
                    ?>

                    <?php if ($current_page < $total_pages): ?>
                        <a href="#" class="pagination-link" data-page="<?= $current_page + 1 ?>">Next</a>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>
</body>
<?php include __DIR__ . "/../component/footer.php"?>
</html>