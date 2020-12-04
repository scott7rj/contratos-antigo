<?php
include_once "../classes/conexao.php";
include_once "../classes/compromisso_siplo.php";

	$id_contrato 		= $_POST["id_contrato"];
	$compromisso_siplo	= strtoupper(str_replace("-","", str_replace("/", "", $_POST["compromisso_siplo"])));
	$usuario_alteracao	= $_POST["usuario_alteracao"];

	$cs = new compromisso_siplo();
	$msg = $cs->inserir($id_contrato, $compromisso_siplo, $usuario_alteracao);

	echo utf8_encode($msg);