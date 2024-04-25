-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.28-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table roy_minimarket.produk
CREATE TABLE IF NOT EXISTS `produk` (
  `id_produk` int(11) NOT NULL AUTO_INCREMENT,
  `nama_produk` varchar(50) NOT NULL,
  `harga_beli` decimal(10,2) NOT NULL,
  `harga_jual` decimal(10,2) NOT NULL,
  `stok` int(11) NOT NULL,
  `deskripsi` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_produk`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table roy_minimarket.produk: ~3 rows (approximately)
INSERT INTO `produk` (`id_produk`, `nama_produk`, `harga_beli`, `harga_jual`, `stok`, `deskripsi`) VALUES
	(1, 'Pasta Gigi', 10000.00, 15000.00, 5, 'Pasta Gigi Peps***nt kemasan 500ml'),
	(2, 'Fris**n Fl*g SKM Sachet', 5000.00, 10000.00, 12, 'Susu kental manis kemasan sachet'),
	(3, 'Minyak Goreng Bim*li 850ml', 5000.00, 10000.00, 10, 'Minyak goreng plastik kemasan 850ml');

-- Dumping structure for table roy_minimarket.transaksi
CREATE TABLE IF NOT EXISTS `transaksi` (
  `id_transaksi` int(11) NOT NULL AUTO_INCREMENT,
  `id_produk` int(11) NOT NULL,
  `tanggal_transaksi` date NOT NULL,
  `jml_transaksi` int(11) NOT NULL,
  PRIMARY KEY (`id_transaksi`),
  KEY `fk_produk_transaksi` (`id_produk`),
  CONSTRAINT `fk_produk_transaksi` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table roy_minimarket.transaksi: ~3 rows (approximately)
INSERT INTO `transaksi` (`id_transaksi`, `id_produk`, `tanggal_transaksi`, `jml_transaksi`) VALUES
	(1, 1, '2024-04-12', 5),
	(2, 2, '2024-04-12', 8),
	(3, 3, '2024-04-12', 10);

-- Dumping structure for trigger roy_minimarket.kurangi_stok
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE trigger kurangi_stok
after insert on transaksi
for each row
begin
    declare jumlah_terjual int;
    declare id_produk_terjual int;
    select new.jml_transaksi, new.id_produk into jumlah_terjual, id_produk_terjual;
    update produk
    set stok = stok - jumlah_terjual
    where id_produk = id_produk_terjual;
end//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
