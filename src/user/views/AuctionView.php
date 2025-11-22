<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= htmlspecialchars($auction->getTitle()) ?></title>

    <!-- CSS -->
    <link href="/ConMatrix-WebDev/assets/css/page/auction-item.css" rel="stylesheet">
    <link href="/ConMatrix-WebDev/assets/css/footer.css" rel="stylesheet">

    <script defer src="/ConMatrix-WebDev/assets/js/thumbnail.js"></script>
    <script defer src="/ConMatrix-WebDev/assets/js/description.js"></script>
</head>
<body>

    <header>
        <?php 
        require __DIR__ . "/../component/navbar.php";
        ?>
    </header>
    <main class="auction-details">
        <div class="main-details">
            <div class="auction__image">
                <!-- Auction lot -->
                <p class="auction__lot">LOT# 
                    <span>
                        <?= htmlspecialchars($auction->getId()) ?>
                    </span>
                </p>

                <!-- Main Thumbnail -->
                <?php $images = $auction->getImages()?>
                 <div class="images__main-thumbnail">
                     <?php if (!empty($images)): ?>
                         <img src="<?= "../" . htmlspecialchars($images[0]) ?>" alt="Auction Image" id="mainImage">
                     <?php else: ?>
                         <p>No images available.</p>
                     <?php endif; ?>
                 </div>
                
                <!-- Other thumbnail -->
                <div class="images__thumbnail">
                    <?php foreach ($images as $img): ?>
                        <img 
                            src="<?= "../" . htmlspecialchars($img) ?>" 
                            alt="Auction Image"
                            class="thumbnail <?= $index === 0 ? 'active' : '' ?>" 
                            data-src="<?= "../" . htmlspecialchars($img) ?>">
                    <?php endforeach; ?>
                </div>
            </div>

            <!-- Auction Main Information -->
            <div class="auction__info">
                <div class="info-wrapper">
                    <div class="info__heading">
                        <p class="info__condition"><?= htmlspecialchars($auction->getCondition()) ?></p>
                        <h2 class="info__title"><?= htmlspecialchars($auction->getTitle()) ?></h2>
                    </div>
                    <div class="info__properties">
                        <div class="info__buy-now-price info-property">
                            <p class="auction-info-property">Buy Now Price</p>
                            <?php if (empty($auction->getBuyNowPrice())): ?>
                                <p class="auction-info-value">Not Available</p>
                            <?php else: ?>
                                <p class="auction-info-value">₱<?= number_format($auction->getBuyNowPrice(), 2) ?></p>
                            <?php endif; ?>
                        </div>
                        <hr/>
                        <div class="info__bid-increment info-property">
                            <p class="auction-info-property">Bid Increment</p>
                            <p class="auction-info-value">₱<?= number_format($auction->getBidIncrement(), 2) ?></p>
                        </div>
                        <hr/>
                        <div class="info__end-date info-property">
                            <p class="auction-info-property">End Date</p>
                            <p class="auction-info-value"><?= htmlspecialchars($auction->getEndDate()) ?></p>
                        </div>
                        <hr>
                        <div class="info__watcher info-property">
                            <p class="auction-info-property">Watcher</p>
                            <p class="auction-info-value"><?= htmlspecialchars($auction->getWatchers()) ?></p>
                        </div>
                    </div>
                </div>
                <div class="info__bidding">
                    <div class="bidding__current-bid info-property">
                        <!-- Fetch total bids -->
                        <p>Current Bid (
                            <?php if (method_exists($auction, 'getBidHistory')): ?>
                                <?php $totalBids = count($auction->getBidHistory()); ?>
                
                                <?php if ($totalBids > 1): ?>
                                    <span> <?= htmlspecialchars($totalBids) ?> Bids</span>
                                <?php elseif ($totalBids > 0): ?>
                                    <span> <?= htmlspecialchars($totalBids) ?> Bid</span>
                                <?php else: ?>
                                    <span> 0 Bid</span>
                                <?php endif; ?>
                            <?php endif; ?>)
                        </p>

                        <!-- Fetch current highest bid -->
                        <p class="current-bid--highest">₱ <?php if (method_exists($auction, 'getBidHistory')): ?>
                            <?php if(!empty($auction->getBidHistory())) {
                                $amount = array_column($auction->getBidHistory(), 'bid_amount');
                                $highestBid = max($amount);
                                echo number_format($highestBid);
                            } else echo '0.00'; ?>
                            <?php else: ?>
                                0
                        <?php endif; ?></p>
                        
                    </div>
        
                    <div class="bidding__actions">
                        <button class="action__add-to-watchlist">Add to Watchlist</button>
                        <button class="action__place-bid">Place Bid</button>
                    </div>
                </div>
            </div>

            
        </div>
        
        <div class="auction__extra-details">
            <div class="auction__description">
                <h3>Description</h3>
                <p class="description__text" id="description"><?= nl2br(htmlspecialchars($auction->getDescription())) ?></p>
                <div class="toggle-container">
                    <button class="description__toggle" id="toggleDescription">Show More</button>
                </div>
            </div>
    
            <div class="auction__additional-info">
                <h3>Additional Information</h3>
                <div class="additional-info">
                    <p class="add-info-property">Seller</p>
                    <p><?= htmlspecialchars($auction->getSellerName()) ?></p>
                </div>
    
                <div class="additional-info">
                    <p class="add-info-property">Categories</p>
                     <?php if (!empty($auction->getCategories())): ?>
                        <p><?= implode(', ', array_map('htmlspecialchars', $auction->getCategories())) ?></p>
                    <?php else: ?>
                        <p>No categories listed.>
                    <?php endif; ?>
                </div>
    
                <div class="additional-info">
                    <p class="add-info-property">Payment Method</p>
                    <?php if (!empty($auction->getPaymentMethods())): ?>
                        <p><?= implode(', ', array_map('htmlspecialchars', $auction->getPaymentMethods())) ?></p>
                    <?php else: ?>
                        <p>No payment methods listed.</p>
                    <?php endif; ?>
                </div>
               
                <div class="additional-info">
                    <p class="add-info-property">Return Policy</p>
                    <p>7-Day Guarantee Return Policy</p>
                </div>
            </div>
        </div>

        <div class="auction__bid-history">
            <h3>Bid History</h3>
            <div class="bid-history__details">
                <p class="auction__lot">LOT# <span><?= htmlspecialchars($auction->getId()) ?></span> / Bid 
                    <?php if (method_exists($auction, 'getBidHistory')): ?>
                        <?php $totalBids = count($auction->getBidHistory()); ?>
                        <?php if ($totalBids > 0): ?>
                            <span><?= htmlspecialchars($totalBids) ?></span>
                        <?php else: ?>
                            <span>0</span>
                        <?php endif; ?>
                    <?php endif; ?>
                </p>
                
            </div>

            <?php if (method_exists($auction, 'getBidHistory') && !empty($auction->getBidHistory())): ?>
                <?php foreach ($auction->getBidHistory() as $bid): ?>
                    <table>
                        <thead>
                            <tr>
                                <th>User</th>
                                <th class="details__bid-time">Bid Date & Time</th>
                                <th>Bid Amount</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><?= htmlspecialchars(substr($bid['user_name'], 0, 2) . '*****') ?></td>
                                <td class="details__bid-time"><?= htmlspecialchars($bid['bid_time']) ?></td>
                                <td>₱<?= number_format($bid['bid_amount'], 2) ?></td>
                            </tr>
                        </tbody>
                    </table>
                <?php endforeach; ?>
            <?php else: ?>
                <p>No bids yet.</p>
            <?php endif; ?>
        </div>
    </main>
    <footer>
        <?php 
        require __DIR__ . "/../component/footer.php";
        ?>
    </header>
</body>
</html>