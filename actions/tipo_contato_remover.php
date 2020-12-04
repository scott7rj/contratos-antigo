<?php
include_once "../classes/conexao.php";
include_once "../classes/tipo_contato.php";

	$id_tipo_contato = $_POST["id_tipo_contato"];

	$tipo_contato = new tipo_contato();
	$msg = $tipo_contato->remover($id_tipo_contato);

	echo $msg;
	//echo "1_Tipo de contato removido";
