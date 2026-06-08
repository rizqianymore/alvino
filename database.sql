CREATE DATABASE IF NOT EXISTS `pergudangan`;
USE `pergudangan`;

CREATE TABLE IF NOT EXISTS `users` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(100) NOT NULL,
  `username` VARCHAR(50) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  `role` ENUM('Staff', 'Warehouse Manager') NOT NULL,
  `phone` VARCHAR(20) DEFAULT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `categories` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `category_name` VARCHAR(100) NOT NULL UNIQUE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `suppliers` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `supplier_name` VARCHAR(100) NOT NULL,
  `address` TEXT NOT NULL,
  `phone_number` VARCHAR(20) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `items` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `category_id` INT NOT NULL,
  `nama_barang` VARCHAR(100) NOT NULL,
  `kode_barang` VARCHAR(50) NOT NULL UNIQUE,
  `deskripsi` TEXT DEFAULT NULL,
  `stok` INT NOT NULL DEFAULT 0,
  `price` DECIMAL(15, 2) NOT NULL DEFAULT 0,
  `foto` VARCHAR(255) DEFAULT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `transactions` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT NOT NULL,
  `item_id` INT NOT NULL,
  `supplier_id` INT DEFAULT NULL,
  `tanggal` DATE NOT NULL,
  `qty` INT NOT NULL,
  `tipe` ENUM('Masuk', 'Keluar') NOT NULL,
  `keterangan` TEXT DEFAULT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE,
  FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Seed default users (password: staff123 / manager123)
INSERT INTO `users` (`name`, `username`, `password`, `role`, `phone`)
VALUES
('Petugas Staff', 'staff', '$2y$12$8CKJG9j48PiQwYrQ/yfWG.BMktFiFbqCvL3AmLV1Lg4d7/goI0A9O', 'Staff', '08123456789'),
('Warehouse Manager', 'manager', '$2y$12$ncHHFNg8k2Dq/NjmAXK/WOOVs/O8OBPRRL546audXKG/cnFw/z0s.', 'Warehouse Manager', '08123456780')
ON DUPLICATE KEY UPDATE `id`=`id`;
