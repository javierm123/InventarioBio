<?php 
session_start();
require_once "../modelos/donaciones.php";

$donadores=new donaciones();

$claveu=isset($_POST["claveu"])? limpiarCadena($_POST["claveu"]):"";
$det_id=isset($_POST["det_id"])? limpiarCadena($_POST["det_id"]):"";
$don_cedula=isset($_POST["don_cedula"])? limpiarCadena($_POST["don_cedula"]):"";
$don_nombre=isset($_POST["don_nombre"])? limpiarCadena($_POST["don_nombre"]):"";
$don_telefono=isset($_POST["don_telefono"])? limpiarCadena($_POST["don_telefono"]):"";
$don_correo=isset($_POST["don_correo"])? limpiarCadena($_POST["don_correo"]):"";
$don_direccion=isset($_POST["don_direccion"])? limpiarCadena($_POST["don_direccion"]):"";
$don_fecha=isset($_POST["don_fecha"])? limpiarCadena($_POST["don_fecha"]):"";
$cat_id=isset($_POST["cat_id"])? limpiarCadena($_POST["cat_id"]):"";
$cat_nombre=isset($_POST["cat_nombre"])? limpiarCadena($_POST["cat_nombre"]):"";
$cat_descripcion=isset($_POST["cat_descripcion"])? limpiarCadena($_POST["cat_descripcion"]):"";
$cat_id_estado=isset($_POST["cat_id_estado"])? limpiarCadena($_POST["cat_id_estado"]):"";
$det_cantidad=isset($_POST["det_cantidad"])? limpiarCadena($_POST["det_cantidad"]):"";
$det_fechacad=isset($_POST["det_fechacad"])? limpiarCadena($_POST["det_fechacad"]):"";
$det_fechadon=isset($_POST["det_fechadon"])? limpiarCadena($_POST["det_fechadon"]):"";



switch ($_GET["op"]) {
case 'salir':
	   //limpiamos la variables de la secion
	session_unset();

	  //destruimos la sesion
	session_destroy();
		  //redireccionamos al usu_login
	header("Location: ../index.php");
	break;
		
	case 'guardaryeditar':
	if (empty($idpersona)) {
		//$rspta=$donadores->insertar_donadores($don_cedula,$don_nombre,$don_telefono,$don_correo,$don_direccion,$don_fecha);
											 
		$rspta=$donadores->insertar_detalle($_POST["donadores"],$_POST["materialesdon"],$_POST["estado"],$det_cantidad,$det_fechacad,$det_fechadon);
		
			

		echo $rspta ? "Datos registrados correctamente" : "No se pudo registrar los datos";
	}
		/*
		
	}/*else{
         $rspta=$persona->editar($idpersona,$tipo_persona,$nombre,$tipo_documento,$num_documento,$direccion,$telefono,$email);
		echo $rspta ? "Datos actualizados correctamente" : "No se pudo actualizar los datos";
	}
		*/
		break;
		
		case 'listar':
	    $rspta=$donadores->listar();
		$data=Array();

		while ($reg=$rspta->fetch_object()) {
			$data[]=array(
		    "0"=>$reg->det_id,
            "1"=>$reg->don_nombre,
            "2"=>$reg->cat_nombre,
		    "3"=>$reg->cat_descripcion,
			"4"=>$reg->cat_id_estado,
			"5"=>$reg->det_cantidad,
			"6"=>$reg->det_fechacad,
			"7"=>$reg->det_fechadon
              );
		}
		$results=array(
             "sEcho"=>1,//info para datatables
             "iTotalRecords"=>count($data),//enviamos el total de registros al datatable
             "iTotalDisplayRecords"=>count($data),//enviamos el total de registros a visualizar
             "aaData"=>$data); 
		echo json_encode($results);
	    break;
		

		
	case 'combo_categoria':			
			$rspta = $donadores->obten_combo(1);
			while ($reg = $rspta->fetch_object()) {
				echo '<option value='.$reg->cat_id.'>'.$reg->cat_nombre.'</option>';
			}
			break;	
		
	case 'combo_subcategoria':			
			$rspta = $donadores->obten_combo(7);
			while ($reg = $rspta->fetch_object()) {
				echo '<option value='.$reg->cat_id.'>'.$reg->cat_nombre.'</option>';
			}
			break;	
		
	case 'combo_materiales':
		
			$rspta = $donadores->obten_materiales();
		echo'<option value="-1">Seleccione el Articulo </option>';
			while ($reg = $rspta->fetch_object()) {
				echo '<option value='.$reg->cat_id.'>'.$reg->cat_nombre.'-'.$reg->cat_descripcion.'</option>'
					;
			}
		
			break;
	case 'combo_estado':	
			$rspta = $donadores->obten_combo(13);
		echo'<option value="-1">Seleccione el Estado </option>';
			while ($reg = $rspta->fetch_object()) {
				echo '<option value='.$reg->cat_id.'>'.$reg->cat_nombre.'</option>'
					;
			}
			break;
		
		case 'combo_donadores':	
			$rspta = $donadores->combo_donadores();
		echo'<option value="-1">Seleccione el Donador </option>';
			while ($reg = $rspta->fetch_object()) {
				echo '<option value='.$reg->don_cedula.'>'.$reg->don_nombre.'</option>'
					;
			}
			break;


	
}
		
?>