-- --------------------------------------------------------
-- Servidor:                     10.54.0.90
-- Versão do servidor:           5.7.26-log - MySQL Community Server (GPL)
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              11.1.0.6116
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para assistenciatecnica
DROP DATABASE IF EXISTS `assistenciatecnica`;
CREATE DATABASE IF NOT EXISTS `assistenciatecnica` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `assistenciatecnica`;

-- Copiando estrutura para tabela assistenciatecnica.atualizacao
DROP TABLE IF EXISTS `atualizacao`;
CREATE TABLE IF NOT EXISTS `atualizacao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idobra` int(11) DEFAULT NULL,
  `versao_soft` varchar(50) DEFAULT NULL,
  `ultimo_report` datetime DEFAULT NULL,
  `user` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=998 DEFAULT CHARSET=utf8;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela assistenciatecnica.atualiza_mobile
DROP TABLE IF EXISTS `atualiza_mobile`;
CREATE TABLE IF NOT EXISTS `atualiza_mobile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `atualizarProd` int(11) NOT NULL DEFAULT '0',
  `atualizarProb` int(11) NOT NULL DEFAULT '0',
  `atualizarCorr` int(11) NOT NULL DEFAULT '0',
  `atualizarCau` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela assistenciatecnica.avancofisico
DROP TABLE IF EXISTS `avancofisico`;
CREATE TABLE IF NOT EXISTS `avancofisico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idPep` int(11) NOT NULL,
  `avanco` int(11) NOT NULL DEFAULT '0',
  `avanco_programado` int(11) NOT NULL DEFAULT '0',
  `data` date NOT NULL,
  `efetivo_programado` int(11) NOT NULL DEFAULT '0',
  `revisao` int(11) NOT NULL DEFAULT '0',
  `last_update` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPep`,`data`),
  UNIQUE KEY `id` (`id`),
  KEY `idPep` (`idPep`)
) ENGINE=InnoDB AUTO_INCREMENT=46693 DEFAULT CHARSET=utf8;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela assistenciatecnica.avanco_fisico_planejado
DROP TABLE IF EXISTS `avanco_fisico_planejado`;
CREATE TABLE IF NOT EXISTS `avanco_fisico_planejado` (
  `id_pep` int(11) NOT NULL,
  `data` date NOT NULL,
  `revisao` int(11) NOT NULL DEFAULT '0',
  `avanco` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_pep`,`data`,`revisao`),
  CONSTRAINT `FK__pep` FOREIGN KEY (`id_pep`) REFERENCES `pep` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para view assistenciatecnica.avanco_fisico_revisoes
DROP VIEW IF EXISTS `avanco_fisico_revisoes`;
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `avanco_fisico_revisoes` (
	`id_pedido` INT(11) NULL,
	`rev_atual` INT(11) NULL
) ENGINE=MyISAM;

-- Copiando estrutura para view assistenciatecnica.avanco_fisico_view
DROP VIEW IF EXISTS `avanco_fisico_view`;
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `avanco_fisico_view` (
	`id_pedido` INT(11) NULL,
	`id` INT(11) NOT NULL,
	`idPep` INT(11) NOT NULL,
	`avanco` INT(11) NOT NULL,
	`avanco_programado` INT(11) NOT NULL,
	`data` DATE NOT NULL,
	`efetivo_programado` INT(11) NOT NULL,
	`revisao` INT(11) NOT NULL,
	`last_update` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Copiando estrutura para função assistenciatecnica.avanco_planejado
DROP FUNCTION IF EXISTS `avanco_planejado`;
DELIMITER //
CREATE FUNCTION `avanco_planejado`(
	`i_id_pep` INT,
	`i_data` DATE
,
	`i_revisao` INT
) RETURNS int(11)
    READS SQL DATA
    COMMENT 'Retorna o avanco planejado até a data informada'
BEGIN 
DECLARE retorno int;
SELECT IFNULL(SUM(avanco_fisico_planejado.avanco), 0) into retorno FROM avanco_fisico_planejado WHERE avanco_fisico_planejado.id_pep = i_id_pep AND avanco_fisico_planejado.`data` <= i_data AND avanco_fisico_planejado.revisao = i_revisao ;
return retorno;
END//
DELIMITER ;

-- Copiando estrutura para função assistenciatecnica.avanco_real
DROP FUNCTION IF EXISTS `avanco_real`;
DELIMITER //
CREATE FUNCTION `avanco_real`(
	`i_id_pep` INT,
	`i_data` DATE

) RETURNS int(11)
BEGIN
DECLARE retorno int;
SELECT IFNULL(SUM(avancofisico.avanco), 0) into retorno FROM avancofisico WHERE avancofisico.idPep = i_id_pep AND avancofisico.`data` <= i_data;
return retorno;
END//
DELIMITER ;

-- Copiando estrutura para tabela assistenciatecnica.categoriadocumentos
DROP TABLE IF EXISTS `categoriadocumentos`;
CREATE TABLE IF NOT EXISTS `categoriadocumentos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categoria` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela assistenciatecnica.categoriasdis
DROP TABLE IF EXISTS `categoriasdis`;
CREATE TABLE IF NOT EXISTS `categoriasdis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categoria` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela assistenciatecnica.causa
DROP TABLE IF EXISTS `causa`;
CREATE TABLE IF NOT EXISTS `causa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idProblema` int(11) DEFAULT NULL,
  `descricao` text,
  `idStr` varchar(50) DEFAULT NULL,
  `lastUpdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_causa_problema` (`idProblema`),
  CONSTRAINT `FK_causa_problema` FOREIGN KEY (`idProblema`) REFERENCES `problema` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=177 DEFAULT CHARSET=utf8;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para view assistenciatecnica.causa_view
DROP VIEW IF EXISTS `causa_view`;
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `causa_view` (
	`id` INT(11) NOT NULL,
	`idProblema` INT(11) NULL,
	`descricao` TEXT NULL COLLATE 'utf8_general_ci',
	`idStr` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`lastUpdate` TIMESTAMP NULL,
	`num_correcoes` BIGINT(21) NULL
) ENGINE=MyISAM;

-- Copiando estrutura para tabela assistenciatecnica.chamado
DROP TABLE IF EXISTS `chamado`;
CREATE TABLE IF NOT EXISTS `chamado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idObra` int(11) DEFAULT NULL,
  `idSolicitante` int(11) DEFAULT NULL,
  `idContatoVisita` int(11) DEFAULT NULL,
  `idTecnicoSeguranca` int(11) DEFAULT NULL,
  `idsDocumentosNecessarios` text,
  `enviarDocumentos` int(11) DEFAULT NULL,
  `possuiAcessoCobertura` int(11) DEFAULT NULL,
  `necessidadeIntegracao` int(11) DEFAULT NULL,
  `diasHorasIntegracao` text,
  `status` int(11) DEFAULT NULL,
  `dataAbertura` date DEFAULT NULL,
  `dataFechamento` date DEFAULT NULL,
  `idSAP` varchar(50) DEFAULT NULL,
  `descricao` text NOT NULL,
  `observacao` text,
  `atendimentoInicial` date DEFAULT NULL,
  `congelado` int(11) DEFAULT '0',
  `comentarioCliente` text,
  `avaliacaoCliente` int(11) DEFAULT '0',
  `custoTerceirizacao` varchar(50) DEFAULT NULL,
  `custoEquipamento` varchar(50) DEFAULT NULL,
  `custoHoraTecnico` varchar(50) DEFAULT '54,13 ',
  `etapasLiberadas` text,
  `justificativaDesconsiderar` text,
  `desconsiderarIndicador` int(11) DEFAULT '0',
  `tempoFabricacao` int(11) DEFAULT NULL,
  `custoFrete` varchar(50) DEFAULT NULL,
  `gravidade` int(11) DEFAULT '1',
  `urgencia` int(11) DEFAULT '1',
  `tendencia` int(11) DEFAULT '1',
  `tipo_chamado` int(11) DEFAULT '1',
  `datas_mp` text,
  `lastUpdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idObra` (`idObra`)
) ENGINE=InnoDB AUTO_INCREMENT=3508 DEFAULT CHARSET=utf8;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para view assistenciatecnica.chamados_abertos
DROP VIEW IF EXISTS `chamados_abertos`;
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `chamados_abertos` (
	`nome` TEXT NULL COLLATE 'utf8_general_ci',
	`idSAP` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`dataAbertura` DATE NULL,
	`status` INT(11) NULL,
	`regiao` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`count_dias_programados` BIGINT(21) NULL
) ENGINE=MyISAM;

-- Copiando estrutura para view assistenciatecnica.chamado_view
DROP VIEW IF EXISTS `chamado_view`;
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `chamado_view` (
	`gravidade` INT(11) NULL,
	`urgencia` INT(11) NULL,
	`tendencia` INT(11) NULL,
	`id` INT(11) NOT NULL,
	`idObra` INT(11) NULL,
	`idSolicitante` INT(11) NULL,
	`idContatoVisita` INT(11) NULL,
	`idTecnicoSeguranca` INT(11) NULL,
	`idsDocumentosNecessarios` TEXT NULL COLLATE 'utf8_general_ci',
	`enviarDocumentos` INT(11) NULL,
	`possuiAcessoCobertura` INT(11) NULL,
	`necessidadeIntegracao` INT(11) NULL,
	`diasHorasIntegracao` TEXT NULL COLLATE 'utf8_general_ci',
	`status` INT(11) NULL,
	`dataAbertura` DATE NULL,
	`dataFechamento` DATE NULL,
	`num_fac` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`datas_mp` TEXT NULL COLLATE 'utf8_general_ci',
	`Setor` VARCHAR(2) NOT NULL COLLATE 'utf8mb4_general_ci',
	`tp` VARCHAR(2) NOT NULL COLLATE 'utf8mb4_general_ci',
	`descricao` TEXT NOT NULL COLLATE 'utf8_general_ci',
	`observacao` TEXT NULL COLLATE 'utf8_general_ci',
	`atendimentoInicial` DATE NULL,
	`congelado` INT(11) NULL,
	`comentarioCliente` TEXT NULL COLLATE 'utf8_general_ci',
	`avaliacaoCliente` INT(11) NULL,
	`custoTerceirizacao` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`custoEquipamento` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`custoHoraTecnico` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`etapasLiberadas` TEXT NULL COLLATE 'utf8_general_ci',
	`justificativaDesconsiderar` TEXT NULL COLLATE 'utf8_general_ci',
	`desconsiderarIndicador` INT(11) NULL,
	`tempoFabricacao` INT(11) NULL,
	`custoFrete` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`lastUpdate` TIMESTAMP NULL,
	`id_chamado` INT(11) NOT NULL,
	`nome` TEXT NULL COLLATE 'utf8_general_ci',
	`area_obra` INT(11) NULL,
	`blackList` INT(11) NULL,
	`total_horas` BIGINT(23) NULL,
	`count_dias_programados` BIGINT(21) NULL,
	`ultima_visita` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`tempo_atendimento` INT(8) NOT NULL,
	`tempo_espera` INT(7) NOT NULL,
	`custo_terceirizacao` DECIMAL(10,2) NOT NULL,
	`custo_equipamento` DECIMAL(10,2) NOT NULL,
	`custo_material` DECIMAL(10,2) NOT NULL,
	`custo_fretes` DECIMAL(10,2) NOT NULL,
	`custo_mao_de_obra` DECIMAL(11,2) NULL,
	`custo_total` DECIMAL(15,2) NULL
) ENGINE=MyISAM;

-- Copiando estrutura para tabela assistenciatecnica.classificacaochamados
DROP TABLE IF EXISTS `classificacaochamados`;
CREATE TABLE IF NOT EXISTS `classificacaochamados` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `r` int(11) NOT NULL DEFAULT '0',
  `g` int(11) NOT NULL DEFAULT '0',
  `b` int(11) NOT NULL DEFAULT '0',
  `max_value` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela assistenciatecnica.cliente
DROP TABLE IF EXISTS `cliente`;
CREATE TABLE IF NOT EXISTS `cliente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` text,
  `codigosap` varchar(50) DEFAULT NULL,
  `preferencial` int(11) DEFAULT '0',
  `cidade` varchar(50) DEFAULT NULL,
  `pais` varchar(50) DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `lastUpdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2388 DEFAULT CHARSET=utf8;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para view assistenciatecnica.cliente_view
DROP VIEW IF EXISTS `cliente_view`;
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `cliente_view` (
	`id` INT(11) NOT NULL,
	`nome` TEXT NULL COLLATE 'utf8_general_ci',
	`codigosap` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`preferencial` INT(11) NULL,
	`cidade` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`pais` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`estado` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`lastUpdate` TIMESTAMP NULL,
	`desc_cliente` MEDIUMTEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Copiando estrutura para tabela assistenciatecnica.codigos_erros
DROP TABLE IF EXISTS `codigos_erros`;
CREATE TABLE IF NOT EXISTS `codigos_erros` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) DEFAULT NULL,
  `programa` varchar(50) DEFAULT NULL,
  `erro` text,
  `solucao` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela assistenciatecnica.colaboradorat
DROP TABLE IF EXISTS `colaboradorat`;
CREATE TABLE IF NOT EXISTS `colaboradorat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) DEFAULT NULL,
  `ma` varchar(50) DEFAULT NULL,
  `idsFolgas` varchar(50) DEFAULT NULL,
  `funcao` int(11) DEFAULT NULL,
  `telefone` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `ativo` int(11) DEFAULT NULL,
  `telefoneEmergencia` varchar(50) DEFAULT ' ',
  `contato` varchar(50) DEFAULT '',
  `rg` varchar(50) DEFAULT '',
  `cpf` varchar(50) DEFAULT '',
  `dataNascimento` date DEFAULT NULL,
  `dataAdmissao` date DEFAULT NULL,
  `nCracha` varchar(50) DEFAULT '',
  `emailPessoal` varchar(50) DEFAULT '',
  `endereco` varchar(50) DEFAULT '',
  `cep` varchar(50) DEFAULT '',
  `placaCarro` varchar(50) DEFAULT '',
  `modeloCarro` varchar(50) DEFAULT '',
  `cnh` varchar(50) DEFAULT '',
  `validadeCnh` varchar(50) DEFAULT '',
  `nickName` varchar(50) DEFAULT '',
  `dispositivo_mobile` varchar(50) DEFAULT '',
  `lastUpdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela assistenciatecnica.colaboradorcliente
DROP TABLE IF EXISTS `colaboradorcliente`;
CREATE TABLE IF NOT EXISTS `colaboradorcliente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idObra` int(11) DEFAULT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `telefone` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `lastUpdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=220 DEFAULT CHARSET=utf8;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para view assistenciatecnica.colaborador_at_view
DROP VIEW IF EXISTS `colaborador_at_view`;
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `colaborador_at_view` (
	`id` INT(11) NOT NULL,
	`nome` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`idsFolgas` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`funcao` INT(11) NULL,
	`telefone` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`email` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`ativo` INT(11) NULL,
	`telefoneEmergencia` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`contato` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`rg` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`cpf` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`dataNascimento` DATE NULL,
	`dataAdmissao` DATE NULL,
	`nCracha` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`emailPessoal` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`endereco` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`cep` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`placaCarro` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`modeloCarro` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`cnh` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`validadeCnh` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`nickName` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`dispositivo_mobile` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`ma` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`lastUpdate` TIMESTAMP NULL,
	`ultima_programacao` DATE NULL,
	`dias_sem_folga` INT(7) NOT NULL
) ENGINE=MyISAM;

-- Copiando estrutura para tabela assistenciatecnica.comentario
DROP TABLE IF EXISTS `comentario`;
CREATE TABLE IF NOT EXISTS `comentario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idObra` int(11) DEFAULT NULL,
  `descricao` text,
  `predio` varchar(50) DEFAULT NULL,
  `localizacao` varchar(50) DEFAULT NULL,
  `enviarTecnico` int(11) DEFAULT '0',
  `autor` varchar(50) DEFAULT NULL,
  `idChamado` int(11) DEFAULT '0',
  `lastUpdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela assistenciatecnica.contratomontador
DROP TABLE IF EXISTS `contratomontador`;
CREATE TABLE IF NOT EXISTS `contratomontador` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idPedido` int(11) NOT NULL DEFAULT '0',
  `denominacao` varchar(50) NOT NULL DEFAULT '0',
  `tipoContrato` varchar(50) NOT NULL DEFAULT '0',
  `classificacao` int(11) NOT NULL DEFAULT '0',
  `identificadorObj` varchar(50) DEFAULT NULL,
  `compCtsTot` varchar(50) DEFAULT NULL,
  `planCtsProj` varchar(50) DEFAULT NULL,
  `nDocReferencia` varchar(50) DEFAULT NULL,
  `pedidoCompra` varchar(50) DEFAULT NULL,
  `classeCusto` varchar(50) DEFAULT NULL,
  `codFornecedor` varchar(50) DEFAULT NULL,
  `data` varchar(50) DEFAULT NULL,
  `LancamentoUsuario` varchar(50) DEFAULT NULL,
  `denominacaoDeObj` varchar(50) DEFAULT NULL,
  `saldoArmazenado` varchar(50) DEFAULT NULL,
  `itRef` varchar(50) DEFAULT NULL,
  `orcado` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_contratomontador_pedido` (`idPedido`),
  CONSTRAINT `FK_contratomontador_pedido` FOREIGN KEY (`idPedido`) REFERENCES `pedido` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2606 DEFAULT CHARSET=utf8;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para view assistenciatecnica.contratomontadorview
DROP VIEW IF EXISTS `contratomontadorview`;
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `contratomontadorview` (
	`categoria` TEXT NULL COLLATE 'utf8_general_ci',
	`fornecedor` VARCHAR(103) NOT NULL COLLATE 'utf8_general_ci',
	`IdObra` INT(11) NULL,
	`id` INT(11) NOT NULL,
	`idPedido` INT(11) NOT NULL,
	`denominacao` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`tipoContrato` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`classificacao` INT(11) NOT NULL,
	`identificadorObj` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`compCtsTot` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`planCtsProj` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`nDocReferencia` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`pedidoCompra` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`classeCusto` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`codFornecedor` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`data` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`LancamentoUsuario` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`denominacaoDeObj` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`saldoArmazenado` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`itRef` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`orcado` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`identificador` VARCHAR(152) NULL COLLATE 'utf8_general_ci',
	`VALOR_PED` DECIMAL(20,3) NULL,
	`VALOR_REQ` DECIMAL(20,3) NULL,
	`CONTRATO` DECIMAL(20,3) NULL,
	`CONTRATO_MONTADOR` DECIMAL(20,3) NULL,
	`Saldo` DECIMAL(20,3) NULL,
	`Faturado` DECIMAL(43,3) NOT NULL,
	`DISTRATO` DECIMAL(45,3) NULL
) ENGINE=MyISAM;

-- Copiando estrutura para tabela assistenciatecnica.contratoreceita
DROP TABLE IF EXISTS `contratoreceita`;
CREATE TABLE IF NOT EXISTS `contratoreceita` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pep` varchar(50) NOT NULL,
  `item` varchar(50) NOT NULL,
  `valor` varchar(50) NOT NULL,
  `saldoAFaturar` text NOT NULL,
  `valorDevolvido` varchar(50) DEFAULT NULL,
  `idObra` int(11) NOT NULL,
  `cotacao` varchar(50) DEFAULT NULL,
  `material` varchar(50) DEFAULT NULL,
  `ordemDeVenda` varchar(50) DEFAULT NULL,
  `descricao` varchar(50) DEFAULT NULL,
  `LancamentoUsuario` text,
  PRIMARY KEY (`id`),
  KEY `material` (`material`),
  KEY `ordemDeVenda` (`ordemDeVenda`),
  KEY `FK_contratoreceita_obra` (`idObra`),
  KEY `pep` (`pep`),
  CONSTRAINT `FK_contratoreceita_obra` FOREIGN KEY (`idObra`) REFERENCES `obra` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=282 DEFAULT CHARSET=utf8;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para view assistenciatecnica.contrato_receita_view
DROP VIEW IF EXISTS `contrato_receita_view`;
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `contrato_receita_view` (
	`pedido` VARCHAR(511) NULL COLLATE 'utf8_general_ci',
	`unique` VARCHAR(101) NOT NULL COLLATE 'utf8_general_ci',
	`id` INT(11) NOT NULL,
	`pep` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`item` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`valor` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`saldoAFaturar` TEXT NOT NULL COLLATE 'utf8_general_ci',
	`valorDevolvido` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`idObra` INT(11) NOT NULL,
	`cotacao` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`material` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`ordemDeVenda` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`descricao` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`LancamentoUsuario` TEXT NULL COLLATE 'utf8_general_ci',
	`Contratado` DECIMAL(20,2) NOT NULL,
	`Saldo` DECIMAL(21,2) NOT NULL,
	`Faturado` DECIMAL(42,2) NOT NULL,
	`IM` DATE NULL,
	`FM` DATE NULL
) ENGINE=MyISAM;

-- Copiando estrutura para view assistenciatecnica.controle_producao_montagem
DROP VIEW IF EXISTS `controle_producao_montagem`;
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `controle_producao_montagem` (
	`idObra` INT(11) NULL,
	`Obra` TEXT NULL COLLATE 'utf8_general_ci',
	`pedido` VARCHAR(113) NULL COLLATE 'utf8_general_ci',
	`Area/Peso` INT(11) NULL,
	`Engenheiro` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`Inicio Cliente` DATE NULL,
	`Fim Cliente` DATE NULL,
	`IM` DATE NULL,
	`FM` DATE NULL,
	`Avanco Real` DECIMAL(65,27) NULL
) ENGINE=MyISAM;

-- Copiando estrutura para view assistenciatecnica.avanco_fisico_revisoes
DROP VIEW IF EXISTS `avanco_fisico_revisoes`;
-- Removendo tabela temporária e criando a estrutura VIEW final
DROP TABLE IF EXISTS `avanco_fisico_revisoes`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `assistenciatecnica`.`avanco_fisico_revisoes` AS select `assistenciatecnica`.`pep`.`idPedido` AS `id_pedido`,max(`assistenciatecnica`.`avanco_fisico_planejado`.`revisao`) AS `rev_atual` from (`assistenciatecnica`.`avanco_fisico_planejado` left join `assistenciatecnica`.`pep` on((`assistenciatecnica`.`pep`.`id` = `assistenciatecnica`.`avanco_fisico_planejado`.`id_pep`))) group by `assistenciatecnica`.`pep`.`idPedido`;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
