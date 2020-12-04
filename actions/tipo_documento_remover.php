<?php
include_once "../classes/conexao.php";
include_once "../classes/tipo_documento.php";

	$id_tipo_documento = $_POST["id_tipo_documento"];

	$tipo_documento = new tipo_documento();
	$msg = $tipo_documento->remover($id_tipo_documento);

	echo utf8_encode($msg);
