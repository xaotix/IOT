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

-- Copiando estrutura para view dlmdev.iot_log_acessos
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `iot_log_acessos` (
	`dia` INT(11) NULL,
	`mes` INT(11) NULL,
	`ano` INT(11) NULL,
	`data` DATE NULL,
	`pessoas` BIGINT(21) NOT NULL,
	`max` VARCHAR(30) NULL COLLATE 'utf8_general_ci',
	`min` VARCHAR(30) NULL COLLATE 'utf8_general_ci',
	`porta` INT(11) NULL
) ENGINE=MyISAM;

-- Copiando estrutura para view dlmdev.iot_log_acessos
-- Removendo tabela temporária e criando a estrutura VIEW final
DROP TABLE IF EXISTS `iot_log_acessos`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `iot_log_acessos` AS select `pr`.`dia` AS `dia`,`pr`.`mes` AS `mes`,`pr`.`ano` AS `ano`,str_to_date(concat(`pr`.`dia`,'/',`pr`.`mes`,'/',`pr`.`ano`),'%d/%m/%Y') AS `data`,count(`pr`.`temperatura`) AS `pessoas`,max(`pr`.`temperatura`) AS `max`,min(`pr`.`temperatura`) AS `min`,`pr`.`porta` AS `porta` from `iot_log_temperaturas` `pr` group by `pr`.`dia`,`pr`.`mes`,`pr`.`ano` order by str_to_date(concat(`pr`.`dia`,'/',`pr`.`mes`,'/',`pr`.`ano`),'%d/%m/%Y') desc;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
