<?php
require_once __DIR__ . '/../../database.php';
try {
    $db = Database::getInstance()->getConnection();

    // --- Fetch categories ---
    $cl_categories = [];
    $stmt = $db->prepare("SELECT category_id, name FROM category ORDER BY name ASC");
    if ($stmt->execute()) {
        $result = $stmt->get_result();
        while ($row = $result->fetch_assoc()) {
            $cl_categories[] = $row;
        }
        $stmt->close();
    }

    // --- Fetch conditions ---
    $cl_conditions = [];
    $stmt = $db->prepare("SELECT condition_id, name FROM `condition` ORDER BY name ASC");
    if ($stmt->execute()) {
        $result = $stmt->get_result();
        while ($row = $result->fetch_assoc()) {
            $cl_conditions[] = $row;
        }
        $stmt->close();
    }
    
} catch (Exception $e) {
    echo "<p>Error: " . htmlspecialchars($e->getMessage()) . "</p>";
}
?>

<form id="create-listing" class="overlay">
    <div id="create-listing-form" class="grid-container row1">
        <!-- Left: Image Upload -->
        <div class="upload-section">
            <label for="images" class="upload-box">
                <?php include __DIR__ . '/../../../assets/icons/upload_icon.svg';  ?>
                <span class="upload-header">Upload your image here</span>
                <span class="upload-text">JPEG, PNG, MP4</span>
                
                <span class="upload-btn">Browse file</span>
                <input type="file" id="images" name="images[]" accept=".jpg,.jpeg,.png,.mp4" multiple hidden>
            </label>
            
            <div id="preview-container"></div>
        </div>

        <!-- Right: Auction Form -->
        <div class="form-section">
            <div class="toggle">
                <button type="button" class="toggle-btn active" data-type="auction">Auction</button>
                <button type="button" class="toggle-btn" data-type="swap">Swap</button>
            </div>

            <label for="title">Title</label>
            <input type="text" name="title" placeholder="Add a title for your listing" maxlength="255" required>

            <label for="description">Description</label>
            <textarea name="description" placeholder="Write a short description" required></textarea>

            <div class="row">
                <div>
                    <label for="category">Category</label>
                    <select name="category" required>
                        <option selected disabled value="">Choose item category</option>
                        <?php foreach ($cl_categories as $category): ?>
                            <option value="<?= htmlspecialchars($category['category_id']) ?>">
                                <?= htmlspecialchars($category['name']) ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div>
                    <label for="condition">Condition</label>
                    <select name="condition" required>
                        <option selected disabled value="">Choose item condition</option>
                        <?php foreach ($cl_conditions as $condition): ?>
                            <option value="<?= htmlspecialchars($condition['condition_id']) ?>">
                                <?= htmlspecialchars($condition['name']) ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>
            </div>

            <label class="create-auction-element" for="starting_bid">Starting Bid</label>
            <input class="create-auction-element" type="number" name="starting_bid" placeholder="₱0" required>

            <div class="row create-auction-element">
                <div>
                    <label class="create-auction-element" for="reserve_price">Reserve Price (Optional)</label>
                    <input class="create-auction-element" type="number" name="reserve_price" placeholder="₱0">
                </div>
                <div>
                    <label class="create-auction-element" for="buy_now_price">Buy Now Price (Optional)</label>
                    <input class="create-auction-element" type="number" name="buy_now_price" placeholder="₱0">
                </div>
            </div>

            <label class="create-auction-element" for="duration">Time Duration</label>
            <select class="create-auction-element" name="duration" required>
                <option value="1">1 Day</option>
                <option value="3">3 Days</option>
                <option value="5">5 Days</option>
                <option value="7">7 Days</option>
            </select>

            <label class="create-swap-element remove" for="looking_for" disabled>Looking For</label>
            <textarea class="create-swap-element remove" name="looking_for" placeholder="Write a short description" maxlength="100" required disabled></textarea>

            <div class="create-swap-element remove">
                <label class="switch-label create-swap-element remove">
                    <span>Open to Any Offers</span>
                    <label class="switch">
                        <input class="create-swap-element remove" type="checkbox" name="open_to_offers" disabled>
                        <span class="slider"></span>
                    </label>
                </label>
            </div>


            <div class="actions">
                <button type="button" class="cancel-btn">Cancel</button>
                <button type="submit" class="submit-btn">Submit</button>
            </div>
        </div>
    </div>
</form>