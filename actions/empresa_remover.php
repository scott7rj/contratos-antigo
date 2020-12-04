<?php
include_once "../classes/conexao.php";
include_once "../classes/empresa.php";

	$id_empresa			= $_POST["id_empresa"];
	$usuario_alteracao	= $_POST["usuario_alteracao"];

	$empresa = new empresa();
	$mensagem = $empresa->remover($id_empresa, $usuario_alteracao);

	echo utf8_encode($mensagem);
