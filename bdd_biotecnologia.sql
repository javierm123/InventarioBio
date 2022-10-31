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
  `cat_nombre` varchar(45) NOT NULL,
  `cat_descripcion` varchar(100) DEFAULT NULL,
  `cat_padre` int NOT NULL,
  `cat_codigo` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`cat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo`
--

LOCK TABLES `catalogo` WRITE;
/*!40000 ALTER TABLE `catalogo` DISABLE KEYS */;
INSERT INTO `catalogo` VALUES (1,'CATEGORIAS',NULL,0,NULL),(2,'TIPO USUARIO',NULL,0,NULL),(3,'DOCENTE',NULL,2,NULL),(4,'CORDINADOR',NULL,2,NULL),(5,'REACTIVOS',NULL,1,''),(6,'LIMPIEZA',NULL,1,''),(7,'MATERIALES',NULL,1,''),(8,'PAPELERIA',NULL,1,''),(9,'VIDRIOS',NULL,7,''),(10,'PLASTICOS',NULL,7,''),(11,'METALES',NULL,7,''),(12,'TAPAS',NULL,7,''),(13,'ESTADO',NULL,0,NULL),(14,'BUENO',NULL,13,NULL),(15,'MALO',NULL,13,NULL),(16,'PROBETA','500 ml',9,'MAT-001'),(17,'PROBETA','100 ml',9,'MAT-002'),(18,'PROBETA','50 ml',9,'MAT-003'),(19,'PROBETA ','25 ml',9,'MAT-004'),(20,'MATRAZ','500 ml',9,'MAT-005'),(21,'MATRAZ','100 ml',9,'MAT-006'),(22,'MATRAZ','25 ml',9,'MAT-007'),(23,'TUBO DE ENSAYO','GRANDE',9,'MAT-008'),(24,'TUBO DE ENSAYO','MEDIANO ',9,'MAT-009'),(25,'TUBO DE ENSAYO','PEQUEÑO',9,'MAT-010'),(26,'ERLENMEYER','250 ml',9,'MAT-011'),(27,'ERLENMEYER','100 ml',9,'MAT-012'),(28,'ERLENMEYER','50 ml',9,'MAT-013'),(29,'FRASCOS BUECOS','500 ml',9,'MAT-014'),(30,'FRASCOS BUECOS','250 ml',9,'MAT-015'),(31,'FRASCOS MERMELADA','GRANDES',9,'MAT-016'),(32,'FRASCOS MERMELADA','MEDIANAS',9,'MAT-017'),(33,'FRASCOS MERMELADA','PEQUEÑAS',9,'MAT-018'),(34,'FRASCOS MERMELADA','MINI',9,'MAT-019'),(35,'FRASCOS DE CAFE','GRANDE ',9,'MAT-020'),(36,'FRASCOS DE CAFE','MEDIANAS',9,'MAT-021'),(37,'AGITADOR MAGNETICO','PEQUEÑO',11,'MAT-022'),(38,'FRASCOS PARA MUESTRAS','MEDIANO',9,'MAT-023'),(39,'EMBUDOS','75 mm',10,'MAT-024'),(40,'PINZAS METALICAS','GRANDES',11,'MAT-025'),(41,'PINZAS METALICAS','MEDIANAS',11,'MAT-026'),(42,'VIDRIO DE RELOJ','GRANDES',9,'MAT-027'),(43,'PIPETAS','100 ml',9,'MAT-028'),(44,'PINZAS METALICAS PUNTA DOBLADA','GRANDES',11,'MAT-029'),(45,'MECHEROS','GENERAL',11,'MAT-030'),(46,'MANDO DE VISTURI N°4','GENERAL',11,'MAT-031'),(47,'MANGO DE VISTURI °3','GENERAL',11,'MAT-032'),(48,'VASOS PRESCIPITADOS','GRANDE LARGO 600 ml',9,'MAT-033'),(49,'VASOS PRESCIPITADOS','GRANDE ANCHO 600 ml',9,'MAT-034'),(50,'VASOS PRESCIPITADOS','100 ml',9,'MAT-035'),(51,'VASOS PRESCIPITADOS','50 ml',9,'MAT-036'),(52,'VASOS PRESCIPITADOS','25 ml',9,'MAT-037'),(53,'MORTEROS','GENERAL',10,'MAT-038'),(54,'MAZOS','GENERAL',10,'MAT-039'),(55,'COLADORES','GRANDE',11,'MAT-040'),(56,'COLADORES','MEDIANO',11,'MAT-041'),(57,'COLADORES','PEQUEÑOS',11,'MAT-042'),(58,'BANDEJA DE ALUMINIO','MEDIANA',10,'MAT-043'),(59,'BANDEJA PLASTICA PLANA','MEDIANA',10,'MAT-044'),(60,'BANDEJA PLASTICA PLANA','PEQUEÑA',10,'MAT-045'),(61,'BANDEJA PLASTICA GRANDE','GENERAL',10,'MAT-046'),(62,'GRADILLAS','GENERAL',10,'MAT-047'),(63,'MATRAZ','500 ml',12,'MAT-048'),(64,'MATRAZ','100 ml',12,'MAT-049'),(65,'MATRAZ','25 ml',12,'MAT-050'),(66,'TUBO DE ENSAYO','GRANDE',12,'MAT-051'),(67,'TUBO DE ENSAYO','MEDIANO',12,'MAT-052'),(68,'TUBO DE ENSAYO','PEQUEÑO',12,'MAT-053'),(69,'FRASCOS DE BUECOS','500 ml',12,'MAT-054'),(70,'FRASCOS DE BUECOS','250 ml',12,'MAT-055'),(71,'FRASCOS DE MERMELADA','EXTRA GRANDE',12,'MAT-056'),(72,'FRASCOS DE MERMELADA','GRANDE',12,'MAT-057'),(73,'FRASCOS DE MERMELADA','MEDIANO',12,'MAT-058'),(74,'FRASCOS DE MERMELADA','PEQUEÑO',12,'MAT-059'),(75,'FRASCO DE CAFE','GRANDE ',12,'MAT-060'),(76,'FRASCO DE CAFE','MEDIANO',12,'MAT-061'),(77,'FRASCO MUESTRAS','MEDIANO',12,'MAT-062');
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
  `cat_id_estado` int NOT NULL,
  PRIMARY KEY (`det_id`),
  KEY `don_detalle_idx` (`don_cedula`),
  KEY `fk_detalle_catalogo1_idx` (`cat_id`),
  KEY `det_cat_estado_idx` (`cat_id_estado`),
  CONSTRAINT `cat_det_estado` FOREIGN KEY (`cat_id_estado`) REFERENCES `catalogo` (`cat_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cat_det_nombre` FOREIGN KEY (`cat_id`) REFERENCES `catalogo` (`cat_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `don_detalle` FOREIGN KEY (`don_cedula`) REFERENCES `donaciones` (`don_cedula`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle`
--

LOCK TABLES `detalle` WRITE;
/*!40000 ALTER TABLE `detalle` DISABLE KEYS */;
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

-- Dump completed on 2022-10-31 14:44:18
