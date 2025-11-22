<?php
class Database {
    private static ?Database $instance = null; // Single instance
    private ?mysqli $connection = null;

    // Database credentials
    private string $host = "localhost";
    private string $username = "root";
    private string $password = "";
    private string $db_name = "web_dev";
    private int $port = 3307;

    // Private constructor prevents external instantiation
    private function __construct() {
        try {
            $this->connection = new mysqli(
                $this->host,
                $this->username,
                $this->password,
                $this->db_name,
                $this->port
            );

            if ($this->connection->connect_error) {
                die("Database connection failed: " . $this->connection->connect_error);
            }
        } catch(Exception $e) {
            die("$e");
        }
    }

    // Get the single instance
    public static function getInstance(): Database {
        if (self::$instance === null) {
            self::$instance = new Database();
        }
        return self::$instance;
    }

    // Get the MySQLi connection
    public function getConnection(): mysqli {
        return $this->connection;
    }

    // Prevent cloning
    private function __clone() {}

    // Prevent unserialization
    public function __wakeup() {
        throw new Exception("Cannot unserialize singleton");
    }
}
?>