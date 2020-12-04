<?php
include_once "../classes/conexao.php";
include_once "../classes/telefone.php";

	$id_empresa			= $_POST["id_empresa"];
	$id_tipo_contato	= $_POST["id_tipo_contato"];
	$numero_telefone	= str_replace(" ","", str_replace("-","", $_POST["telefone"]));
	$usuario_alteracao	= $_POST["usuario_alteracao"];

	$telefone = new telefone();
	$msg = $telefone->inserir($id_empresa, $id_tipo_contato, $numero_telefone, $usuario_alteracao);

	echo $msg;