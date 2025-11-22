<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Title -->
    <title><?= htmlspecialchars($swap->getTitle()) ?></title>

    <!-- CSS -->
    <link href="/ConMatrix-WebDev/assets/css/page/swap-item.css" rel="stylesheet">

    <script defer src="/ConMatrix-WebDev/assets/js/description.js"></script>
    <script defer src="/ConMatrix-WebDev/assets/js/thumbnail.js"></script>
</head>
<body>
    <header>
        <?php 
        require __DIR__ . "/../component/navbar.php";
        ?>
    </header>
    <main class="swap-details">
        <div class="swap__image">
            <!-- Swap REF -->
            <p class="swap__ref">REF# 
                <span>
                    <?= htmlspecialchars($swap->getId()) ?>
                </span>
            </p>

            <!-- Main Thumbnail -->
            <?php $images = $swap->getImages()?> <!-- Images Variable -->

            <div class="images__main-thumbnail">
                <?php if (!empty($images)): ?>
                    <img src="<?= "../" . htmlspecialchars($images[0]) ?>" alt="Swap Image" id="mainImage">
                <?php else: ?>
                    <p>No images available.</p>
                <?php endif; ?>
            </div>

            <!-- Other thumbnail -->
            <div class="images__thumbnail">
                <?php foreach ($images as $img): ?>
                    <img 
                        src="<?= "../" . htmlspecialchars($img) ?>" 
                        alt="Swap Other Image"
                        class="thumbnail <?= $index === 0 ? 'active' : '' ?>" 
                        data-src="<?= "../" . htmlspecialchars($img) ?>">
                <?php endforeach; ?>
            </div>
        </div>
       
        <div class="swap__info">
            <div class="info__heading">
                <p class="heading__condition">
                    <?= htmlspecialchars($swap->getCondition())?>
                </p>
                <h2 class="heading__title">
                    <?= htmlspecialchars($swap->getTitle())?>
                </h2>
                <div class="heading__seller-wrapper">
                    <p class="heading__seller">
                        @<?= htmlspecialchars($swap->getSellerName())?>
                    </p>
                    <a class="heading__contact-seller" href="#">
                        Contact Seller
                    </a>
                </div>
            </div>
            <div class="info__properties">
                <div class="properties__description">
                    <p class="description__text" id="description">
                        <?= nl2br(htmlspecialchars($swap->getDescription()))?>
                    </p>
                    <div class="toggle-container">
                        <button class="description__toggle" id="toggleDescription">Show More</button>
                    </div>
                </div>
                <div class="properties__wrapper">
                    <div class="properties__looking-for info-property">
                        <p class="swap-info-property">Looking for:</p>
                        <p class="swap-info-value"><?= htmlspecialchars($swap->getLookingForDescription())?></p>
                    </div>
                    <div class="properties__listed-on info-property">
                        <p class="swap-info-property">Listed On</p>
                        <p class="swap-info-value"><?= $swap->getListedOn() ?></p>
                    </div>
                    <hr/>
                    <div class="properties__open-to-any-offers info-property">
                        <p class="swap-info-property">Open to Any Offers</p>
                        <p class="swap-info-value"><?= $swap->getListedOn() === 0 ? "No" : "Yes" ?></p>
                    </div>
                    <hr/>
                    <div class="properties__categories info-property">
                        <p class="swap-info-property">Categories</p>
    
                        <?php if (!empty($swap->getCategories())): ?>
                            <p class="swap-info-value"><?= implode(', ', array_map('htmlspecialchars', $swap->getCategories())) ?></p>
                        <?php else: ?>
                            <p>No categories listed.</p>
                        <?php endif; ?>
                    </div>
                </div>
            </div>
            <div class="swap__actions">
                <button class="action__add-to-watchlist">Add to Watchlist</button>
                <button class="action__make-a-proposal">Make a proposal</button>
            </div>
        </div>
    </main>
    <footer>
         <?php 
        require __DIR__ . "/../component/footer.php";
        ?>
    </footer>
</body>
</html>