<?php
include_once "../classes/conexao.php";
include_once "../classes/tipo_contato.php";

	$nome_tipo_contato	= strtoupper(utf8_decode($_POST["tipo_contato"]));
	$usuario_alteracao	= $_POST["usuario_alteracao"];

	$tipo_contato = new tipo_contato();
	$msg = $tipo_contato->inserir($nome_tipo_contato, $usuario_alteracao);

	echo utf8_encode($msg);