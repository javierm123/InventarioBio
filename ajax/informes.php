<?php 
require_once "../modelos/informes.php";
if (strlen(session_id())<1) 
	session_start();

$informe = new Informes();
$usu_id=$_SESSION["usu_id"];


switch ($_GET["op"]) {
	case 'guardaryeditar':
	//    echo $_SESSION['tmaterias'];<br />
        
        $carreras="";
		for($i=0; $i<$_SESSION['tmaterias'];$i++)
		  {
			  if ($i==0)
			     $carreras= $_POST['carr'.$i] ;
		      else
			     {
				  $pos = strpos($carreras, $_POST['carr'.$i]);
				  if ($pos === false)	 
			          $carreras= $carreras.", ".$_POST['carr'.$i] ;		 
				 }
		  }
		 try{ 

		$rspta=$informe->insertar_cab(0,$_SESSION["usu_id"],$_POST["mes"],$carreras,$_POST["periodo"],$_POST["dedicacion"],$_POST["titulo"]);	
    	$reg=$rspta->fetch_object(); 
		$_SESSION["inf"]=$reg->id;

	    for($i=0; $i<$_SESSION['tmaterias'];$i++)
		  {
			  $mat=explode("--", $_POST['mate'.$i]);
			  $rspta=$informe->insertar_act(0,$reg->id,$mat[0],$mat[2],$_POST['hor'.$i], $_POST['medios'.$i],$_POST['porcen'.$i],$_POST['obj'.$i]);	
     	  }
		for($i=0; $i<12;$i++)
		  {			  
		      $rspta=$informe->insertar_oact(0,$reg->id,$i,$_POST['horaso'.$i], $_POST['medioso'.$i],$_POST['objo'.$i]);
			 	
     	  }

        $rspta=$informe->insertar_ract(0,$reg->id,0,$_POST['invcarreras'], $_POST['invproyectos'],$_POST['invhoras'],$_POST['invobj']);
		
		$rspta=$informe->insertar_ract(0,$reg->id,1,$_POST['gcarreras'], $_POST['gproyectos'],$_POST['ghoras'],$_POST['gobj']);
		
		$rspta=$informe->insertar_ract(0,$reg->id,2,$_POST['situaciones'], '',0,'');
		
		$rspta=$informe->insertar_ract(0,$reg->id,3,$_POST['acciones'], '',0,'');
		echo $reg->id;
		 }
		catch (Exception $e) {
            echo 0; 
		}
		break;     
		
	

	case 'materias':
		$rspta=$informe->obten_materias($_SESSION['usu_id'],$_GET['periodo']);
		$_SESSION["peri"]=$_GET['periodo'];
    	$data=Array();
		$i=0;	
		$horas_clase=0;		
		while ($reg=$rspta->fetch_object()) {
		   	$data[]=array(
        	"0"=>'<textarea name="carr'.$i.'" id="carr'.$i.'" type="text"  rows="3" cols="20" readonly="readonly">'.$reg->carrera.'</textarea>',
			"1"=>'<textarea name="mate'.$i.'" id="mate'.$i.'" type="text" readonly="readonly" rows="3" cols="50">'.$reg->cat_id."--".$reg->cat_nombre."--".$reg->paralelo.'</textarea>',
			"2"=>'<input name="hor'.$i.'" id="hor'.$i.'" type="text"  size="3" value="'.$reg->horas.'" ></input>',
	        "3"=>'<textarea name="medios'.$i.'" id="medios'.$i.'" type="text" rows="3" size="3" />',
	        "4"=>'<input name="porcen'.$i.'" id="porcen'.$i.'" type="text" rows="3" cols="10"/>',
	        "5"=>'<textarea name="obj'.$i.'" id="obj'.$i.'" type="text" rows="3" cols="20" />'
	       );
		   $horas_clase=$horas_clase+$reg->horas;
		   $i++;
		}
		$results=array(
             "sEcho"=>1,//info para datatables
             "iTotalRecords"=>count($data),//enviamos el total de registros al datatable
             "iTotalDisplayRecords"=>count($data),//enviamos el total de registros a visualizar
             "aaData"=>$data); 
	
		$_SESSION['tmaterias']=$i;
    	echo json_encode($results);
		break;
	case 'obtenmaterias':
		$rspta=$informe->obten_materias_inf($_GET['idinfo'],$_SESSION['usu_id'],$_GET['peri']);
		$_SESSION["inf"]=$_GET['idinfo'];
		$data=Array();
		$i=0;	
		$horas_clase=0;		
		while ($reg=$rspta->fetch_object()) {
		   	$data[]=array(
        	"0"=>'<textarea name="carr'.$i.'" id="carr'.$i.'" type="text"  rows="3" cols="20" readonly="readonly">'.$reg->carrera.'</textarea>',
			"1"=>'<textarea name="mate'.$i.'" id="mate'.$i.'" type="text" readonly="readonly" rows="3" cols="20">'.$reg->cat_id."--".$reg->materia."--".$reg->iact_paralelo.'</textarea>',
			"2"=>'<input name="hor'.$i.'" id="hor'.$i.'" type="text" size="3" value="'.$reg->iact_hora.'" ></input>',
	        "3"=>'<textarea name="medios'.$i.'" id="medios'.$i.'" type="text" rows="3" cols="20" >'.$reg->iact_medio.'</textarea>',
	        "4"=>'<input name="porcen'.$i.'" id="porcen'.$i.'" type="text" rows="3"  value="'.$reg->iact_porce.'"/>',
	        "5"=>'<textarea name="obj'.$i.'" id="obj'.$i.'" type="text" rows="3" cols="20" >'.$reg->iact_obj.'</textarea>'
	       );
		   $horas_clase=$horas_clase+$reg->iact_hora;
		   $i++;
		}
		$results=array(
             "sEcho"=>1,//info para datatables
             "iTotalRecords"=>count($data),//enviamos el total de registros al datatable
             "iTotalDisplayRecords"=>count($data),//enviamos el total de registros a visualizar
             "aaData"=>$data); 
	
		$_SESSION['tmaterias']=$i;
    	echo json_encode($results);
		break;
	case 'informes':
		$rspta=$informe->obten_informes(1,$_SESSION['usu_id'],$_GET['periodo']);
		$_SESSION["peri"]=$_GET['periodo'];
	   	$data=Array();
		while ($reg=$rspta->fetch_object()) {
		   	$data[]=array(
        	"0"=>'<p align="center"><button id="sacainfo" type="button" class="btn btn-warning btn-xs" onclick="presentainforme('.$reg->inf_id.','.$reg->cat_id.')"><i class="fa fa-pencil-square-o"></i></button>
			<button id="sacainfo" type="button" class="btn btn-warning btn-xs" onclick="imprimeinforme('.$reg->inf_id.')"><i class="fa fa-list"></i></button>
			</p>',
			"1"=>$reg->inf_mes,
			"2"=>$reg->inf_carreras,
			"3"=>$reg->cat_nombre
	       );
   		$_SESSION['periodotexto']=$reg->cat_nombre;
		

		}
		$results=array(
             "sEcho"=>1,//info para datatables
             "iTotalRecords"=>count($data),//enviamos el total de registros al datatable
             "iTotalDisplayRecords"=>count($data),//enviamos el total de registros a visualizar
             "aaData"=>$data); 
		echo json_encode($results);
		break;
	
	
	case 'combo_periodos':			
			$rspta = $informe->combo(3);
			$op1= '<option value="---">-----</option>';
			while ($reg = $rspta->fetch_object()) {
				echo '<option value='.$reg->cat_id.'>'.$reg->cat_nombre.'</option>';
			}
			break;
	case 'resto':			
		$rspta=$informe->obt_ract($_GET['op1'],$_GET['idinfo'],$_GET['tipo']);
		$data1="" ;
		
		while ($reg=$rspta->fetch_row()) {
			$data1=$reg[3].'&'.$reg[4].'&'.$reg[5].'&'.$reg[6];
					
		  }
		echo json_encode($data1);
		break;
	case 'otras':
		$data1 = array();
	    if ($_GET['idinfo']==0)
		   {
	 	    for ($j=0; $j<13; $j++)
		      {
				$data1[$j][0]=0;
				$data1[$j][1]="";
				$data1[$j][2]="";
			
			  }
		   }
		else{   
			$rspta=$informe->obten_oact(1,$_GET['idinfo']);//$_SESSION["inf"]);
			$i=0; 
			while ($reg=$rspta->fetch_object()) {
				$data1[$i][0]=$reg->iot_horas;
				$data1[$i][1]=$reg->iot_medios;
				$data1[$i][2]=$reg->iot_obj;
				$i++;
			  }
		}
		$i=0;
		$data[$i]=array(
        	"0"=>'1',
			"1"=>'PREPARACI??N Y ACTUALIZACI??N DE CLASES, SEMINARIOS, TALLERES, ENTRE OTROS',
			"2"=>'<input name="horaso'.$i.'" id="horaso'.$i.'" type="text" value="'.$data1[$i][0].'" />',
			"3"=>'<textarea name="medioso'.$i.'" id="medioso'.$i.'" type="text">'.$data1[$i][1].' </textarea>',
	        "4"=>'<textarea name="objo'.$i.'" id="objo'.$i.'" type="text" />'.$data1[$i][2].' </textarea>'	
	       );
		$i++;   
		$data[$i]=array(
        	"0"=>'2',
			"1"=>'DISE??O Y ELABORACI??N DE LIBROS, MATERIAL DID??CTICO, GU??AS DOCENTES O PEA',
			"2"=>'<input name="horaso'.$i.'" id="horaso'.$i.'" type="text" value="'.$data1[$i][0].'"/>',
			"3"=>'<textarea name="medioso'.$i.'" id="medioso'.$i.'" type="text" >'.$data1[$i][1].' </textarea>',
	        "4"=>'<textarea name="objo'.$i.'" id="objo'.$i.'" type="text" >'.$data1[$i][2].' </textarea>'
	       );
		 $i++;
		$data[$i]=array(
        	"0"=>'3',
			"1"=>'ORIENTACI??N Y ACOMPA??AMIENTO A TRAV??S DE TUTOR??AS PRESENCIALES O VIRTUALES, INDIVIDUALES O GRUPALES',
			"2"=>'<input name="horaso'.$i.'" id="horaso'.$i.'" type="text" value="'.$data1[$i][0].'"/>',
			"3"=>'<textarea name="medioso'.$i.'" id="medioso'.$i.'" type="text" >'.$data1[$i][1].' </textarea>',
	        "4"=>'<textarea name="objo'.$i.'" id="objo'.$i.'" type="text" >'.$data1[$i][2].' </textarea>'
	       );
		$i++;   
		$data[$i]=array(
        	"0"=>'4',
			"1"=>'VISITAS DE CAMPO, TUTOR??AS, DOCENCIA EN SERVICIO Y FORMACI??N DUAL',
			"2"=>'<input name="horaso'.$i.'" id="horaso'.$i.'" type="text" value="'.$data1[$i][0].'"/>',
			"3"=>'<textarea name="medioso'.$i.'" id="medioso'.$i.'" type="text" >'.$data1[$i][1].' </textarea>',
	        "4"=>'<textarea name="objo'.$i.'" id="objo'.$i.'" type="text" >'.$data1[$i][2].' </textarea>'
	       );
		$i++;   
		$data[$i]=array(
        	"0"=>'5',
			"1"=>'DIRECCI??N, TUTOR??AS, SEGUIMIENTO Y EVALUACI??N DE PR??CTICAS O PASANT??AS PRE PROFESIONALES',
			"2"=>'<input name="horaso'.$i.'" id="horaso'.$i.'" type="text" value="'.$data1[$i][0].'"/>',
			"3"=>'<textarea name="medioso'.$i.'" id="medioso'.$i.'" type="text" >'.$data1[$i][1].' </textarea>',
	        "4"=>'<textarea name="objo'.$i.'" id="objo'.$i.'" type="text" >'.$data1[$i][2].' </textarea>'
	       );
		$i++;
		$data[$i]=array(
        	"0"=>'6',
			"1"=>'PREPARACI??N, ELABORACI??N, APLICACI??N Y CALIFICACI??N DE EX??MENES, TRABAJOS Y PR??CTICAS',
			"2"=>'<input name="horaso'.$i.'" id="horaso'.$i.'" type="text" value="'.$data1[$i][0].'"/>',
			"3"=>'<textarea name="medioso'.$i.'" id="medioso'.$i.'" type="text" >'.$data1[$i][1].' </textarea>',
	        "4"=>'<textarea name="objo'.$i.'" id="objo'.$i.'" type="text" >'.$data1[$i][2].' </textarea>'
	       );
		 $i++;
		 $data[$i]=array(
        	"0"=>'7',
			"1"=>'DIRECCI??N Y TUTOR??A DE TRABAJOS PARA LA OBTENCI??N DEL T??TULO, CON EXCEPCI??N DE TESIS DOCTORALES O DE MAESTR??AS DE INVESTIGACI??N',
			"2"=>'<input name="horaso'.$i.'" id="horaso'.$i.'" type="text" value="'.$data1[$i][0].'"/>',
			"3"=>'<textarea name="medioso'.$i.'" id="medioso'.$i.'" type="text" >'.$data1[$i][1].' </textarea>',
	        "4"=>'<textarea name="objo'.$i.'" id="objo'.$i.'" type="text" >'.$data1[$i][2].' </textarea>'
	       );
		$i++;
		$data[$i]=array(
        	"0"=>'8',
			"1"=>'DIRECCI??N Y PARTICIPACI??N DE PROYECTOS DE EXPERIMENTACI??N E INNOVACI??N DOCENTE',
			"2"=>'<input name="horaso'.$i.'" id="horaso'.$i.'" type="text" value="'.$data1[$i][0].'"/>',
			"3"=>'<textarea name="medioso'.$i.'" id="medioso'.$i.'" type="text" >'.$data1[$i][1].' </textarea>',
	        "4"=>'<textarea name="objo'.$i.'" id="objo'.$i.'" type="text" >'.$data1[$i][2].' </textarea>'
	       );
		$i++;
		 $data[$i]=array(
            "0"=>'9',
        	"1"=>'DISE??O E IMPARTICI??N DE CURSOS DE EDUCACI??N CONTINUA O DE CAPACITACI??N Y ACTUALIZACI??N',
			"2"=>'<input name="horaso'.$i.'" id="horaso'.$i.'" type="text" value="'.$data1[$i][0].'"/>',
			"3"=>'<textarea name="medioso'.$i.'" id="medioso'.$i.'" type="text" >'.$data1[$i][1].' </textarea>',
	        "4"=>'<textarea name="objo'.$i.'" id="objo'.$i.'" type="text" >'.$data1[$i][2].' </textarea>'
	       );
		$i++;   
		$data[$i]=array(
        	"0"=>'10',
			"1"=>'PARTICIPACI??N EN ACTIVIDADES DE PROYECTOS SOCIALES, ART??STICOS, PRODUCTIVOS Y EMPRESARIALES DE VINCULACI??N CON LA SOCIEDAD ARTICULADOS A LA DOCENCIA E INNOVACI??N EDUCATIVA;',
			"2"=>'<input name="horaso'.$i.'" id="horaso'.$i.'" type="text" value="'.$data1[$i][0].'"/>',
			"3"=>'<textarea name="medioso'.$i.'" id="medioso'.$i.'" type="text" >'.$data1[$i][1].' </textarea>',
	        "4"=>'<textarea name="objo'.$i.'" id="objo'.$i.'" type="text" >'.$data1[$i][2].' </textarea>'
	       );
			$i++;   
		$data[$i]=array(
        	"0"=>'11',
			"1"=>'PARTICIPACI??N Y ORGANIZACI??N DE COLECTIVOS ACAD??MICOS DE DEBATE, CAPACITACI??N O INTERCAMBIO DE METODOLOG??AS Y EXPERIENCIAS DE ENSE??ANZA;',
			"2"=>'<input name="horaso'.$i.'" id="horaso'.$i.'" type="text" value="'.$data1[$i][0].'"/>',
			"3"=>'<textarea name="medioso'.$i.'" id="medioso'.$i.'" type="text" >'.$data1[$i][1].' </textarea>',
	        "4"=>'<textarea name="objo'.$i.'" id="objo'.$i.'" type="text" >'.$data1[$i][2].' </textarea>'
	       );
			$i++;   
		$data[$i]=array(
        	"0"=>'12',
			"1"=>'USO PEDAG??GICO DE LA INVESTIGACI??N Y LA SISTEMATIZACI??N COMO SOPORTE O PARTE DE LA ENSE??ANZA;',
			"2"=>'<input name="horaso'.$i.'" id="horaso'.$i.'" type="text" value="'.$data1[$i][0].'"/>',
			"3"=>'<textarea name="medioso'.$i.'" id="medioso'.$i.'" type="text" >'.$data1[$i][1].' </textarea>',
	        "4"=>'<textarea name="objo'.$i.'" id="objo'.$i.'" type="text" >'.$data1[$i][2].' </textarea>'
	       );             
		$results=array(
             "sEcho"=>1,//info para datatables
             "iTotalRecords"=>count($data),//enviamos el total de registros al datatable
             "iTotalDisplayRecords"=>count($data),//enviamos el total de registros a visualizar
             "aaData"=>$data); 
		
    	echo json_encode($results);
		break;
	
}
 ?>