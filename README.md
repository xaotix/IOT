# INTERNET OF THINGS

## Proposta
Construir uma aplicação utilizando os conceitos Edge, Fog e Nuvem para monitorar a temperatura de pessoas na entrada de um estabelecimento, afim de reconhecer possíveis focos de COVID-19 antes dos mesmos adentrarem o recinto.

## Integrantes:
- Daniel Maciel

- Israel Tasca da Luz

- Leonardo Maier

## Tecnologias usadas

Edge: TinkerCAD

Fog: .Net Framework, WPF

Nuvem: MySQL, React-Native, Expo

## Linguagens

C, C# e javascript


### Consideração utilizada para reconhecimento de febre

![N|Solid](https://github.com/xaotix/IOT/blob/main/IOT_Fog/Temperatua_Corporea.png)

Fonte:

https://www.minhavida.com.br/saude/temas/febre


### Requisitos

Instale os seguintes aplicativos:

#### Para os projetos em C#:Fog (WPF):

[IDE Microsoft Visual Studio Community 2019 ou superior](https://visualstudio.microsoft.com/pt-br/vs/community/)

#### Para a Nuvem - React Native e Api (.Net Core):

[Download Node.js](https://nodejs.org/en/download/)

Escolha o instalador para a sua plataforma (Sistema Operacional) e arquitetura do processador (32-bits ou 64-bits). 

Instalando o React-Native (Expo)

Sua instalação se dá da seguinte forma:

`
npm install expo-cli –global
`

Todos os passos seguintes, dependem da instalação do Expo.
Alternativamente para o EXPO, podemos usar o Create React
Native APP, através do seguinte comando:

`
npm install -g create-react-native-app
`


[Mysql v10.2 ou superior](https://www.mysql.com/downloads/)

[Postman versão Desktop (para fazer as requisições HTTP)](https://www.postman.com/downloads/)

[Heidi SQL (para consultar no banco de dados)](https://www.heidisql.com/download.php)

[.Net Core SDK 2.1.1](https://dotnet.microsoft.com/download/dotnet-core/2.1)

[Extensão Keyoti.Conveyor (para poder testar a API com o Postman)](https://marketplace.visualstudio.com/items?itemName=vs-publisher1448185.ConveyorbyKeyoti)



# Estrutura do projeto

## Arquitetura
![N|Solid](https://github.com/xaotix/IOT/blob/main/Outros/ARQUITETURA.png)


### 1 - Edge
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


### 2 Fog
O Fog foi desenvolvido em C#, utilizando WPF.
A aplicação lê a porta COM3 a cada 2 segundos e se o Arduíno enviar o valor de temperatura, o sistema grava os dados no banco.

![N|Solid](https://github.com/xaotix/IOT/blob/main/Outros/FOG.png)

### 2.1 - Fog de Dados
Foi utilizado MySQL 10.2

Script para criação das tabelas:

#### 2.1.1 - Fog - Tabela iot_log_acessos

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

#### 2.1.2 - Fog - View iot_log_temperaturas

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
#### 2.1.3 - Fog - View iot_log_acessos_febre
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

### 2.2 - Fog - Dataset Criado

Como não temos um Arduíno, geramos um dataset para poder simular e testar a ferramenta

![N|Solid](https://github.com/xaotix/IOT/blob/main/Outros/DATASET.png)


#### 2.2.1 - Fog - Fórmulas usadas para gerar dados aleatórios

````excel

''Gera 1 dia aleatório entre 1 e 29
=ALEATÓRIOENTRE(1;29)

''Gera 1 mês aleatório entre 9 e 11
=ALEATÓRIOENTRE(9;11)

''Gera 1 temperatura aleatória entre 35,5 e 38,5
=ALEATÓRIOENTRE(355;385)/10

''Gera 1 hora aleatória entre 08:00 e 19:00
=ALEATÓRIO()*(19-8)/24+7/24
````

## 3 Cloud
O Cloud foi implementado em React Native, utilizando javascript.
Ele consome uma API desenvolvida em .Net Core, que retorna os registros em JSON. Utilizando a biblioteca Axios.

### 3.1 - Cloud - Api .Net Core

### 3.1.1 - Cloud - Versões das Bibliotecas Usadas
Json 4.6.0

MySQL Data 6.10.9

Active Directory 4.5.0


### 3.1.2 - Cloud - Consumindo a API

As chamadas são feitas em POST. É obrigatório o uso dos dados de autenticação para poder rodar.

Exemplo de chamada:
````json
{
  "user": "usuario",
  "s": "senha",
  "Banco":"dlmdev",
  "Tabela": "iot_log_acessos_febre",
   "Filtros": 
    {
      "porta": "%%"
    }
}
````

Retorno:
````json
{
  "Status":"OK",
  "id_user":"1",
  "Nome":"NOME DO USUARIO",
  "Email":"email@email.com",
  "Mensagem":"",
  "Resultados":"21",
  "Valores": 
  [
    {
      "dia": "28",
      "mes": "11",
      "ano": "2020",
      "data": "28/11/2020 00:00:00",
      "pessoas": "3",
      "max": "38",
      "min": "38",
      "porta": "1"
    },
	...
  ]
}
````



### 3.2.1 - Cloud - Tela de Load
![N|Solid](https://github.com/xaotix/IOT/blob/main/Outros/NUVEM_1.png)
### 3.2.2 - Cloud - Tela de Login
![N|Solid](https://github.com/xaotix/IOT/blob/main/Outros/NUVEM_2.png)
### 3.2.3 - Cloud - Tela Inicial
![N|Solid](https://github.com/xaotix/IOT/blob/main/Outros/NUVEM_3.png)
### 3.2.4 - Cloud - Sobre
![N|Solid](https://github.com/xaotix/IOT/blob/main/Outros/NUVEM_4.png)
### 3.2.5 - Cloud - Tela de Registros Totais
![N|Solid](https://github.com/xaotix/IOT/blob/main/Outros/NUVEM_5.png)
### 3.2.6 - Cloud - Tela Status - Contendo o movimento na loja
![N|Solid](https://github.com/xaotix/IOT/blob/main/Outros/NUVEM_6.png)
### 3.2.7 - Cloud - Tela de Monitoramento de pessoas com febre
![N|Solid](https://github.com/xaotix/IOT/blob/main/Outros/NUVEM_7.png)
