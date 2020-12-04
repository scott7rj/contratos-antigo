<?php
include_once "../classes/conexao.php";
include_once "../classes/telefone.php";

	$id_telefone = $_POST["id_telefone"];

	$telefone = new telefone();
	$msg = $telefone->remover($id_telefone);

	echo $msg;