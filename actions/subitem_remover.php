<?php
include_once "../classes/conexao.php";
include_once "../classes/subitem.php";

	session_start();

	$id_subitem			= $_POST["id_subitem"];
	$usuario_alteracao	= $_SESSION['log_user'];

	$subitem = new subitem();
	$msg = $subitem->remover($id_subitem, $usuario_alteracao);

	echo utf8_encode($msg);
