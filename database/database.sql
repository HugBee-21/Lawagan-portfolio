CREATE DATABASE  IF NOT EXISTS `web_dev` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci */;
USE `web_dev`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: web_dev
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_admin_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (2);
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `announcement`
--

DROP TABLE IF EXISTS `announcement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `announcement` (
  `announcement_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `admin_user_id` int(10) unsigned NOT NULL,
  `title` varchar(255) NOT NULL DEFAULT 'N/A',
  `content` mediumtext NOT NULL,
  `date_posted` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`announcement_id`),
  KEY `fk_announcement_admin1_idx` (`admin_user_id`),
  CONSTRAINT `fk_announcement_admin` FOREIGN KEY (`admin_user_id`) REFERENCES `admin` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcement`
--

LOCK TABLES `announcement` WRITE;
/*!40000 ALTER TABLE `announcement` DISABLE KEYS */;
/*!40000 ALTER TABLE `announcement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auction_listing`
--

DROP TABLE IF EXISTS `auction_listing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auction_listing` (
  `listing_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `starting_bid` decimal(10,0) NOT NULL DEFAULT 0,
  `bid_increment` decimal(10,0) NOT NULL DEFAULT 0,
  `end_date` datetime NOT NULL,
  `buy_now_price` decimal(10,0) DEFAULT 0,
  `reserve` decimal(10,0) DEFAULT 0,
  PRIMARY KEY (`listing_id`),
  CONSTRAINT `fk_auction_listing_listing` FOREIGN KEY (`listing_id`) REFERENCES `listing` (`listing_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auction_listing`
--

LOCK TABLES `auction_listing` WRITE;
/*!40000 ALTER TABLE `auction_listing` DISABLE KEYS */;
INSERT INTO `auction_listing` VALUES (1,50000,100,'2025-10-30 14:11:22',0,0),(25,1000,11,'2025-11-19 04:57:53',40000,1000),(26,10,11,'2025-11-21 05:06:41',0,0),(27,10000,11,'2025-11-21 05:13:25',77990,0),(28,10,11,'2025-11-21 05:19:06',0,0),(29,10,11,'2025-11-19 05:21:11',450,0),(31,2000,11,'2025-11-17 05:26:51',15000,0),(32,500,11,'2025-11-21 05:29:45',0,0),(33,500,11,'2025-11-17 05:33:09',0,0),(34,500,11,'2025-11-15 05:35:50',5000,0);
/*!40000 ALTER TABLE `auction_listing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auction_listing_payyment_method`
--

DROP TABLE IF EXISTS `auction_listing_payyment_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auction_listing_payyment_method` (
  `auction_listing_id` int(10) unsigned NOT NULL,
  `payyment_method_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`auction_listing_id`,`payyment_method_id`),
  KEY `fk_payyment_method_has_auction_listing_auction_listing1_idx` (`auction_listing_id`),
  KEY `fk_auction_listing_payyment_method_payyment_method1_idx` (`payyment_method_id`),
  CONSTRAINT `fk_auction_listing_payyment_method_payyment_method` FOREIGN KEY (`payyment_method_id`) REFERENCES `payyment_method` (`payyment_method_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_payyment_method_has_auction_listing_auction_listing` FOREIGN KEY (`auction_listing_id`) REFERENCES `auction_listing` (`listing_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auction_listing_payyment_method`
--

LOCK TABLES `auction_listing_payyment_method` WRITE;
/*!40000 ALTER TABLE `auction_listing_payyment_method` DISABLE KEYS */;
INSERT INTO `auction_listing_payyment_method` VALUES (1,1),(1,2);
/*!40000 ALTER TABLE `auction_listing_payyment_method` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auction_transaction`
--

DROP TABLE IF EXISTS `auction_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auction_transaction` (
  `transaction_id` int(10) unsigned NOT NULL,
  `auction_listing_id` int(10) unsigned NOT NULL,
  `payyment_method_id` int(10) unsigned NOT NULL,
  `total_amount` decimal(10,0) NOT NULL DEFAULT 1,
  PRIMARY KEY (`transaction_id`),
  KEY `fk_auction_transaction_auction_listing1_idx` (`auction_listing_id`),
  KEY `fk_auction_transaction_payyment_method1_idx` (`payyment_method_id`),
  CONSTRAINT `fk_auction_transaction_auction_listing` FOREIGN KEY (`auction_listing_id`) REFERENCES `auction_listing` (`listing_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_auction_transaction_payyment_method` FOREIGN KEY (`payyment_method_id`) REFERENCES `payyment_method` (`payyment_method_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_auction_transaction_transaction` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`transaction_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auction_transaction`
--

LOCK TABLES `auction_transaction` WRITE;
/*!40000 ALTER TABLE `auction_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `auction_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bid`
--

DROP TABLE IF EXISTS `bid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bid` (
  `bid_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `auction_listing_id` int(10) unsigned NOT NULL,
  `bid_amount` decimal(10,0) NOT NULL DEFAULT 1,
  `bid_time` datetime NOT NULL DEFAULT current_timestamp(),
  `is_the_winner` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`bid_id`),
  KEY `fk_bid_auction_listing1_idx` (`auction_listing_id`),
  KEY `fk_bid_user1_idx` (`user_id`),
  CONSTRAINT `fk_bid_auction_listing` FOREIGN KEY (`auction_listing_id`) REFERENCES `auction_listing` (`listing_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_bid_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bid`
--

LOCK TABLES `bid` WRITE;
/*!40000 ALTER TABLE `bid` DISABLE KEYS */;
INSERT INTO `bid` VALUES (1,2,1,10000,'2025-10-25 17:10:37',0);
/*!40000 ALTER TABLE `bid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (5,'Accessories'),(8,'Apparel'),(6,'Appliances'),(7,'Books'),(1,'Electronics'),(3,'Instruments'),(9,'Office'),(4,'Sports'),(2,'Supplies');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `condition`
--

DROP TABLE IF EXISTS `condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `condition` (
  `condition_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`condition_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `condition`
--

LOCK TABLES `condition` WRITE;
/*!40000 ALTER TABLE `condition` DISABLE KEYS */;
INSERT INTO `condition` VALUES (3,'Fair'),(4,'For Parts'),(1,'New'),(2,'Used');
/*!40000 ALTER TABLE `condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `condition_id` int(10) unsigned DEFAULT 1,
  `title` varchar(255) NOT NULL,
  `description` mediumtext NOT NULL,
  `image_urls` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]' CHECK (json_valid(`image_urls`)),
  PRIMARY KEY (`item_id`),
  KEY `fk_item_user1_idx` (`user_id`),
  KEY `fk_item_condition1_idx` (`condition_id`),
  CONSTRAINT `fk_item_condition` FOREIGN KEY (`condition_id`) REFERENCES `condition` (`condition_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_item_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (1,1,1,'MacBook Air (M1,2020)','MacBook Air M1 2020\nRose Gold\n\n100%Smooth \n85% Battery Health \nNo scratches \nNo issue\n\nCHIP: Apple M1\nMEMORY: 8GB\nSTORAGE: 512 GB\nDISPLAY: 13-inch\nINCLUSION: Cable\n*with free bag\n\nGOOD FOR: \n-online class\n-work from home\n-graphic designing\n-virtual assistant','[\"assets/images/auction/demo/auction-demo-1.png\", \"assets/images/auction/demo/auction-demo-2.png\", \"assets/images/auction/demo/auction-demo-3.png\", \"assets/images/auction/demo/auction-demo-4.png\"]'),(2,1,1,'IPhone 16','132123123','[\"assets/images/placeholder.png\"]'),(27,1,2,'HP Victus 15-FB1057AX (B45TXPA) 15.6″ FHD IPS 144Hz | Ryzen 5 7535HS | 8GB DDR4 | RTX 2050 | 512GB S','Operating system: Windows 11 Home Single Language\r\nProcessor family: AMD Ryzen™ 5 processor\r\nProcessor: AMD Ryzen™ 5 7535HS (up to 4.55 GHz max boost clock, 16 MB L3 cache, 6 cores, 12 threads)\r\nChipset: AMD Integrated SoC\r\nGraphics (discrete): NVIDIA® GeForce RTX™ 2050 Laptop GPU (4 GB GDDR6 dedicated)\r\nMemory: 8GB DDR4 RAM\r\nCloud service: 25 GB Dropbox storage for 12 months\r\nInternal Storage: 512 GB PCIe® Gen4 NVMe™ M.2 SSD\r\nDisplay: 39.6 cm (15.6″) diagonal, FHD (1920 x 1080), 144 Hz, IPS, micro-edge, anti-glare, 250 nits, 45% NTSC\r\nDisplay size (diagonal): 39.6 cm (15.6″)\r\nScreen-to-body ratio (without speakers): 82.23%\r\nSlots: 1 multi-format SD media card reader\r\nPorts: 1 USB Type-C® 5Gbps signaling rate (DisplayPort™ 1.4, HP Sleep and Charge); 1 USB Type-A 5Gbps signaling rate (HP Sleep and Charge); 1 USB Type-A 5Gbps signaling rate; 1 AC smart\r\npin; 1 HDMI 2.1; 1 headphone/microphone combo; 1 RJ-45\r\nNetwork interface: Integrated 10/100/1000 GbE LAN\r\nWireless: MediaTek Wi-Fi 6 MT7921 (2×2) and Bluetooth® 5.3 wireless card (supporting gigabit data rate) MU-MIMO supported; Modern Standby (Connected)\r\nAudio: Audio by B&O; Dual speakers; HP Audio Boost\r\nKeyboard: Full-size, backlit, mica silver keyboard with numeric keypad\r\nPointing device: HP Imagepad with multi-touch gesture support\r\nCamera: HP Wide Vision 720p HD camera with temporal noise reduction and integrated dual array digital microphones\r\nBattery type: 3-cell, 52.5 Wh Li-ion polymer [23]\r\nPower supply type: 135 W AC power adapter\r\nSustainable impact specifications: Ocean-bound plastic in speaker enclosure(s) and bezel; Keyboard keycaps and scissors contain post-consumer recycled plastic [39,41]\r\nEnergy star certified: ENERGY STAR® certified\r\nSecurity management: Trusted Platform Module (Firmware TPM) support\r\nAccessory: HP Preload 15.6 Topload Sling Bag','[\"server_storage/images/Victus-Gaming-Laptop-15-fa1323TX_6916a8c1098c2.jpg\",\"server_storage/images/Victus-Gaming-Laptop-15-fa1323TX-11-Copy_6916a8c10f240.jpg\",\"server_storage/images/Victus-Gaming-Laptop-15-fa1323TX-1_6916a8c10f740.jpg\",\"server_storage/images/Victus-Gaming-Laptop-15-fa1323TX-10_6916a8c10fea1.jpg\",\"server_storage/images/Victus-Gaming-Laptop-15-fa1323TX-2_6916a8c110302.jpg\"]'),(28,1,1,'Casio fx-991CW Scientific Calculator','Casio FX-991CW Advanced Scientific Calculator | CLASSWIZ | Complex Number Calculation Calculators\r\n\r\nProduct features - Non Programmable, Non Graphing\r\nNumber of digits - 10 + 2 digits\r\nLiquid crystal display - Natural textbook display, Icon menu, Dot matrix display\r\nHigh Resolution, 4-gradation display\r\nKey characteristics -Plastic keys\r\nKey functions - Negative Sign, Power Off\r\nMemory - Variables: 9, Variables List\r\nAnswer Memory, Function memory\r\nMemory Protection, Reset Function\r\nPower supply - Solar & Battery\r\nApproximate battery life Main 2 years\r\nAuto Power Off\r\nSize (D × W × H) -162 × 77 × 10.7 mm\r\nWeight - 95 g\r\nAccessories - Hard Case','[\"server_storage/images/image_2025-11-14_120515404_6916aad1e059b.png\",\"server_storage/images/image_2025-11-14_120522575_6916aad1e64f5.png\"]'),(29,1,1,'iPhone 16 Pro Max','\r\niPhone 16 Pro Max. Featuring a stunning titanium design. Camera Control. 4K 120 fps Dolby Vision. And the A18 Pro chip.\r\n\r\nFeatures\r\nSTUNNING TITANIUM DESIGN—iPhone 16 Pro Max has a strong and light titanium design with a larger 6.9-inch Super Retina XDR display. It’s remarkably durable with the latest-generation Ceramic Shield material that’s 2x tougher than any smartphone glass.\r\nTAKE TOTAL CAMERA CONTROL—Camera Control gives you an easier way to quickly access camera tools, like zoom or depth of field, so you can take the perfect shot in record time.\r\nMAGNIFICENT SHOTS—Thanks to a more advanced 48MP Ultra Wide camera, you can capture mesmerizing detail in macro and sweeping, wide-angle photos. Want sharper shots from farther away? The 5x Telephoto camera makes it easy.\r\nPRO VIDEO—Take your videos a whole new level with 4K 120 fps Dolby Vision—enabled by the 48MP Fusion camera—and studio-quality mics for higher-quality audio recording. A Pro studio in your pocket.\r\nPHOTOGRAPHIC STYLES—The latest-generation Photographic Styles give you greater creative flexibility, so you can make every photo even more you. And thanks to advances in the image pipeline, you can now reverse any style, any time.\r\nTHE POWER OF A18 PRO— A18 Pro chip enables advanced photo and video features like Camera Control, and delivers exceptional graphics performance for AAA gaming.\r\nA HUGE LEAP IN BATTERY LIFE—iPhone 16 Pro Max delivers an incredibly power-efficient performance with up to 33 hours video playback. Charge via USB-C or snap on a MagSafe charger for faster wireless charging.\r\nCUSTOMIZE YOUR IPHONE—With iOS 18 you can tint your Home Screen icons with any color. Find your favorite shots faster in the redesigned Photos app. And add playful, animated effects to any word, phrase, or emoji in iMessage.\r\nVITAL SAFETY FEATURES—With Crash Detection, iPhone can detect a severe car crash and call for help if you can’t.\r\n\r\nIn The Box\r\niPhone 16 Pro Max\r\nUSB-C Charge Cable\r\n\r\nWarranty\r\nManufacturer\'s Warranty - Labor\r\nApple One (1) Year Limited Warranty\r\nManufacturer\'s Warranty - Parts\r\nApple One (1) Year Limited Warranty','[\"server_storage/images/image_2025-11-14_121240840_6916ac6522ebe.png\",\"server_storage/images/image_2025-11-14_121255293_6916ac65237d3.png\",\"server_storage/images/image_2025-11-14_121305401_6916ac6524203.png\",\"server_storage/images/image_2025-11-14_121322309_6916ac6526f4a.png\"]'),(30,1,2,' Aquatics Uniform','- sizes on tag: rashguard (small), tights (medium)\r\n- selling price: ₱400.00 only!\r\n- condition: 9/10 (with minimal pink stains from chlorine sa water ng pool, pero hindi naman super visible)','[\"server_storage/images/image_2025-11-14_121737123_6916adba921c4.png\",\"server_storage/images/image_2025-11-14_121903451_6916adba96454.png\"]'),(31,1,2,'PE Uniform','Size: Medium','[\"server_storage/images/image_2025-11-14_122038257_6916ae3706371.png\"]'),(32,1,1,'PE Uniform (Medium)','Size: Medium','[\"server_storage/images/image_2025-11-14_122337023_6916aecddc5bf.png\"]'),(33,1,2,'RTX 4060 Gigabyte Windforce 8GB Graphics Card | Alternate Spinning | Collinx Computer','• Graphics Processing: GeForce RTX™ 4060 \r\n\r\n• Core Clock: 2475 MHz (Reference card: 2460 MHz) \r\n\r\n• CUDA® Cores: 3072 \r\n\r\n• Memory Clock: 17 Gbps \r\n\r\n• Memory Size: 8 GB \r\n\r\n• Memory Type: GDDR6 \r\n\r\n• Memory Bus: 128 bit \r\n\r\n• Card Bus: PCI-E 4.0 \r\n\r\n• Digital max resolution: 7680x4320 \r\n\r\n• Multi-view: 4 \r\n\r\n• Card size: L=192 W=120 H=41 mm \r\n\r\n• PCB Form: ATX \r\n\r\n• DirectX: 12 Ultimate \r\n\r\n• OpenGL: 4.6 \r\n\r\n• Recommended PSU: 450W \r\n\r\n• Power Connectors: 8 pin*1 \r\n\r\n• Output: DisplayPort 1.4a*2 | HDMI 2.1a*2 \r\n\r\n• Accessories: Quick guide','[\"server_storage/images/image_2025-11-14_122644537_6916af8bbd202.png\"]'),(34,1,2,'Intel® Core i7 10700 16M Cache, up to 4.80 GHz Processor','# of Cores8\r\n# of Threads16\r\nProcessor Base Frequency2.90 GHz\r\nMax Turbo Frequency4.80 GHz\r\nCache16 MB Intel® Smart Cache\r\nBus Speed8 GT/s\r\nIntel® Turbo Boost Max Technology 3.0 Frequency ‡4.80 GHz\r\nTDP65 W','[\"server_storage/images/image_2025-11-14_122843585_6916b03998ac0.png\"]'),(35,1,2,'AMD Ryzen 5 3500X 6-Core 3.6~4.1Ghz Processor','6 CORES/6 Threads\r\n3.6 GHZ Clock Speed\r\nTurbo Speed:4.1 GHz\r\nAM4 Socket\r\nTDP: 65 W\r\nAMD wraith Stealth cooler','[\"server_storage/images/image_2025-11-14_123302718_6916b1052c7bd.png\"]'),(36,1,1,'Keychron K6 RGB Lightning / Aluminum / Wireless & Wired/ Hot-swap Blue Mechanical Keyboard K6W2','Number of Keys: 68 keys\r\nSwitches: Gateron mechanical / LK optical\r\nNumber of Multimedia Keys: 12\r\nFrame Material: Aluminum\r\nKeycap Material: ABS\r\nKeycap Profile: OEM\r\nLayout: ANSI','[\"server_storage/images/image_2025-11-14_123515662_6916b1a677573.png\"]');
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_category`
--

DROP TABLE IF EXISTS `item_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_category` (
  `category_id` int(10) unsigned NOT NULL,
  `item_item_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`category_id`,`item_item_id`),
  KEY `fk_category_has_item_item1_idx` (`item_item_id`),
  KEY `fk_category_has_item_category1_idx` (`category_id`),
  CONSTRAINT `fk_item_category_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_item_category_item` FOREIGN KEY (`item_item_id`) REFERENCES `item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_category`
--

LOCK TABLES `item_category` WRITE;
/*!40000 ALTER TABLE `item_category` DISABLE KEYS */;
INSERT INTO `item_category` VALUES (1,1),(1,2),(1,27),(1,28),(1,29),(1,33),(1,34),(1,35),(1,36),(2,1),(2,2),(3,1),(3,2),(4,30),(4,31),(4,32);
/*!40000 ALTER TABLE `item_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listing`
--

DROP TABLE IF EXISTS `listing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `listing` (
  `listing_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned NOT NULL,
  `status` enum('TO_BE_REVIEWED','ACTIVE','REMOVED','INACTIVE') NOT NULL DEFAULT 'TO_BE_REVIEWED',
  `type` enum('AUCTION','SWAP') NOT NULL,
  `listed_on` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`listing_id`,`item_id`),
  KEY `fk_listing_item1_idx` (`item_id`),
  CONSTRAINT `fk_listing_item` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listing`
--

LOCK TABLES `listing` WRITE;
/*!40000 ALTER TABLE `listing` DISABLE KEYS */;
INSERT INTO `listing` VALUES (1,1,'ACTIVE','AUCTION','2025-10-25 12:11:22'),(2,2,'ACTIVE','SWAP','2025-10-25 14:55:53'),(25,27,'ACTIVE','AUCTION','2025-11-14 11:57:53'),(26,28,'ACTIVE','AUCTION','2025-11-14 12:06:41'),(27,29,'ACTIVE','AUCTION','2025-11-14 12:13:25'),(28,30,'ACTIVE','AUCTION','2025-11-14 12:19:06'),(29,31,'ACTIVE','AUCTION','2025-11-14 12:21:11'),(30,32,'ACTIVE','SWAP','2025-11-14 12:23:41'),(31,33,'ACTIVE','AUCTION','2025-11-14 12:26:51'),(32,34,'ACTIVE','AUCTION','2025-11-14 12:29:45'),(33,35,'ACTIVE','AUCTION','2025-11-14 12:33:09'),(34,36,'ACTIVE','AUCTION','2025-11-14 12:35:50');
/*!40000 ALTER TABLE `listing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payyment_method`
--

DROP TABLE IF EXISTS `payyment_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payyment_method` (
  `payyment_method_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`payyment_method_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payyment_method`
--

LOCK TABLES `payyment_method` WRITE;
/*!40000 ALTER TABLE `payyment_method` DISABLE KEYS */;
INSERT INTO `payyment_method` VALUES (2,'GCash'),(3,'PayMaya'),(4,'PayPal'),(1,'Visa');
/*!40000 ALTER TABLE `payyment_method` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proposed_swap`
--

DROP TABLE IF EXISTS `proposed_swap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proposed_swap` (
  `proposed_swap_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `swap_listing_id` int(10) unsigned NOT NULL,
  `item_id_to_be_swapped` int(10) unsigned NOT NULL,
  `status` enum('TO_BE_REVIEWED','REJECTED','ACCEPTED') NOT NULL DEFAULT 'TO_BE_REVIEWED',
  `remarks` mediumtext DEFAULT NULL,
  `proposed_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`proposed_swap_id`),
  KEY `fk_proposed_swap_swap_listing1_idx` (`swap_listing_id`),
  KEY `fk_proposed_swap_item1_idx` (`item_id_to_be_swapped`),
  CONSTRAINT `fk_proposed_swap_item` FOREIGN KEY (`item_id_to_be_swapped`) REFERENCES `item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_proposed_swap_swap_listing` FOREIGN KEY (`swap_listing_id`) REFERENCES `swap_listing` (`listing_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proposed_swap`
--

LOCK TABLES `proposed_swap` WRITE;
/*!40000 ALTER TABLE `proposed_swap` DISABLE KEYS */;
/*!40000 ALTER TABLE `proposed_swap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `user_id` int(10) unsigned NOT NULL,
  `student_school_id` varchar(7) NOT NULL,
  `is_banned` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_student_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (1,'2222222',0);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `swap_listing`
--

DROP TABLE IF EXISTS `swap_listing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `swap_listing` (
  `listing_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `looking_for_description` mediumtext NOT NULL,
  `is_open_to_any_offer` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`listing_id`),
  CONSTRAINT `fk_swap_listing_listing` FOREIGN KEY (`listing_id`) REFERENCES `listing` (`listing_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `swap_listing`
--

LOCK TABLES `swap_listing` WRITE;
/*!40000 ALTER TABLE `swap_listing` DISABLE KEYS */;
INSERT INTO `swap_listing` VALUES (2,'Samsung S10000',0),(30,'PE Uniform (Large)',0);
/*!40000 ALTER TABLE `swap_listing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `swap_transaction`
--

DROP TABLE IF EXISTS `swap_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `swap_transaction` (
  `transaction_id` int(10) unsigned NOT NULL,
  `proposed_swap_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `fk_swap_transaction_proposed_swap1_idx` (`proposed_swap_id`),
  CONSTRAINT `fk_swap_transaction_proposed_swap` FOREIGN KEY (`proposed_swap_id`) REFERENCES `proposed_swap` (`proposed_swap_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_swap_transaction_transaction` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`transaction_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `swap_transaction`
--

LOCK TABLES `swap_transaction` WRITE;
/*!40000 ALTER TABLE `swap_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `swap_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `buyer_id` int(10) unsigned NOT NULL,
  `date_of_transaction` datetime NOT NULL DEFAULT current_timestamp(),
  `type` enum('AUCTION','SWAP') NOT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `fk_transaction_user1_idx` (`buyer_id`),
  CONSTRAINT `fk_transaction_user` FOREIGN KEY (`buyer_id`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varbinary(255) NOT NULL,
  `salt` varbinary(255) NOT NULL,
  `profile_picture_url` varchar(560) DEFAULT NULL,
  `role` enum('STUDENT','ADMIN') NOT NULL DEFAULT 'ADMIN',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `full_name_UNIQUE` (`full_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Aldyn Lawagan','aldy@mail.com',_binary '123',_binary '123','server_storage/profile_pics/566526925_795714549753745_3598499687424258548_n.jpg','STUDENT','2025-10-25 12:02:06'),(2,'Maurice','maurice@mail.com',_binary '123',_binary '123','server_storage/profile_pics/566526925_795714549753745_3598499687424258548_n.jpg','ADMIN','2025-10-25 12:02:06');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_watchlist`
--

DROP TABLE IF EXISTS `user_watchlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_watchlist` (
  `auction_listing_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`auction_listing_id`,`user_id`),
  KEY `fk_auction_listing_has_student_user1_idx` (`user_id`),
  KEY `fk_user_watchlist_auction_listing1_idx` (`auction_listing_id`),
  CONSTRAINT `fk_user_watchlist_auction_listing` FOREIGN KEY (`auction_listing_id`) REFERENCES `auction_listing` (`listing_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_watchlist_listing_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_watchlist`
--

LOCK TABLES `user_watchlist` WRITE;
/*!40000 ALTER TABLE `user_watchlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_watchlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'web_dev'
--
/*!50003 DROP PROCEDURE IF EXISTS `create_new_auction_listing` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_new_auction_listing`(
	in puser_id int, 
    in pcondition_id int, 
    in ptitle varchar(100), 
    in pdescription text, 
    in pimages json,  
    in preserve int, 
    in pbuy_now decimal, 
    in pstarting_bid decimal,
    in pbid_increment decimal,
    in pend_date datetime,
    in pcategory int -- Temporary
)
BEGIN
	declare new_id INT;
    
	insert into item(user_id, condition_id, title, `description`, image_urls)
    values (puser_id, pcondition_id, ptitle, pdescription, pimages);
    
	set new_id = LAST_INSERT_ID();
    
	-- Temporary
    insert into item_category(category_id, item_item_id)
    values (pcategory, new_id);
    
    insert into listing(item_id, `status`, `type`)
    values (new_id, 'ACTIVE', 'AUCTION');	-- Temporary
    
    set new_id = LAST_INSERT_ID();
    
    insert into auction_listing(listing_id, starting_bid, bid_increment, end_date, buy_now_price, reserve)
    values (new_id, pstarting_bid, pbid_increment, pend_date, pbuy_now, preserve);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_new_swap_listing` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_new_swap_listing`(
	in puser_id int, 
    in pcondition_id int, 
    in ptitle varchar(100), 
    in pdescription text, 
    in pimages json, 
    in plooking_for text,
    in pis_open_to_any_offer tinyint,
	in pcategory int -- Temporary
)
BEGIN
	declare new_id INT;
    
	insert into item(user_id, condition_id, title, `description`, image_urls)
    values (puser_id, pcondition_id, ptitle, pdescription, pimages);
    
	set new_id = LAST_INSERT_ID();
    
	-- Temporary
	insert into item_category(category_id, item_item_id)
    values (pcategory, new_id);
    
    insert into listing(item_id, `status`, `type`)
    values (new_id, 'ACTIVE', 'SWAP');	-- Temporary
    
    set new_id = LAST_INSERT_ID();
    
    insert into swap_listing(listing_id, looking_for_description, is_open_to_any_offer)
    values (new_id, plooking_for, pis_open_to_any_offer);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_auction_listing` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_auction_listing`(in auction_id int)
BEGIN
	SELECT 
		l.listing_id,
		i.title,
		i.description,
        i.image_urls,
		al.buy_now_price,
        al.bid_increment,
		al.end_date,
		c.name AS condition_name,
		u.full_name AS seller_name,

		-- Aggregate watchers count
		COUNT(DISTINCT uw.user_id) AS watchers,

		-- Aggregate payment methods
		GROUP_CONCAT(DISTINCT pm.name ORDER BY pm.name SEPARATOR ', ') AS payment_methods,

		-- Aggregate categories
		GROUP_CONCAT(DISTINCT cat.name ORDER BY cat.name SEPARATOR ', ') AS categories
	FROM auction_listing AS al

	-- Join with main listing table
	JOIN listing AS l 
		ON l.listing_id = al.listing_id

	-- Item + condition
	JOIN item AS i 
		ON i.item_id = l.item_id
	JOIN `condition` AS c 
		ON c.condition_id = i.condition_id
		
	-- Seller
	JOIN user AS u 
		ON u.user_id = i.user_id

	-- Watchlist
	LEFT JOIN user_watchlist AS uw 
		ON uw.auction_listing_id = al.listing_id

	-- Payment methods
	LEFT JOIN auction_listing_payyment_method AS alp 
		ON alp.auction_listing_id = al.listing_id
	LEFT JOIN payyment_method AS pm 
		ON pm.payyment_method_id = alp.payyment_method_id

	-- Categories
	LEFT JOIN item_category AS ic 
		ON ic.item_item_id = i.item_id
	LEFT JOIN category AS cat 
		ON cat.category_id = ic.category_id

	WHERE al.listing_id = auction_id
	GROUP BY 
		al.listing_id,
		i.title,
        i.image_urls,
		i.description,
        al.bid_increment,
		al.buy_now_price,
		al.end_date,
		c.name,
		u.full_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_bid_history` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_bid_history`(in auction_id int)
BEGIN
	SELECT 
		b.bid_amount,
		b.bid_time,
		b.is_the_winner,
		u.full_name AS user_name
	FROM bid AS b
	JOIN user AS u 
		ON u.user_id = b.user_id
	WHERE b.auction_listing_id = auction_id
	ORDER BY b.bid_time DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_swap_listing` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_swap_listing`(in swap_id int)
BEGIN
	SELECT 
		l.listing_id,
		i.title,
		i.description,
        i.image_urls,
		c.name AS condition_name,
		u.full_name AS seller_name,
		sl.looking_for_description,
		sl.is_open_to_any_offer,
        l.listed_on,
        
		-- Aggregate categories
		GROUP_CONCAT(DISTINCT cat.name ORDER BY cat.name SEPARATOR ', ') AS categories
	FROM swap_listing AS sl
    
	-- Join with main listing table
	JOIN listing AS l 
		ON l.listing_id = sl.listing_id

	-- Item + condition
	JOIN item AS i 
		ON i.item_id = l.item_id
	JOIN `condition` AS c 
		ON c.condition_id = i.condition_id
		
	-- Seller
	JOIN user AS u 
		ON u.user_id = i.user_id

	-- Categories
	LEFT JOIN item_category AS ic 
		ON ic.item_item_id = i.item_id
	LEFT JOIN category AS cat 
		ON cat.category_id = ic.category_id

	WHERE sl.listing_id = swap_id
	GROUP BY 
		sl.listing_id,
		i.title,
        i.image_urls,
		i.description,
		sl.looking_for_description,
		sl.is_open_to_any_offer,
        l.listed_on,
		c.name,
		u.full_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-15  0:52:09
