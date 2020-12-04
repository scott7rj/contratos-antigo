<?php
include_once "../classes/conexao.php";
include_once "../classes/compromisso_siplo.php";

	$id_compromisso_siplo = $_POST["id_compromisso_siplo"];

	$compromisso_siplo = new compromisso_siplo();
	$msg = $compromisso_siplo->remover($id_compromisso_siplo);

	echo utf8_encode($msg);
