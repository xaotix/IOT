-- --------------------------------------------------------
-- Servidor:                     mysql.dlmdev.com.br
-- Versão do servidor:           10.2.31-MariaDB-log - MariaDB Server
-- OS do Servidor:               Linux
-- HeidiSQL Versão:              11.1.0.6116
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para dlmdev
CREATE DATABASE IF NOT EXISTS `dlmdev` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `dlmdev`;

-- Copiando estrutura para tabela dlmdev.iot_log_temperaturas
CREATE TABLE IF NOT EXISTS `iot_log_temperaturas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dia` int(11) DEFAULT dayofmonth(current_timestamp()),
  `mes` int(11) DEFAULT month(current_timestamp()),
  `ano` int(11) DEFAULT year(current_timestamp()),
  `temperatura` varchar(30) NOT NULL DEFAULT '',
  `hora` time DEFAULT curtime(2),
  `porta` int(11) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4133 DEFAULT CHARSET=utf8;

-- Exportação de dados foi desmarcado.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
