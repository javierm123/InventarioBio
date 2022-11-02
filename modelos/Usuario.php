<?php 
//incluir la conexion de base de datos
require "../config/Conexion.php";
class Usuario{


	//implementamos nuestro constructor
public function __construct(){

}

public function listarp($usu_id){
	$sql="call sp_listar_permisos($usu_id)";
	return ejecutarConsultaSP($sql);
}


public function verificar($usu_login,$usu_clave){
	$sql="call sp_logeo('$usu_login','$usu_clave');";
    //return $sql;
	return ejecutarConsultaSP($sql);	
}

public function obten_motivos($id){
	$sql="CALL sp_catalgo('scpa', 0,0,$id);";
	return ejecutarConsultaSP($sql);
}

}

 ?>
