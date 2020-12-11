<?php
include_once "../classes/conexao.php";
include_once "../classes/ateste.php";
include_once "../util/db_util.php";

session_start();

try {

	$id_ateste_pagamento = $_POST["id_ateste_pagamento"];
	$descricao 			 = DbUtil::removeAspasSimples(utf8_decode($_POST["descricao"]));
	$valor 				 = DbUtil::formataMonetarioParaDB($_POST["valor"]);
	$usuario_alteracao	 = $_SESSION['log_user'];

	$ateste = new ateste();
	$msg = $ateste->inserirParcelaSiplo($id_ateste_pagamento, $descricao, $valor, $usuario_alteracao);

	echo utf8_encode($msg);

} catch (Exception $e) {
	echo "0_".$e->getMessage();
}
