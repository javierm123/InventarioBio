var tabla;

//funcion que se ejecuta al inicio
function init(){
   mostrarform(false);
   listar();
   $("#formulario").on("submit",function(e){
   	guardaryeditar(e);
   })

   
//mostramos los combos
  $.post("../ajax/donadores.php?op=combo_categoria", function(r){
   	$("#categoria").html(r);
   	$("#categoria").selectpicker('refresh');
     });
	

	//
	$.post("../ajax/donadores.php?op=combo_subcategoria", function(r){
   	$("#subcategoria").html(r);
   	$("#subcategoria").selectpicker('refresh');
     });
	
	$.post("../ajax/donaciones.php?op=combo_materiales", function(r){
   	$("#materialesdon").html(r);
   	$("#materialesdon").selectpicker('refresh');
     });
	
	$.post("../ajax/donaciones.php?op=combo_estado", function(r){
   	$("#estado").html(r);
   	$("#estado").selectpicker('refresh');
     });
	
	$.post("../ajax/donaciones.php?op=combo_donadores", function(r){
   	$("#donadores").html(r);
   	$("#donadores").selectpicker('refresh');
     });
}

//funcion limpiar
function limpiar(){
	$("#usu_nombre").val("");
    $("#usu_cedula").val("");
	$("#usu_telefono").val("");
	$("#usu_correo").val("");
	$("#usu_cargo").val("");
	$("#usu_login").val("");
	$("#usu_clave").val("");
	$("#usu_id").val("");
	$("#claveu").val("");
}

//funcion mostrar formulario
function mostrarform(flag){
	limpiar();
	if(flag){
		$("#listadoregistros").SHOW();
		$("#formularioregistros").show();
		$("#btnGuardar").prop("disabled",false);
		$("#btnagregar").show();
	}else{
		$("#listadoregistros").show();
		$("#formularioregistros").show();
		$("#btnagregar").show();
	}
}

//cancelar form
function cancelarform(){
	limpiar();
	mostrarform(false);
}

//funcion listar
function listar(){
	tabla=$('#tbllistado').dataTable({
		"aProcessing": true,//activamos el procedimiento del datatable
		"aServerSide": true,//paginacion y filrado realizados por el server
		
		"ajax":
		{
			url:'../ajax/donaciones.php?op=listar',
			type: "get",
			dataType : "json",
			error:function(e){
				console.log(e.responseText);
			}
		},
		"bDestroy":true,
		"iDisplayLength":15,//paginacion
		"order":[[0,"desc"]]//ordenar (columna, orden)
	}).DataTable();
}
//funcion para guardaryeditar
function guardaryeditar(e){
     e.preventDefault();//no se activara la accion predeterminada 
     $("#btnGuardar").prop("disabled",true);
     var formData=new FormData($("#formulario")[0]);

     $.ajax({
     	url: "../ajax/donaciones.php?op=guardaryeditar",
     	type: "POST",
     	data: formData,
     	contentType: false,
     	processData: false,

     	success: function(datos){
     		bootbox.alert(datos);
     		mostrarform(false);
     		tabla.ajax.reload();
     	}
     });

     limpiar();
}
init();