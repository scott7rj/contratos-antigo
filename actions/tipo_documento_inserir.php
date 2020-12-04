<?php
include_once "../classes/conexao.php";
include_once "../classes/tipo_documento.php";

	$nm_tipo_documento    = strtoupper(utf8_decode($_POST["tipo_documento"]));
	$possui_validade 	  = $_POST["possui_validade"];
	$id_dominio_documento = $_POST["id_dominio_documento"];
	$usuario_alteracao	  = $_POST["usuario_alteracao"];

	$tipo_documento = new tipo_documento();
	$msg = $tipo_documento->inserir($nm_tipo_documento, $possui_validade, $id_dominio_documento, $usuario_alteracao);

	echo utf8_encode($msg);