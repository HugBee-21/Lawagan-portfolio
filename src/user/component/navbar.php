<?php 
// Temporary Values
$profile_pic_link = "/ConMatrix-WebDev/assets/images/placeholder.png"; 
$username = "Maurice Tay-og";
?>

<nav class="navbar">
     <img class="navbar-logo" src="/ConMatrix-WebDev/assets/images/placeholder.png" alt="Logo">

     <ul class="navbar-links">
          <li><a class="<?= ($active == 0) ? 'current' : '' ?>" href="/ConMatrix-WebDev/home">Browse Items</a></li>
          <li><a class="<?= ($active == 1) ? 'current' : '' ?>" href="/ConMatrix-WebDev/auction">Auction</a></li>
          <li><a class="<?= ($active == 2) ? 'current' : '' ?>" href="/ConMatrix-WebDev/swap">Swap</a></li>
     </ul>

     <div class="navbar-right-content">
          <div class="navbar-icons">
               <?php 
                    include __DIR__ . '/../../../assets/icons/message.svg'; 
                    include __DIR__ . '/../../../assets/icons/notification.svg'; 
               ?>
          </div>

          <div class="navbar-right-content-dropdown">
               <button class="dropdown-toggle">
                    <img src="<?php echo $profile_pic_link; ?>" alt="Profile Pic" class="profile-pic">
                    <p><?php echo htmlspecialchars($username); ?></p>
                    <i class="arrow-down"></i>
               </button>

               <div class="dropdown-menu">
                    <button id="create-listing-triggr">Create Listing</button>
                    <button href="logout">Logout</button>
               </div>
          </div>
     </div>
</nav>

<?php require "create_listing.php" ?>
<script defer src="/ConMatrix-WebDev/assets/js/create_listing.js"></script>
<script defer src="/ConMatrix-WebDev/assets/js/navbar.js"></script>