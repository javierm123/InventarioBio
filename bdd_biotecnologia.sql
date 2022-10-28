-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: bdd_biotecnologia
-- ------------------------------------------------------
-- Server version	8.0.29

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
-- Table structure for table `catalogo`
--

DROP TABLE IF EXISTS `catalogo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo` (
  `cat_id` int NOT NULL,
  `cat_nombre` varchar(45) DEFAULT NULL,
  `cat_descripcion` varchar(100) DEFAULT NULL,
  `cat_padre` int DEFAULT NULL,
  PRIMARY KEY (`cat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo`
--

LOCK TABLES `catalogo` WRITE;
/*!40000 ALTER TABLE `catalogo` DISABLE KEYS */;
INSERT INTO `catalogo` VALUES (1,'CATEGORIAS',NULL,0),(2,'TIPOS DE USUARIO',NULL,0),(3,'DOCENTE',NULL,2),(4,'COORDINADOR',NULL,2),(5,'REACTIVOS',NULL,1),(6,'MATERIALES',NULL,1),(7,'LIMPIEZA',NULL,1),(8,'AGARES',NULL,1),(9,'PAPELERIA',NULL,1),(10,'VIDRIOS',NULL,6),(11,'PLASTICOS',NULL,6),(12,'METALES',NULL,6),(13,'TAPAS',NULL,6),(14,'ESTADO',NULL,0),(15,'BUEN ESTADO',NULL,14),(16,'MAL ESTADO',NULL,14),(17,'AGAR POWER','Descripcion de prueba',8);
/*!40000 ALTER TABLE `catalogo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle`
--

DROP TABLE IF EXISTS `detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle` (
  `det_id` int NOT NULL AUTO_INCREMENT,
  `det_cantidad` int NOT NULL,
  `det_fechacad` date NOT NULL,
  `don_cedula` int NOT NULL,
  `cat_id` int NOT NULL,
  PRIMARY KEY (`det_id`),
  KEY `don_detalle_idx` (`don_cedula`),
  KEY `fk_detalle_catalogo1_idx` (`cat_id`),
  CONSTRAINT `don_detalle` FOREIGN KEY (`don_cedula`) REFERENCES `donaciones` (`don_cedula`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_detalle_catalogo1` FOREIGN KEY (`cat_id`) REFERENCES `catalogo` (`cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle`
--

LOCK TABLES `detalle` WRITE;
/*!40000 ALTER TABLE `detalle` DISABLE KEYS */;
INSERT INTO `detalle` VALUES (1,100,'2022-12-30',1050518594,18);
/*!40000 ALTER TABLE `detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_usos`
--

DROP TABLE IF EXISTS `detalle_usos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_usos` (
  `detalle_det_id` int NOT NULL,
  `usos_uso_id` int NOT NULL,
  PRIMARY KEY (`detalle_det_id`,`usos_uso_id`),
  KEY `fk_detalle_has_usos_usos1_idx` (`usos_uso_id`),
  KEY `fk_detalle_has_usos_detalle1_idx` (`detalle_det_id`),
  CONSTRAINT `fk_detalle_has_usos_detalle1` FOREIGN KEY (`detalle_det_id`) REFERENCES `detalle` (`det_id`),
  CONSTRAINT `fk_detalle_has_usos_usos1` FOREIGN KEY (`usos_uso_id`) REFERENCES `usos` (`uso_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_usos`
--

LOCK TABLES `detalle_usos` WRITE;
/*!40000 ALTER TABLE `detalle_usos` DISABLE KEYS */;
INSERT INTO `detalle_usos` VALUES (1,1);
/*!40000 ALTER TABLE `detalle_usos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donaciones`
--

DROP TABLE IF EXISTS `donaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donaciones` (
  `don_cedula` int NOT NULL,
  `don_nombre` varchar(100) NOT NULL,
  `don_telefono` varchar(10) NOT NULL,
  `don_correo` varchar(50) NOT NULL,
  `don_direccion` varchar(100) NOT NULL,
  `don_fecha` date NOT NULL,
  PRIMARY KEY (`don_cedula`),
  UNIQUE KEY `don_cedula_UNIQUE` (`don_cedula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donaciones`
--

LOCK TABLES `donaciones` WRITE;
/*!40000 ALTER TABLE `donaciones` DISABLE KEYS */;
INSERT INTO `donaciones` VALUES (1234567891,'Martin Jacome','1234567891','prueba@gmail.com','dir prueba','2022-10-27');
/*!40000 ALTER TABLE `donaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usos`
--

DROP TABLE IF EXISTS `usos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usos` (
  `uso_id` int NOT NULL AUTO_INCREMENT,
  `uso_cantidad` int NOT NULL,
  `uso_descripcion` varchar(200) NOT NULL,
  `usu_cedula` int NOT NULL,
  PRIMARY KEY (`uso_id`),
  KEY `usos_usu_idx` (`usu_cedula`),
  CONSTRAINT `usos_usu` FOREIGN KEY (`usu_cedula`) REFERENCES `usuarios` (`usu_cedula`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usos`
--

LOCK TABLES `usos` WRITE;
/*!40000 ALTER TABLE `usos` DISABLE KEYS */;
INSERT INTO `usos` VALUES (1,10,'10 gramos de Agar Power',1050518594);
/*!40000 ALTER TABLE `usos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `usu_cedula` int NOT NULL,
  `usu_nombre` varchar(50) NOT NULL,
  `usu_apellido` varchar(50) NOT NULL,
  `usu_telefono` varchar(10) NOT NULL,
  `usu_usuario` varchar(45) NOT NULL,
  `usu_contraseña` varchar(45) NOT NULL,
  PRIMARY KEY (`usu_cedula`),
  UNIQUE KEY `usu_cedula_UNIQUE` (`usu_cedula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1234567891,'Alejandro','Muñoz','1234567891','alejos','123'),(1234567892,'Jostin','Aldaz','1234567892','jostin','123');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-27 23:57:27
