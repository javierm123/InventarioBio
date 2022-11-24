<?php
//activamos almacenamiento en el buffer
ob_start();
session_start();
if (!isset($_SESSION['usu_nombre'])) {
  header("actas: login.html");
}else{

require 'header.php';
if ($_SESSION['Acceso']==0) {
 ?>
 
<div class="content-wrapper">
    <!-- Main content -->
    <section class="content">
      <!-- Default box -->
      <div class="row">
        <div class="col-md-12">
      <div class="box">
<div class="box-header with-border">
  <h1 class="box-title">Usos <button class="btn btn-success" onclick="mostrarform(true)" id="btnagregar"><i class="fa fa-plus-circle"></i>Agregar</button></h1>
  <div class="box-tools pull-right">
    
  </div>
</div>
<!--box-header-->
<!--centro-->
<div style="width:900" id="listadousos">
  <table id="tbllistado_usos"  class="table table-striped table-bordered table-condensed table-hover"> 
    <thead>
      <th>ID de uso</th>
      <th>Cantidad</th>
	  <th>Descripcion</th>
      <th>ID de usuario</th>
		<th>Editar</th>
		<th>Eliminar</th>
      
    </thead>
    <tbody>
    </tbody>   
  </table>
</div>
		  
<div class="panel-body" id="formulariousos">
  <form action="" name="formulario" id="formulario"  method="POST">
    <div class="form-group col-lg-6 col-md-5 col-xs-12">
      <label for="">Cantidad(*):</label>
      <input class="form-control" type="text" name="cat_nombre" id="cat_nombre" maxlength="100" placeholder="Cantidad" required>
    </div>
   
    <div class="form-group col-lg-6 col-md-6 col-xs-12">
      <label for="">Descripcion(*):</label>
      <input type="text" class="form-control" name="cat_descripcion" id="cat_descripcion" placeholder="Descripcion" maxlength="100">
    </div>
	 
     <div class="form-group col-lg-6 col-md-5 col-xs-12">
      <label for="">ID Usuario(*):</label>
      <select id="uso_id" name="uso_id" class="form-control selectpicker"></select>
    </div>
     
    <div class="form-group col-lg-12 col-md-12 col-sm-12 col-xs-12">
      <button class="btn btn-primary" type="submit" id="btnGuardar"><i class="fa fa-save"></i>Guardar</button>
      <button class="btn btn-danger" onclick="cancelarform()" type="button"><i class="fa fa-arrow-circle-left"></i> Cancelar</button>
    </div>
  </form>
</div>
		
</div>
<!--fin centro-->
      </div>
      </div>
      </div>
      <!-- /.box -->
    </section>
    <!-- /.content -->
  </div>
<?php 
}else{
 require 'noacceso.php'; 
}
require 'footer.php';
 ?>
 <script src="scripts/hmac-sha256.js"></script>
 <script src="scripts/usos.js"></script>
 <?php 
}
ob_end_flush();
  ?>
