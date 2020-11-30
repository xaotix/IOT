# INTERNET OF THINGS

Esse projeto tem por objeto demostrar o uso da IOT.

Integrantes:
- Daniel Maciel
- Israel Tasca da Luz
- Leonardo Maier


O projeto foi construído com o intuito de fazer a automação de um porta com sensor de temperatura (febre) e monitoramento do fluxo de pessoas.

## Edge
O Edge Computing foi construído em Arduino Uno, foi utilizado o [Tinkercad](https://www.tinkercad.com/) para simulação.

Foi utilizado os seguintes dispositivos:
  - Arduino Uno
  - Sensor de distancia ultrassônico
  - Servo motor
  - Sensor de temperatura
  - Tela de LCD
  - Potenciômetro
  - Buzzer
  - Led

![N|Solid](https://uploaddeimagens.com.br/images/002/983/504/original/ImagemProjeto.PNG?1606682879)

## Banco de Dados
Foi utilizado MySQL 10.2
Script para criação das tabelas:

#### Tabela iot_log_acessos

````mysql
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
````

#### View iot_log_temperaturas

````mysql
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
````
#### View iot_log_acessos_febre
````mysql
CREATE TABLE `iot_log_acessos_febre` (
	`dia` INT(11) NULL,
	`mes` INT(11) NULL,
	`ano` INT(11) NULL,
	`data` DATE NULL,
	`pessoas` BIGINT(21) NOT NULL,
	`max` VARCHAR(30) NULL COLLATE 'utf8_general_ci',
	`min` VARCHAR(30) NULL COLLATE 'utf8_general_ci',
	`porta` INT(11) NULL
) ENGINE=MyISAM;
````

### Dataset Criado
![N|Solid](https://github.com/xaotix/IOT/blob/main/Outros/DATASET.png)


## Fog
O Fog foi desenvolvido em C#, utilizando WPF.
A aplicação lê a porta COM3 a cada 2 segundos e se o Arduíno enviar o valor de temperatura, o sistema grava os dados no banco.

![N|Solid](https://github.com/xaotix/IOT/blob/main/Outros/FOG.png)

## Api .Net Core

### Versões das Bibliotecas Usadas
Json 4.6.0

MySQL Data 6.10.9

Active Directory 4.5.0


### Requisitos

Instale os seguintes aplicativos:

[IDE Microsoft Visual Studio Community 2019 ou superior](https://visualstudio.microsoft.com/pt-br/vs/community/)

[.Net Core SDK 2.1.1](https://dotnet.microsoft.com/download/dotnet-core/2.1)

[Extensão Keyoti.Conveyor (para poder testar a API com o Postman)](https://marketplace.visualstudio.com/items?itemName=vs-publisher1448185.ConveyorbyKeyoti)

[Postman versão Desktop (para fazer as requisições HTTP)](https://www.postman.com/downloads/)

[Heidi SQL (para consultar no banco de dados)](https://www.heidisql.com/download.php)

[Mysql v10.2 ou superior](https://www.mysql.com/downloads/)



## Cloud
O Cloud foi implementado em React Native, utilizando javascript.
Ele consome uma API desenvolvida em .Net Core, que retorna os registros em JSON. Utilizando a biblioteca Axios.

### Tela de Load
![N|Solid](https://github.com/xaotix/IOT/blob/main/Outros/NUVEM_1.png)
### Tela de Login
![N|Solid](https://github.com/xaotix/IOT/blob/main/Outros/NUVEM_2.png)
### Tela Inicial
![N|Solid](https://github.com/xaotix/IOT/blob/main/Outros/NUVEM_3.png)
### Sobre
![N|Solid](https://github.com/xaotix/IOT/blob/main/Outros/NUVEM_4.png)
### Tela de Registros Totais
![N|Solid](https://github.com/xaotix/IOT/blob/main/Outros/NUVEM_5.png)
### Tela Status - Contendo o movimento na loja
![N|Solid](https://github.com/xaotix/IOT/blob/main/Outros/NUVEM_6.png)
### Tela de Monitoramento de pessoas com febre
![N|Solid](https://github.com/xaotix/IOT/blob/main/Outros/NUVEM_7.png)



